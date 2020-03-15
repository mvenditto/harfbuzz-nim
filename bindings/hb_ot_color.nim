when defined(Linux):
  const dynlibhb_ot_color_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}

import hb_face
import hb_blob
import hb_font
import hb_common

type 
    hb_ot_name_id_t* = uint32

proc hb_ot_color_has_palettes*(face: ptr hb_face_t): bool {.cdecl,
    importc: "hb_ot_color_has_palettes", dynlib: dynlibhb_ot_color_post.}
proc hb_ot_color_palette_get_count*(face: ptr hb_face_t): cuint {.cdecl,
    importc: "hb_ot_color_palette_get_count", dynlib: dynlibhb_ot_color_post.}
proc hb_ot_color_palette_get_name_id*(face: ptr hb_face_t; palette_index: cuint): hb_ot_name_id_t {.
    cdecl, importc: "hb_ot_color_palette_get_name_id",
    dynlib: dynlibhb_ot_color_post.}
proc hb_ot_color_palette_color_get_name_id*(face: ptr hb_face_t; color_index: cuint): hb_ot_name_id_t {.
    cdecl, importc: "hb_ot_color_palette_color_get_name_id",
    dynlib: dynlibhb_ot_color_post.}

type
  hb_ot_color_palette_flags_t* {.size: sizeof(cint).} = enum
    HB_OT_COLOR_PALETTE_FLAG_DEFAULT = 0x00000000,
    HB_OT_COLOR_PALETTE_FLAG_USABLE_WITH_LIGHT_BACKGROUND = 0x00000001,
    HB_OT_COLOR_PALETTE_FLAG_USABLE_WITH_DARK_BACKGROUND = 0x00000002


proc hb_ot_color_palette_get_flags*(face: ptr hb_face_t; palette_index: cuint): hb_ot_color_palette_flags_t {.
    cdecl, importc: "hb_ot_color_palette_get_flags", dynlib: dynlibhb_ot_color_post.}
proc hb_ot_color_palette_get_colors*(face: ptr hb_face_t; palette_index: cuint;
                                    start_offset: cuint; color_count: ptr cuint;
                                    colors: ptr hb_color_t): cuint {.cdecl,
    importc: "hb_ot_color_palette_get_colors", dynlib: dynlibhb_ot_color_post.}

proc hb_ot_color_has_layers*(face: ptr hb_face_t): bool {.cdecl,
    importc: "hb_ot_color_has_layers", dynlib: dynlibhb_ot_color_post.}

type
  hb_ot_color_layer_t* {.bycopy.} = object
    glyph*: hb_codepoint_t
    color_index*: cuint


proc hb_ot_color_glyph_get_layers*(face: ptr hb_face_t; glyph: hb_codepoint_t;
                                  start_offset: cuint; layer_count: ptr cuint;
                                  layers: ptr hb_ot_color_layer_t): cuint {.cdecl,
    importc: "hb_ot_color_glyph_get_layers", dynlib: dynlibhb_ot_color_post.}

proc hb_ot_color_has_svg*(face: ptr hb_face_t): bool {.cdecl,
    importc: "hb_ot_color_has_svg", dynlib: dynlibhb_ot_color_post.}
proc hb_ot_color_glyph_reference_svg*(face: ptr hb_face_t; glyph: hb_codepoint_t): ptr hb_blob_t {.
    cdecl, importc: "hb_ot_color_glyph_reference_svg",
    dynlib: dynlibhb_ot_color_post.}

proc hb_ot_color_has_png*(face: ptr hb_face_t): bool {.cdecl,
    importc: "hb_ot_color_has_png", dynlib: dynlibhb_ot_color_post.}
proc hb_ot_color_glyph_reference_png*(font: ptr hb_font_t; glyph: hb_codepoint_t): ptr hb_blob_t {.
    cdecl, importc: "hb_ot_color_glyph_reference_png",
    dynlib: dynlibhb_ot_color_post.}