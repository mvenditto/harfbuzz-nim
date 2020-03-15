import bindings/[
  hb_buffer,
  hb_common
]

type 
  Buffer* = ref object
    native*: ptr hb_buffer_t

  GlyphInfo* = ref object
    native: hb_glyph_info_t

  GlyphPosition* = ref object
    native: hb_glyph_position_t

  ContentType* {.pure.} = enum
    Invalid = HB_BUFFER_CONTENT_TYPE_INVALID, 
    Unicode = HB_BUFFER_CONTENT_TYPE_UNICODE,
    Glyphs = HB_BUFFER_CONTENT_TYPE_GLYPHS

  Direction* {.pure.} = enum
    Invalid = HB_DIRECTION_INVALID
    Ltr = HB_DIRECTION_LTR
    Rtl = HB_DIRECTION_RTL
    Ttb = HB_DIRECTION_TTB
    Bit = HB_DIRECTION_BTT

  BufferFlags* {.pure.} = enum
    Default = HB_BUFFER_FLAG_DEFAULT
    Bot = HB_BUFFER_FLAG_BOT
    Eot = HB_BUFFER_FLAG_EOT
    PreserveDefaultIgnorable = HB_BUFFER_FLAG_PRESERVE_DEFAULT_IGNORABLES
    RemoveDefaultIgnorables = HB_BUFFER_FLAG_REMOVE_DEFAULT_IGNORABLES
    DoNotInsertDottedCircle = HB_BUFFER_FLAG_DO_NOT_INSERT_DOTTED_CIRCLE

  ClusterLevel* {.pure.} = enum
    MonotoneGraphemes = HB_BUFFER_CLUSTER_LEVEL_MONOTONE_GRAPHEMES,
    MonotoneCharacters = HB_BUFFER_CLUSTER_LEVEL_MONOTONE_CHARACTERS,
    Characters = HB_BUFFER_CLUSTER_LEVEL_CHARACTERS
  
const
  DefaultClusterLevel* = ClusterLevel.MonotoneGraphemes
  
template cluster*(info: GlyphInfo): uint = info.native.cluster
template mask*(info: GlyphInfo): uint = info.native.mask
template codepoint*(info: GlyphInfo): uint = info.native.codepoint

template `cluster=`*(info: GlyphInfo, value: uint) = info.native.cluster = value.uint32
template `mask=`*(info: GlyphInfo, value: uint) = info.native.mask = value.hb_mask_t
template `codepoint=`*(info: GlyphInfo, value: uint) = info.native.codepoint = value.hb_codepoint_t

template xAdvance*(pos: GlyphPosition): int = pos.native.x_advance
template xOffset*(pos: GlyphPosition): int = pos.native.x_offset
template yAdvance*(pos: GlyphPosition): int = pos.native.y_advance
template yOffset*(pos: GlyphPosition): int = pos.native.y_offset

template `xAdvance=`*(pos: GlyphPosition, value: int) = pos.native.x_advance = value.hb_position_t
template `xOffset=`*(pos: GlyphPosition, value: int) = pos.native.x_offset = value.hb_position_t
template `yAdvance=`*(pos: GlyphPosition, value: int) = pos.native.y_advance = value.hb_position_t
template `yOffset=`*(pos: GlyphPosition, value: int) = pos.native.y_offset = value.hb_position_t

proc newBuffer*(): Buffer = Buffer(native: hb_buffer_create())

proc dispose*(buff: Buffer) = hb_buffer_destroy(buff.native)

template contentType*(buff: Buffer): ContentType = 
  hb_buffer_get_content_type(buff.native).ContentType

template `contentType=`*(buff: Buffer, contentType: ContentType) =
  hb_buffer_set_content_type(buff.native, contentType.hb_buffer_content_type_t)

template direction*(buff: Buffer): Direction = 
  hb_buffer_get_direction(buff.native).Direction

template `direction=`*(buff: Buffer, direction: Direction) =
  hb_buffer_set_direction(buff.native, cast[hb_direction_t](direction))

template flags*(buff: Buffer): BufferFlags = 
  hb_buffer_get_flags(buff.native).BufferFlags

template `flags=`*(buff: Buffer, direction: BufferFlags) =
  hb_buffer_set_flags(buff.native, cast[hb_buffer_flags_t](direction))

template clusterLevel*(buff: Buffer): ClusterLevel = 
  hb_buffer_get_cluster_level(buff.native).ClusterLevel

template `clusterLevel=`*(buff: Buffer, clusterLevel: ClusterLevel) =
  hb_buffer_set_cluster_level(buff.native, clusterLevel.hb_buffer_cluster_level_t)

template replacementCodepoint*(buff: Buffer): uint = 
  hb_buffer_get_replacement_codepoint(buff.native)

template `replacementCodepoint=`*(buff: Buffer, replacementCodepoint: uint) =
  hb_buffer_set_replacement_codepoint(buff.native, replacementCodepoint.hb_codepoint_t)

template invisibleGlyph*(buff: Buffer): uint = 
  hb_buffer_get_replacement_codepoint(buff.native)

template `invisibleGlyph=`*(buff: Buffer, invisibleGlyph: uint) =
  hb_buffer_set_replacement_codepoint(buff.native, invisibleGlyph.hb_codepoint_t)

template script*(buff: Buffer): uint32 = 
  hb_buffer_get_script(buff.native)

template `script=`*(buff: Buffer, script: uint32) =
  hb_buffer_set_script(buff.native, script.hb_script_t)

template length*(buff: Buffer): int = 
  hb_buffer_get_length(buff.native).int

template `length=`*(buff: Buffer, length: int) =
  discard hb_buffer_set_length(buff.native, length.cuint)

proc reset*(buff: Buffer) = 
  hb_buffer_reset(buff.native)

proc clearContents*(buff: Buffer) = 
  hb_buffer_clear_contents(buff.native)

proc add*(buff: Buffer, codepoint: int, cluster: int) =
  if buff.length != 0 and buff.contentType != ContentType.Unicode:
    raise newException(AssertionError, "Non empty buffer's ContentType must be of type Unicode.")
  if buff.contentType == ContentType.Glyphs:
    raise newException(AssertionError, "ContentType must not be of type Glyphs")

  hb_buffer_add(buff.native, codepoint.hb_codepoint_t, cluster.cuint)

proc addUtf8*(buff: Buffer, text: string, itemOffset: int, itemLength: int) =
  if itemOffset < 0: 
    raise newException(AssertionError, "ItemOffset must be non negative.")
  if buff.length != 0 and buff.contentType != ContentType.Unicode:
    raise newException(AssertionError, "Non empty buffer's ContentType must be of type Unicode.")
  if buff.contentType == ContentType.Glyphs:
    raise newException(AssertionError, "ContentType must not be of type Glyphs")
  hb_buffer_add_utf8(buff.native, text, text.len.cint, itemOffset.cuint, itemLength.cint)

proc addUtf8*(buff: Buffer, text: string) = addUtf8(buff, text, 0, -1)

proc addUtf16*(buff: Buffer, text: ptr uint16, length: int, itemOffset: int, itemLength: int) =
  if itemOffset < 0: 
    raise newException(AssertionError, "ItemOffset must be non negative.")
  if buff.length != 0 and buff.contentType != ContentType.Unicode:
    raise newException(AssertionError, "Non empty buffer's ContentType must be of type Unicode.")
  if buff.contentType == ContentType.Glyphs:
    raise newException(AssertionError, "ContentType must not be of type Glyphs")
  hb_buffer_add_utf16(buff.native, text, length.cint, itemOffset.cuint, itemLength.cint)

proc addUtf16*(buff: Buffer, text: seq[uint16], itemOffset: int, itemLength: int) =
  hb_buffer_add_utf16(buff.native, text[0].unsafeAddr, text.len.cint, itemOffset.cuint, itemLength.cint)

proc addUtf16*(buff: Buffer, text: string, itemOffset: int, itemLength: int) =
  buff.addUtf16(cast[ptr uint16](text[0].unsafeAddr), text.len, itemOffset, itemLength)

proc addUtf16*(buff: Buffer, text: string) = addUtf16(buff, text, 0, -1)

proc addUtf32*(buff: Buffer, text: ptr uint32, length: int, itemOffset: int, itemLength: int) =
  if itemOffset < 0: 
    raise newException(AssertionError, "ItemOffset must be non negative.")
  if buff.length != 0 and buff.contentType != ContentType.Unicode:
    raise newException(AssertionError, "Non empty buffer's ContentType must be of type Unicode.")
  if buff.contentType == ContentType.Glyphs:
    raise newException(AssertionError, "ContentType must not be of type Glyphs")
  hb_buffer_add_utf32(buff.native, text, length.cint, itemOffset.cuint, itemLength.cint)

proc addUtf32*(buff: Buffer, text: seq[uint32], itemOffset: int, itemLength: int) =
  hb_buffer_add_utf32(buff.native, text[0].unsafeAddr, text.len.cint, itemOffset.cuint, itemLength.cint)

proc addUtf32*(buff: Buffer, text: string, itemOffset: int, itemLength: int) =
  buff.addUtf32(cast[ptr uint32](text[0].unsafeAddr), text.len, itemOffset, itemLength)

proc addUtf32*(buff: Buffer, text: string) = addUtf32(buff, text, 0, -1)

proc guessSegmentProperties*(buff: Buffer) =
  if buff.contentType != ContentType.Unicode:
    raise newException(AssertionError, "ContentType must be of type Unicode.")
  hb_buffer_guess_segment_properties(buff.native)

proc getGlyphPositions*(buff: Buffer): seq[GlyphPosition] =
  var length: cuint = 0
  let positions
    = cast[ptr UncheckedArray[hb_glyph_position_t]](
      hb_buffer_get_glyph_positions(buff.native, length.addr))
  if length == 0 or isNil positions: return newSeq[GlyphPosition]()
  var x = newSeqOfCap[GlyphPosition](length)
  for i in 0..length - 1:
    x.add(GlyphPosition(native: positions[i]))
  return x

proc getGlyphInfos*(buff: Buffer): seq[GlyphInfo] =
  var length: cuint
  let infos = cast[ptr UncheckedArray[hb_glyph_info_t]](
      hb_buffer_get_glyph_infos(buff.native, length.addr)
  )
  if length <= 0 or isNil infos: return newSeq[GlyphInfo]()

  result = newSeqOfCap[GlyphInfo](length)
  for i in 0..length - 1:
    result.add(GlyphInfo(native: infos[i]))
  