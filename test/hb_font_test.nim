import unittest

import ../font
import ../face

import options
import hb_test_common

let(blob, _, _) = init()

suite "harfbuzz font test":

  test "should have deffault shapers":
    var face = newFace(blob, 0)
    var font = newFont(face)
    check(font.supportedShapers.contains("ot"))
    check(font.supportedShapers.contains("fallback"))
    face.dispose()
    font.dispose()

  test "should get glyphId by unicde":
    var face = newFace(blob, 0)
    var font = newFont(face)  
    var maybeGlyph = font.glyph('A')
    check(maybeGlyph.isSome and maybeGlyph.get() == 42u)

  test "should have default scale":
    var face = newFace(blob, 0)
    var font = newFont(face)
    let(xScale,yScale) = font.scale
    check(xScale == 2048)
    check(yScale == 2048)

  test "should get h glyph origin":
    var face = newFace(blob, 0)
    var font = newFont(face)
    let ho = font.horizontalGlyphOrigin(49u)
    check(ho.isSome())
    let (xOrigin,yOrigin) = ho.get()
    check(xOrigin == 0)
    check(yOrigin == 0)
  
  test "should get v glyph origin":
    var face = newFace(blob, 0)
    var font = newFont(face)
    let ho = font.verticalGlyphOrigin(49)
    check(ho.isSome())
    let (xOrigin,yOrigin) = ho.get()
    check(xOrigin == 557)
    check(yOrigin == 1022)

  test "should get h glyph advance":
    var face = newFace(blob, 0)
    var font = newFont(face)
    check(font.horizontalGlyphAdvance(49) == 1114)

  test "should get v glyph advance":
    var face = newFace(blob, 0)
    var font = newFont(face)
    check(font.verticalGlyphAdvance(49) == -2048)

  test "sould get v glyph advances":
    var face = newFace(blob, 0)
    var font = newFont(face)
    var glyphs = @[49u, 50u, 51u]
    var advances = font.verticalGlyphAdvances(glyphs)
    check(advances[0] == -2048)
    check(advances[1] == -2048)
    check(advances[2] == -2048)

  test "sould get h glyph advances":
    var face = newFace(blob, 0)
    var font = newFont(face)
    var glyphs = @[49.uint32, 50, 51]
    var advances = font.horizontalGlyphAdvances(glyphs)
    check(advances[0] == 1114)
    check(advances[1] == 514)
    check(advances[2] == 602)

  test "should get glyph name":
    var face = newFace(blob, 0)
    var font = newFont(face)
    var name = font.getGlyphName(49)
    check(name.isSome() and name.get() == "H")

  test "should get glyph from name":
    var face = newFace(blob, 0)
    var font = newFont(face)
    var name = font.getGlyphFromName("H")
    check(name.isSome() and name.get() == 49)
