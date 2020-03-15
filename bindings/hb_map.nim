when defined(Linux):
  const dynlibhb_map_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}

import hb_common

type
    hb_map_t* = object

const
  HB_MAP_VALUE_INVALID* = cast[hb_codepoint_t](-1)


proc hb_map_create*(): ptr hb_map_t {.cdecl, importc: "hb_map_create",
                                  dynlib: dynlibhb_map_post.}
proc hb_map_get_empty*(): ptr hb_map_t {.cdecl, importc: "hb_map_get_empty",
                                     dynlib: dynlibhb_map_post.}
proc hb_map_reference*(map: ptr hb_map_t): ptr hb_map_t {.cdecl,
    importc: "hb_map_reference", dynlib: dynlibhb_map_post.}
proc hb_map_destroy*(map: ptr hb_map_t) {.cdecl, importc: "hb_map_destroy",
                                      dynlib: dynlibhb_map_post.}
proc hb_map_set_user_data*(map: ptr hb_map_t; key: ptr hb_user_data_key_t;
                          data: pointer; destroy: hb_destroy_func_t;
                          replace: bool): bool {.cdecl,
    importc: "hb_map_set_user_data", dynlib: dynlibhb_map_post.}
proc hb_map_get_user_data*(map: ptr hb_map_t; key: ptr hb_user_data_key_t): pointer {.
    cdecl, importc: "hb_map_get_user_data", dynlib: dynlibhb_map_post.}

proc hb_map_allocation_successful*(map: ptr hb_map_t): bool {.cdecl,
    importc: "hb_map_allocation_successful", dynlib: dynlibhb_map_post.}
proc hb_map_clear*(map: ptr hb_map_t) {.cdecl, importc: "hb_map_clear",
                                    dynlib: dynlibhb_map_post.}
proc hb_map_is_empty*(map: ptr hb_map_t): bool {.cdecl,
    importc: "hb_map_is_empty", dynlib: dynlibhb_map_post.}
proc hb_map_get_population*(map: ptr hb_map_t): cuint {.cdecl,
    importc: "hb_map_get_population", dynlib: dynlibhb_map_post.}
proc hb_map_set*(map: ptr hb_map_t; key: hb_codepoint_t; value: hb_codepoint_t) {.cdecl,
    importc: "hb_map_set", dynlib: dynlibhb_map_post.}
proc hb_map_get*(map: ptr hb_map_t; key: hb_codepoint_t): hb_codepoint_t {.cdecl,
    importc: "hb_map_get", dynlib: dynlibhb_map_post.}
proc hb_map_del*(map: ptr hb_map_t; key: hb_codepoint_t) {.cdecl,
    importc: "hb_map_del", dynlib: dynlibhb_map_post.}
proc hb_map_has*(map: ptr hb_map_t; key: hb_codepoint_t): bool {.cdecl,
    importc: "hb_map_has", dynlib: dynlibhb_map_post.}