import bindings/[
  hb_font,
  hb_common,
  hb_shape,
  hb_ot_font
]

import options

import common
import face
import buffer

import sequtils
import strutils
import sugar

type
  Font* = ref object
    native: ptr hb_font_t
    parent*: Font

  FontExtents* = ref object
    native: ptr hb_font_extents_t

  Feature* = ref object
    native: ptr hb_feature_t

const
  NameBufferLength = 128

proc newFont*(face: Face): Font =
  Font(native: hb_font_create(face.native))

proc dispose*(font: Font) = hb_font_destroy(font.native)

proc newFont*(parent: Font): Font =
  Font(
    native: hb_font_create_sub_font(parent.native), 
    parent: parent
  )

proc supportedShapers*(font: Font): seq[string] =
  let shapers = hb_shape_list_shapers()
  cstringArrayToSeq(shapers)

proc scale*(font: Font): (int,int) =
  var(xScale,yScale) = (0.cint, 0.cint)
  hb_font_get_scale(font.native, xScale.addr, yScale.addr)
  return (xScale.int, yScale.int)

proc `scale=`*(font: Font, newScale: (int, int)) =
  let(xScale,yScale)=newScale
  hb_font_set_scale(font.native, xScale.cint, yScale.cint)

proc horizontalfontExtents*(font: Font): Option[FontExtents] =
  var extents: ptr hb_font_extents_t
  if hb_font_get_h_extents(font.native, extents):
    return some(FontExtents(native: extents))
  return none(FontExtents)

proc verticalfontExtents*(font: Font): Option[FontExtents] =
  var extents: ptr hb_font_extents_t
  if hb_font_get_v_extents(font.native, extents):
    return some(FontExtents(native: extents))
  return none(FontExtents)

proc nominalGlyph*(font: Font, unicode: uint): Option[uint] =
  var glyph: hb_codepoint_t = 0
  if hb_font_get_nominal_glyph(font.native, unicode.cuint, glyph.addr):
    return some(cast[uint](glyph))
  return none(uint)

proc variationGlyph*(font: Font, variation: uint, unicode: uint): Option[uint] =
  var glyph: hb_codepoint_t = 0
  if hb_font_get_variation_glyph(font.native, unicode.cuint, variation.cuint, glyph.addr):
    return some(cast[uint](glyph))
  return none(uint)

proc variationGlyph*(font: Font, unicode: uint): Option[uint] =
  variationGlyph(font, 0, unicode)

proc glyph*(font: Font, unicode, variation: uint): Option[uint] =
  var glyph: hb_codepoint_t = 0
  if hb_font_get_glyph(font.native, unicode.cuint, variation.cuint, glyph.addr):
    return some(cast[uint](glyph))
  return none(uint)

proc glyph*(font: Font, unicode: uint): Option[uint] =
  glyph(font, 0, unicode)

proc glyph*(font: Font, unicode: char): Option[uint] =
  glyph(font, 0, unicode.uint)

proc horizontalGlyphAdvance*(font: Font, glyph: uint): int =
  hb_font_get_glyph_h_advance(font.native, glyph.hb_codepoint_t)

proc verticalGlyphAdvance*(font: Font, glyph: uint): int =
  hb_font_get_glyph_v_advance(font.native, glyph.hb_codepoint_t)

proc verticalGlyphAdvances*(font: Font, glyphs: openArray[uint]): seq[int] =
  var firstAdvance: hb_position_t = 0
  hb_font_get_glyph_v_advances(
    font.native,
    glyphs.len.cuint,
    cast[ptr hb_codepoint_t](glyphs[0].unsafeAddr), 
    4,
    firstAdvance.addr,
    4 
  )
  var advances = newSeqUninitialized[int32](glyphs.len)

  copyMem(advances[0].unsafeAddr, firstAdvance.addr, sizeof(int32) * glyphs.len)

  advances.map(x => x.int)

proc horizontalGlyphAdvances*(font: Font, glyphs: seq[uint32]): seq[int] =
  var firstAdvance: hb_position_t = 0

  hb_font_get_glyph_h_advances(
    font.native,
    glyphs.len.cuint,
    glyphs[0].unsafeAddr, 
    sizeof(hb_position_t).cuint,
    firstAdvance.addr,
    sizeof(hb_position_t).cuint
  )

  var advances = newSeqUninitialized[int32](glyphs.len)
  copyMem(advances[0].unsafeAddr, firstAdvance.addr, sizeof(int32) * glyphs.len)
  advances.map(x => x.int)

proc horizontalGlyphOrigin*(font: Font, glyph: uint): Option[(int,int)] =
  var x: hb_position_t = 0
  var y: hb_position_t = 0
  if hb_font_get_glyph_h_origin(font.native, glyph.hb_codepoint_t, x.addr, y.addr):
    return some((x.int, y.int))
  return none((int,int))
  
proc verticalGlyphOrigin*(font: Font, glyph: uint): Option[(int,int)] =
  var x: hb_position_t = 0
  var y: hb_position_t = 0
  if hb_font_get_glyph_v_origin(font.native, glyph.hb_codepoint_t, x.addr, y.addr):
    return some((x.int, y.int))
  return none((int,int))

proc setFunctionsOpenType*(font: Font) = hb_ot_font_set_funcs(font.native)

proc getGlyphName*(font: Font, glyph: uint): Option[string] =
  var name = newString(NameBufferLength)
  if hb_font_get_glyph_name(font.native, glyph.hb_codepoint_t, name, NameBufferLength.cuint):
    return some(name.split('\x00')[0])
  none(string)

proc getGlyphFromName*(font: Font, glyphName: string): Option[uint] =
  var glyph: hb_codepoint_t = 0
  if hb_font_get_glyph_from_name(font.native, glyphName, glyphName.len.cint, glyph.addr):
    return some(glyph.uint)
  return none(uint)

proc getGlyphFromString*(font: Font, str: string): Option[uint] =
  var glyph: hb_codepoint_t = 0
  if hb_font_glyph_from_string(font.native, str, -1, glyph.addr):
    return some(glyph.uint)
  return none(uint)

proc glyphToString*(font: Font, glyph: uint): string =
  var name = newString(NameBufferLength)
  hb_font_glyph_to_string(font.native, glyph.hb_codepoint_t, name, NameBufferLength.cuint)
  return name.split('\x00')[0]

proc shape*(font: Font, buffer: Buffer, features: seq[Feature], shapers: seq[string]) =
  # TODO: better checks
  assert not isNil buffer
  assert buffer.direction != Direction.Invalid
  assert buffer.contentType == ContentType.Unicode

  var tmp = features.map(f => f.native[])
  var cShapers = allocCStringArray(shapers)
  var featuresPtr = if features.len == 0: nil else: tmp[0].unsafeAddr
  var shapersPtr = if shapers.len == 0: nil else: cShapers

  discard hb_shape_full(
    font.native,
    buffer.native,
    featuresPtr,
    features.len.cuint,
    shapersPtr
  )

  deallocCStringArray(cShapers)

proc shape*(font: Font, buffer: Buffer) =
  font.shape(buffer, newSeq[Feature](), newSeq[string]())