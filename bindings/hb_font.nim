when defined(Linux):
  const dynlibhb_font_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}

import hb_common
import hb_face
import hb_draw

type
    hb_font_t* = object
    hb_font_funcs_t* = object


proc hb_font_funcs_create*(): ptr hb_font_funcs_t {.cdecl,
    importc: "hb_font_funcs_create", dynlib: dynlibhb_font_post.}
proc hb_font_funcs_get_empty*(): ptr hb_font_funcs_t {.cdecl,
    importc: "hb_font_funcs_get_empty", dynlib: dynlibhb_font_post.}
proc hb_font_funcs_reference*(ffuncs: ptr hb_font_funcs_t): ptr hb_font_funcs_t {.
    cdecl, importc: "hb_font_funcs_reference", dynlib: dynlibhb_font_post.}
proc hb_font_funcs_destroy*(ffuncs: ptr hb_font_funcs_t) {.cdecl,
    importc: "hb_font_funcs_destroy", dynlib: dynlibhb_font_post.}
proc hb_font_funcs_set_user_data*(ffuncs: ptr hb_font_funcs_t;
                                 key: ptr hb_user_data_key_t; data: pointer;
                                 destroy: hb_destroy_func_t; replace: bool): bool {.
    cdecl, importc: "hb_font_funcs_set_user_data", dynlib: dynlibhb_font_post.}
proc hb_font_funcs_get_user_data*(ffuncs: ptr hb_font_funcs_t;
                                 key: ptr hb_user_data_key_t): pointer {.cdecl,
    importc: "hb_font_funcs_get_user_data", dynlib: dynlibhb_font_post.}
proc hb_font_funcs_make_immutable*(ffuncs: ptr hb_font_funcs_t) {.cdecl,
    importc: "hb_font_funcs_make_immutable", dynlib: dynlibhb_font_post.}
proc hb_font_funcs_is_immutable*(ffuncs: ptr hb_font_funcs_t): bool {.cdecl,
    importc: "hb_font_funcs_is_immutable", dynlib: dynlibhb_font_post.}

type
  hb_font_extents_t* {.bycopy.} = object
    ascender*: hb_position_t
    descender*: hb_position_t
    line_gap*: hb_position_t
    reserved9*: hb_position_t
    reserved8*: hb_position_t
    reserved7*: hb_position_t
    reserved6*: hb_position_t
    reserved5*: hb_position_t
    reserved4*: hb_position_t
    reserved3*: hb_position_t
    reserved2*: hb_position_t
    reserved1*: hb_position_t



type
  hb_glyph_extents_t* {.bycopy.} = object
    x_bearing*: hb_position_t
    y_bearing*: hb_position_t
    width*: hb_position_t
    height*: hb_position_t



type
  hb_font_get_font_extents_func_t* = proc (font: ptr hb_font_t; font_data: pointer;
                                        extents: ptr hb_font_extents_t;
                                        user_data: pointer): bool {.cdecl.}
  hb_font_get_font_h_extents_func_t* = hb_font_get_font_extents_func_t
  hb_font_get_font_v_extents_func_t* = hb_font_get_font_extents_func_t
  hb_font_get_nominal_glyph_func_t* = proc (font: ptr hb_font_t; font_data: pointer;
      unicode: hb_codepoint_t; glyph: ptr hb_codepoint_t; user_data: pointer): bool {.
      cdecl.}
  hb_font_get_variation_glyph_func_t* = proc (font: ptr hb_font_t; font_data: pointer;
      unicode: hb_codepoint_t; variation_selector: hb_codepoint_t;
      glyph: ptr hb_codepoint_t; user_data: pointer): bool {.cdecl.}
  hb_font_get_nominal_glyphs_func_t* = proc (font: ptr hb_font_t; font_data: pointer;
      count: cuint; first_unicode: ptr hb_codepoint_t; unicode_stride: cuint;
      first_glyph: ptr hb_codepoint_t; glyph_stride: cuint; user_data: pointer): cuint {.
      cdecl.}
  hb_font_get_glyph_advance_func_t* = proc (font: ptr hb_font_t; font_data: pointer;
      glyph: hb_codepoint_t; user_data: pointer): hb_position_t {.cdecl.}
  hb_font_get_glyph_h_advance_func_t* = hb_font_get_glyph_advance_func_t
  hb_font_get_glyph_v_advance_func_t* = hb_font_get_glyph_advance_func_t
  hb_font_get_glyph_advances_func_t* = proc (font: ptr hb_font_t; font_data: pointer;
      count: cuint; first_glyph: ptr hb_codepoint_t; glyph_stride: cuint;
      first_advance: ptr hb_position_t; advance_stride: cuint; user_data: pointer) {.
      cdecl.}
  hb_font_get_glyph_h_advances_func_t* = hb_font_get_glyph_advances_func_t
  hb_font_get_glyph_v_advances_func_t* = hb_font_get_glyph_advances_func_t
  hb_font_get_glyph_origin_func_t* = proc (font: ptr hb_font_t; font_data: pointer;
                                        glyph: hb_codepoint_t;
                                        x: ptr hb_position_t; y: ptr hb_position_t;
                                        user_data: pointer): bool {.cdecl.}
  hb_font_get_glyph_h_origin_func_t* = hb_font_get_glyph_origin_func_t
  hb_font_get_glyph_v_origin_func_t* = hb_font_get_glyph_origin_func_t
  hb_font_get_glyph_kerning_func_t* = proc (font: ptr hb_font_t; font_data: pointer;
      first_glyph: hb_codepoint_t; second_glyph: hb_codepoint_t; user_data: pointer): hb_position_t {.
      cdecl.}
  hb_font_get_glyph_h_kerning_func_t* = hb_font_get_glyph_kerning_func_t
  hb_font_get_glyph_extents_func_t* = proc (font: ptr hb_font_t; font_data: pointer;
      glyph: hb_codepoint_t; extents: ptr hb_glyph_extents_t; user_data: pointer): bool {.
      cdecl.}
  hb_font_get_glyph_contour_point_func_t* = proc (font: ptr hb_font_t;
      font_data: pointer; glyph: hb_codepoint_t; point_index: cuint;
      x: ptr hb_position_t; y: ptr hb_position_t; user_data: pointer): bool {.cdecl.}
  hb_font_get_glyph_name_func_t* = proc (font: ptr hb_font_t; font_data: pointer;
                                      glyph: hb_codepoint_t; name: cstring;
                                      size: cuint; user_data: pointer): bool {.
      cdecl.}
  hb_font_get_glyph_from_name_func_t* = proc (font: ptr hb_font_t; font_data: pointer;
      name: cstring; len: cint; glyph: ptr hb_codepoint_t; user_data: pointer): bool {.
      cdecl.}


proc hb_font_funcs_set_font_h_extents_func*(ffuncs: ptr hb_font_funcs_t;
    `func`: hb_font_get_font_h_extents_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl, importc: "hb_font_funcs_set_font_h_extents_func",
                                dynlib: dynlibhb_font_post.}

proc hb_font_funcs_set_font_v_extents_func*(ffuncs: ptr hb_font_funcs_t;
    `func`: hb_font_get_font_v_extents_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl, importc: "hb_font_funcs_set_font_v_extents_func",
                                dynlib: dynlibhb_font_post.}

proc hb_font_funcs_set_nominal_glyph_func*(ffuncs: ptr hb_font_funcs_t;
    `func`: hb_font_get_nominal_glyph_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl, importc: "hb_font_funcs_set_nominal_glyph_func",
                                dynlib: dynlibhb_font_post.}

proc hb_font_funcs_set_nominal_glyphs_func*(ffuncs: ptr hb_font_funcs_t;
    `func`: hb_font_get_nominal_glyphs_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl, importc: "hb_font_funcs_set_nominal_glyphs_func",
                                dynlib: dynlibhb_font_post.}

proc hb_font_funcs_set_variation_glyph_func*(ffuncs: ptr hb_font_funcs_t;
    `func`: hb_font_get_variation_glyph_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl, importc: "hb_font_funcs_set_variation_glyph_func",
                                dynlib: dynlibhb_font_post.}

proc hb_font_funcs_set_glyph_h_advance_func*(ffuncs: ptr hb_font_funcs_t;
    `func`: hb_font_get_glyph_h_advance_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl, importc: "hb_font_funcs_set_glyph_h_advance_func",
                                dynlib: dynlibhb_font_post.}

proc hb_font_funcs_set_glyph_v_advance_func*(ffuncs: ptr hb_font_funcs_t;
    `func`: hb_font_get_glyph_v_advance_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl, importc: "hb_font_funcs_set_glyph_v_advance_func",
                                dynlib: dynlibhb_font_post.}

proc hb_font_funcs_set_glyph_h_advances_func*(ffuncs: ptr hb_font_funcs_t;
    `func`: hb_font_get_glyph_h_advances_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl, importc: "hb_font_funcs_set_glyph_h_advances_func",
                                dynlib: dynlibhb_font_post.}

proc hb_font_funcs_set_glyph_v_advances_func*(ffuncs: ptr hb_font_funcs_t;
    `func`: hb_font_get_glyph_v_advances_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl, importc: "hb_font_funcs_set_glyph_v_advances_func",
                                dynlib: dynlibhb_font_post.}

proc hb_font_funcs_set_glyph_h_origin_func*(ffuncs: ptr hb_font_funcs_t;
    `func`: hb_font_get_glyph_h_origin_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl, importc: "hb_font_funcs_set_glyph_h_origin_func",
                                dynlib: dynlibhb_font_post.}

proc hb_font_funcs_set_glyph_v_origin_func*(ffuncs: ptr hb_font_funcs_t;
    `func`: hb_font_get_glyph_v_origin_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl, importc: "hb_font_funcs_set_glyph_v_origin_func",
                                dynlib: dynlibhb_font_post.}

proc hb_font_funcs_set_glyph_h_kerning_func*(ffuncs: ptr hb_font_funcs_t;
    `func`: hb_font_get_glyph_h_kerning_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl, importc: "hb_font_funcs_set_glyph_h_kerning_func",
                                dynlib: dynlibhb_font_post.}

proc hb_font_funcs_set_glyph_extents_func*(ffuncs: ptr hb_font_funcs_t;
    `func`: hb_font_get_glyph_extents_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl, importc: "hb_font_funcs_set_glyph_extents_func",
                                dynlib: dynlibhb_font_post.}

proc hb_font_funcs_set_glyph_contour_point_func*(ffuncs: ptr hb_font_funcs_t;
    `func`: hb_font_get_glyph_contour_point_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl, importc: "hb_font_funcs_set_glyph_contour_point_func",
                                dynlib: dynlibhb_font_post.}

proc hb_font_funcs_set_glyph_name_func*(ffuncs: ptr hb_font_funcs_t;
                                       `func`: hb_font_get_glyph_name_func_t;
                                       user_data: pointer;
                                       destroy: hb_destroy_func_t) {.cdecl,
    importc: "hb_font_funcs_set_glyph_name_func", dynlib: dynlibhb_font_post.}

proc hb_font_funcs_set_glyph_from_name_func*(ffuncs: ptr hb_font_funcs_t;
    `func`: hb_font_get_glyph_from_name_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl, importc: "hb_font_funcs_set_glyph_from_name_func",
                                dynlib: dynlibhb_font_post.}

proc hb_font_get_h_extents*(font: ptr hb_font_t; extents: ptr hb_font_extents_t): bool {.
    cdecl, importc: "hb_font_get_h_extents", dynlib: dynlibhb_font_post.}
proc hb_font_get_v_extents*(font: ptr hb_font_t; extents: ptr hb_font_extents_t): bool {.
    cdecl, importc: "hb_font_get_v_extents", dynlib: dynlibhb_font_post.}
proc hb_font_get_nominal_glyph*(font: ptr hb_font_t; unicode: hb_codepoint_t;
                               glyph: ptr hb_codepoint_t): bool {.cdecl,
    importc: "hb_font_get_nominal_glyph", dynlib: dynlibhb_font_post.}
proc hb_font_get_variation_glyph*(font: ptr hb_font_t; unicode: hb_codepoint_t;
                                 variation_selector: hb_codepoint_t;
                                 glyph: ptr hb_codepoint_t): bool {.cdecl,
    importc: "hb_font_get_variation_glyph", dynlib: dynlibhb_font_post.}
proc hb_font_get_nominal_glyphs*(font: ptr hb_font_t; count: cuint;
                                first_unicode: ptr hb_codepoint_t;
                                unicode_stride: cuint;
                                first_glyph: ptr hb_codepoint_t;
                                glyph_stride: cuint): cuint {.cdecl,
    importc: "hb_font_get_nominal_glyphs", dynlib: dynlibhb_font_post.}
proc hb_font_get_glyph_h_advance*(font: ptr hb_font_t; glyph: hb_codepoint_t): hb_position_t {.
    cdecl, importc: "hb_font_get_glyph_h_advance", dynlib: dynlibhb_font_post.}
proc hb_font_get_glyph_v_advance*(font: ptr hb_font_t; glyph: hb_codepoint_t): hb_position_t {.
    cdecl, importc: "hb_font_get_glyph_v_advance", dynlib: dynlibhb_font_post.}
proc hb_font_get_glyph_h_advances*(font: ptr hb_font_t; count: cuint;
                                  first_glyph: ptr hb_codepoint_t;
                                  glyph_stride: cuint;
                                  first_advance: ptr hb_position_t;
                                  advance_stride: cuint) {.cdecl,
    importc: "hb_font_get_glyph_h_advances", dynlib: dynlibhb_font_post.}
proc hb_font_get_glyph_v_advances*(font: ptr hb_font_t; count: cuint;
                                  first_glyph: ptr hb_codepoint_t;
                                  glyph_stride: cuint;
                                  first_advance: ptr hb_position_t;
                                  advance_stride: cuint) {.cdecl,
    importc: "hb_font_get_glyph_v_advances", dynlib: dynlibhb_font_post.}
proc hb_font_get_glyph_h_origin*(font: ptr hb_font_t; glyph: hb_codepoint_t;
                                x: ptr hb_position_t; y: ptr hb_position_t): bool {.
    cdecl, importc: "hb_font_get_glyph_h_origin", dynlib: dynlibhb_font_post.}
proc hb_font_get_glyph_v_origin*(font: ptr hb_font_t; glyph: hb_codepoint_t;
                                x: ptr hb_position_t; y: ptr hb_position_t): bool {.
    cdecl, importc: "hb_font_get_glyph_v_origin", dynlib: dynlibhb_font_post.}
proc hb_font_get_glyph_h_kerning*(font: ptr hb_font_t; left_glyph: hb_codepoint_t;
                                 right_glyph: hb_codepoint_t): hb_position_t {.
    cdecl, importc: "hb_font_get_glyph_h_kerning", dynlib: dynlibhb_font_post.}
proc hb_font_get_glyph_extents*(font: ptr hb_font_t; glyph: hb_codepoint_t;
                               extents: ptr hb_glyph_extents_t): bool {.cdecl,
    importc: "hb_font_get_glyph_extents", dynlib: dynlibhb_font_post.}
proc hb_font_get_glyph_contour_point*(font: ptr hb_font_t; glyph: hb_codepoint_t;
                                     point_index: cuint; x: ptr hb_position_t;
                                     y: ptr hb_position_t): bool {.cdecl,
    importc: "hb_font_get_glyph_contour_point", dynlib: dynlibhb_font_post.}
proc hb_font_get_glyph_name*(font: ptr hb_font_t; glyph: hb_codepoint_t;
                            name: cstring; size: cuint): bool {.cdecl,
    importc: "hb_font_get_glyph_name", dynlib: dynlibhb_font_post.}
proc hb_font_get_glyph_from_name*(font: ptr hb_font_t; name: cstring; len: cint;
                                 glyph: ptr hb_codepoint_t): bool {.cdecl,
    importc: "hb_font_get_glyph_from_name", dynlib: dynlibhb_font_post.}

proc hb_font_get_glyph*(font: ptr hb_font_t; unicode: hb_codepoint_t;
                       variation_selector: hb_codepoint_t;
                       glyph: ptr hb_codepoint_t): bool {.cdecl,
    importc: "hb_font_get_glyph", dynlib: dynlibhb_font_post.}
proc hb_font_get_extents_for_direction*(font: ptr hb_font_t;
                                       direction: hb_direction_t;
                                       extents: ptr hb_font_extents_t) {.cdecl,
    importc: "hb_font_get_extents_for_direction", dynlib: dynlibhb_font_post.}
proc hb_font_get_glyph_advance_for_direction*(font: ptr hb_font_t;
    glyph: hb_codepoint_t; direction: hb_direction_t; x: ptr hb_position_t;
    y: ptr hb_position_t) {.cdecl,
                         importc: "hb_font_get_glyph_advance_for_direction",
                         dynlib: dynlibhb_font_post.}
proc hb_font_get_glyph_advances_for_direction*(font: ptr hb_font_t;
    direction: hb_direction_t; count: cuint; first_glyph: ptr hb_codepoint_t;
    glyph_stride: cuint; first_advance: ptr hb_position_t; advance_stride: cuint) {.
    cdecl, importc: "hb_font_get_glyph_advances_for_direction",
    dynlib: dynlibhb_font_post.}
proc hb_font_get_glyph_origin_for_direction*(font: ptr hb_font_t;
    glyph: hb_codepoint_t; direction: hb_direction_t; x: ptr hb_position_t;
    y: ptr hb_position_t) {.cdecl,
                         importc: "hb_font_get_glyph_origin_for_direction",
                         dynlib: dynlibhb_font_post.}
proc hb_font_add_glyph_origin_for_direction*(font: ptr hb_font_t;
    glyph: hb_codepoint_t; direction: hb_direction_t; x: ptr hb_position_t;
    y: ptr hb_position_t) {.cdecl,
                         importc: "hb_font_add_glyph_origin_for_direction",
                         dynlib: dynlibhb_font_post.}
proc hb_font_subtract_glyph_origin_for_direction*(font: ptr hb_font_t;
    glyph: hb_codepoint_t; direction: hb_direction_t; x: ptr hb_position_t;
    y: ptr hb_position_t) {.cdecl, importc: "hb_font_subtract_glyph_origin_for_direction",
                         dynlib: dynlibhb_font_post.}
proc hb_font_get_glyph_kerning_for_direction*(font: ptr hb_font_t;
    first_glyph: hb_codepoint_t; second_glyph: hb_codepoint_t;
    direction: hb_direction_t; x: ptr hb_position_t; y: ptr hb_position_t) {.cdecl,
    importc: "hb_font_get_glyph_kerning_for_direction", dynlib: dynlibhb_font_post.}
proc hb_font_get_glyph_extents_for_origin*(font: ptr hb_font_t;
    glyph: hb_codepoint_t; direction: hb_direction_t;
    extents: ptr hb_glyph_extents_t): bool {.cdecl,
    importc: "hb_font_get_glyph_extents_for_origin", dynlib: dynlibhb_font_post.}
proc hb_font_get_glyph_contour_point_for_origin*(font: ptr hb_font_t;
    glyph: hb_codepoint_t; point_index: cuint; direction: hb_direction_t;
    x: ptr hb_position_t; y: ptr hb_position_t): bool {.cdecl,
    importc: "hb_font_get_glyph_contour_point_for_origin",
    dynlib: dynlibhb_font_post.}

proc hb_font_glyph_to_string*(font: ptr hb_font_t; glyph: hb_codepoint_t; s: cstring;
                             size: cuint) {.cdecl,
    importc: "hb_font_glyph_to_string", dynlib: dynlibhb_font_post.}

proc hb_font_glyph_from_string*(font: ptr hb_font_t; s: cstring; len: cint;
                               glyph: ptr hb_codepoint_t): bool {.cdecl,
    importc: "hb_font_glyph_from_string", dynlib: dynlibhb_font_post.}

proc hb_font_create*(face: ptr hb_face_t): ptr hb_font_t {.cdecl,
    importc: "hb_font_create", dynlib: dynlibhb_font_post.}
proc hb_font_create_sub_font*(parent: ptr hb_font_t): ptr hb_font_t {.cdecl,
    importc: "hb_font_create_sub_font", dynlib: dynlibhb_font_post.}
proc hb_font_get_empty*(): ptr hb_font_t {.cdecl, importc: "hb_font_get_empty",
                                       dynlib: dynlibhb_font_post.}
proc hb_font_reference*(font: ptr hb_font_t): ptr hb_font_t {.cdecl,
    importc: "hb_font_reference", dynlib: dynlibhb_font_post.}
proc hb_font_destroy*(font: ptr hb_font_t) {.cdecl, importc: "hb_font_destroy",
    dynlib: dynlibhb_font_post.}
proc hb_font_set_user_data*(font: ptr hb_font_t; key: ptr hb_user_data_key_t;
                           data: pointer; destroy: hb_destroy_func_t;
                           replace: bool): bool {.cdecl,
    importc: "hb_font_set_user_data", dynlib: dynlibhb_font_post.}
proc hb_font_get_user_data*(font: ptr hb_font_t; key: ptr hb_user_data_key_t): pointer {.
    cdecl, importc: "hb_font_get_user_data", dynlib: dynlibhb_font_post.}
proc hb_font_make_immutable*(font: ptr hb_font_t) {.cdecl,
    importc: "hb_font_make_immutable", dynlib: dynlibhb_font_post.}
proc hb_font_is_immutable*(font: ptr hb_font_t): bool {.cdecl,
    importc: "hb_font_is_immutable", dynlib: dynlibhb_font_post.}
proc hb_font_set_parent*(font: ptr hb_font_t; parent: ptr hb_font_t) {.cdecl,
    importc: "hb_font_set_parent", dynlib: dynlibhb_font_post.}
proc hb_font_get_parent*(font: ptr hb_font_t): ptr hb_font_t {.cdecl,
    importc: "hb_font_get_parent", dynlib: dynlibhb_font_post.}
proc hb_font_set_face*(font: ptr hb_font_t; face: ptr hb_face_t) {.cdecl,
    importc: "hb_font_set_face", dynlib: dynlibhb_font_post.}
proc hb_font_get_face*(font: ptr hb_font_t): ptr hb_face_t {.cdecl,
    importc: "hb_font_get_face", dynlib: dynlibhb_font_post.}
proc hb_font_set_funcs*(font: ptr hb_font_t; klass: ptr hb_font_funcs_t;
                       font_data: pointer; destroy: hb_destroy_func_t) {.cdecl,
    importc: "hb_font_set_funcs", dynlib: dynlibhb_font_post.}

proc hb_font_set_funcs_data*(font: ptr hb_font_t; font_data: pointer;
                            destroy: hb_destroy_func_t) {.cdecl,
    importc: "hb_font_set_funcs_data", dynlib: dynlibhb_font_post.}
proc hb_font_set_scale*(font: ptr hb_font_t; x_scale: cint; y_scale: cint) {.cdecl,
    importc: "hb_font_set_scale", dynlib: dynlibhb_font_post.}
proc hb_font_get_scale*(font: ptr hb_font_t; x_scale: ptr cint; y_scale: ptr cint) {.
    cdecl, importc: "hb_font_get_scale", dynlib: dynlibhb_font_post.}

proc hb_font_set_ppem*(font: ptr hb_font_t; x_ppem: cuint; y_ppem: cuint) {.cdecl,
    importc: "hb_font_set_ppem", dynlib: dynlibhb_font_post.}
proc hb_font_get_ppem*(font: ptr hb_font_t; x_ppem: ptr cuint; y_ppem: ptr cuint) {.cdecl,
    importc: "hb_font_get_ppem", dynlib: dynlibhb_font_post.}

proc hb_font_set_ptem*(font: ptr hb_font_t; ptem: cfloat) {.cdecl,
    importc: "hb_font_set_ptem", dynlib: dynlibhb_font_post.}
proc hb_font_get_ptem*(font: ptr hb_font_t): cfloat {.cdecl,
    importc: "hb_font_get_ptem", dynlib: dynlibhb_font_post.}
proc hb_font_set_variations*(font: ptr hb_font_t; variations: ptr hb_variation_t;
                            variations_length: cuint) {.cdecl,
    importc: "hb_font_set_variations", dynlib: dynlibhb_font_post.}
proc hb_font_set_var_coords_design*(font: ptr hb_font_t; coords: ptr cfloat;
                                   coords_length: cuint) {.cdecl,
    importc: "hb_font_set_var_coords_design", dynlib: dynlibhb_font_post.}
proc hb_font_get_var_coords_design*(font: ptr hb_font_t; length: ptr cuint): ptr cfloat {.
    cdecl, importc: "hb_font_get_var_coords_design", dynlib: dynlibhb_font_post.}
proc hb_font_set_var_coords_normalized*(font: ptr hb_font_t; coords: ptr cint;
                                       coords_length: cuint) {.cdecl,
    importc: "hb_font_set_var_coords_normalized", dynlib: dynlibhb_font_post.}
proc hb_font_get_var_coords_normalized*(font: ptr hb_font_t; length: ptr cuint): ptr cint {.
    cdecl, importc: "hb_font_get_var_coords_normalized", dynlib: dynlibhb_font_post.}
proc hb_font_set_var_named_instance*(font: ptr hb_font_t; instance_index: cuint) {.
    cdecl, importc: "hb_font_set_var_named_instance", dynlib: dynlibhb_font_post.}
proc hb_font_draw_glyph*(font: ptr hb_font_t; glyph: hb_codepoint_t;
                        funcs: ptr hb_draw_funcs_t; user_data: pointer): bool {.
    cdecl, importc: "hb_font_draw_glyph", dynlib: dynlibhb_font_post.}