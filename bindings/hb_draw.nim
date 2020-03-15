when defined(Linux):
  const dynlibhb_draw_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}

import hb_common

type
  hb_draw_funcs_t* = object
  hb_draw_move_to_func_t* = proc (to_x: hb_position_t; to_y: hb_position_t;
                               user_data: pointer) {.cdecl.}
  hb_draw_line_to_func_t* = proc (to_x: hb_position_t; to_y: hb_position_t;
                               user_data: pointer) {.cdecl.}
  hb_draw_quadratic_to_func_t* = proc (control_x: hb_position_t;
                                    control_y: hb_position_t; to_x: hb_position_t;
                                    to_y: hb_position_t; user_data: pointer) {.cdecl.}
  hb_draw_cubic_to_func_t* = proc (control1_x: hb_position_t;
                                control1_y: hb_position_t;
                                control2_x: hb_position_t;
                                control2_y: hb_position_t; to_x: hb_position_t;
                                to_y: hb_position_t; user_data: pointer) {.cdecl.}
  hb_draw_close_path_func_t* = proc (user_data: pointer) 



proc hb_draw_funcs_set_move_to_func*(funcs: ptr hb_draw_funcs_t;
                                    move_to: hb_draw_move_to_func_t) {.cdecl,
    importc: "hb_draw_funcs_set_move_to_func", dynlib: dynlibhb_draw_post.}
proc hb_draw_funcs_set_line_to_func*(funcs: ptr hb_draw_funcs_t;
                                    line_to: hb_draw_line_to_func_t) {.cdecl,
    importc: "hb_draw_funcs_set_line_to_func", dynlib: dynlibhb_draw_post.}
proc hb_draw_funcs_set_quadratic_to_func*(funcs: ptr hb_draw_funcs_t;
    quadratic_to: hb_draw_quadratic_to_func_t) {.cdecl,
    importc: "hb_draw_funcs_set_quadratic_to_func", dynlib: dynlibhb_draw_post.}
proc hb_draw_funcs_set_cubic_to_func*(funcs: ptr hb_draw_funcs_t;
                                     cubic_to: hb_draw_cubic_to_func_t) {.cdecl,
    importc: "hb_draw_funcs_set_cubic_to_func", dynlib: dynlibhb_draw_post.}
proc hb_draw_funcs_set_close_path_func*(funcs: ptr hb_draw_funcs_t;
                                       close_path: hb_draw_close_path_func_t) {.
    cdecl, importc: "hb_draw_funcs_set_close_path_func", dynlib: dynlibhb_draw_post.}
proc hb_draw_funcs_create*(): ptr hb_draw_funcs_t {.cdecl,
    importc: "hb_draw_funcs_create", dynlib: dynlibhb_draw_post.}
proc hb_draw_funcs_reference*(funcs: ptr hb_draw_funcs_t): ptr hb_draw_funcs_t {.
    cdecl, importc: "hb_draw_funcs_reference", dynlib: dynlibhb_draw_post.}
proc hb_draw_funcs_destroy*(funcs: ptr hb_draw_funcs_t) {.cdecl,
    importc: "hb_draw_funcs_destroy", dynlib: dynlibhb_draw_post.}
proc hb_draw_funcs_make_immutable*(funcs: ptr hb_draw_funcs_t) {.cdecl,
    importc: "hb_draw_funcs_make_immutable", dynlib: dynlibhb_draw_post.}
proc hb_draw_funcs_is_immutable*(funcs: ptr hb_draw_funcs_t): bool {.cdecl,
    importc: "hb_draw_funcs_is_immutable", dynlib: dynlibhb_draw_post.}