when defined(Linux):
  const dynlibhb_set_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}

import hb_common

const
  HB_SET_VALUE_INVALID* = cast[hb_codepoint_t](-1)

type
    hb_set_t* = object

proc hb_set_create*(): ptr hb_set_t {.cdecl, importc: "hb_set_create",
                                  dynlib: dynlibhb_set_post.}
proc hb_set_get_empty*(): ptr hb_set_t {.cdecl, importc: "hb_set_get_empty",
                                     dynlib: dynlibhb_set_post.}
proc hb_set_reference*(set: ptr hb_set_t): ptr hb_set_t {.cdecl,
    importc: "hb_set_reference", dynlib: dynlibhb_set_post.}
proc hb_set_destroy*(set: ptr hb_set_t) {.cdecl, importc: "hb_set_destroy",
                                      dynlib: dynlibhb_set_post.}
proc hb_set_set_user_data*(set: ptr hb_set_t; key: ptr hb_user_data_key_t;
                          data: pointer; destroy: hb_destroy_func_t;
                          replace: bool): bool {.cdecl,
    importc: "hb_set_set_user_data", dynlib: dynlibhb_set_post.}
proc hb_set_get_user_data*(set: ptr hb_set_t; key: ptr hb_user_data_key_t): pointer {.
    cdecl, importc: "hb_set_get_user_data", dynlib: dynlibhb_set_post.}

proc hb_set_allocation_successful*(set: ptr hb_set_t): bool {.cdecl,
    importc: "hb_set_allocation_successful", dynlib: dynlibhb_set_post.}
proc hb_set_clear*(set: ptr hb_set_t) {.cdecl, importc: "hb_set_clear",
                                    dynlib: dynlibhb_set_post.}
proc hb_set_is_empty*(set: ptr hb_set_t): bool {.cdecl,
    importc: "hb_set_is_empty", dynlib: dynlibhb_set_post.}
proc hb_set_has*(set: ptr hb_set_t; codepoint: hb_codepoint_t): bool {.cdecl,
    importc: "hb_set_has", dynlib: dynlibhb_set_post.}
proc hb_set_add*(set: ptr hb_set_t; codepoint: hb_codepoint_t) {.cdecl,
    importc: "hb_set_add", dynlib: dynlibhb_set_post.}
proc hb_set_add_range*(set: ptr hb_set_t; first: hb_codepoint_t; last: hb_codepoint_t) {.
    cdecl, importc: "hb_set_add_range", dynlib: dynlibhb_set_post.}
proc hb_set_del*(set: ptr hb_set_t; codepoint: hb_codepoint_t) {.cdecl,
    importc: "hb_set_del", dynlib: dynlibhb_set_post.}
proc hb_set_del_range*(set: ptr hb_set_t; first: hb_codepoint_t; last: hb_codepoint_t) {.
    cdecl, importc: "hb_set_del_range", dynlib: dynlibhb_set_post.}
proc hb_set_is_equal*(set: ptr hb_set_t; other: ptr hb_set_t): bool {.cdecl,
    importc: "hb_set_is_equal", dynlib: dynlibhb_set_post.}
proc hb_set_is_subset*(set: ptr hb_set_t; larger_set: ptr hb_set_t): bool {.cdecl,
    importc: "hb_set_is_subset", dynlib: dynlibhb_set_post.}
proc hb_set_set*(set: ptr hb_set_t; other: ptr hb_set_t) {.cdecl, importc: "hb_set_set",
    dynlib: dynlibhb_set_post.}
proc hb_set_union*(set: ptr hb_set_t; other: ptr hb_set_t) {.cdecl,
    importc: "hb_set_union", dynlib: dynlibhb_set_post.}
proc hb_set_intersect*(set: ptr hb_set_t; other: ptr hb_set_t) {.cdecl,
    importc: "hb_set_intersect", dynlib: dynlibhb_set_post.}
proc hb_set_subtract*(set: ptr hb_set_t; other: ptr hb_set_t) {.cdecl,
    importc: "hb_set_subtract", dynlib: dynlibhb_set_post.}
proc hb_set_symmetric_difference*(set: ptr hb_set_t; other: ptr hb_set_t) {.cdecl,
    importc: "hb_set_symmetric_difference", dynlib: dynlibhb_set_post.}
proc hb_set_get_population*(set: ptr hb_set_t): cuint {.cdecl,
    importc: "hb_set_get_population", dynlib: dynlibhb_set_post.}

proc hb_set_get_min*(set: ptr hb_set_t): hb_codepoint_t {.cdecl,
    importc: "hb_set_get_min", dynlib: dynlibhb_set_post.}

proc hb_set_get_max*(set: ptr hb_set_t): hb_codepoint_t {.cdecl,
    importc: "hb_set_get_max", dynlib: dynlibhb_set_post.}

proc hb_set_next*(set: ptr hb_set_t; codepoint: ptr hb_codepoint_t): bool {.cdecl,
    importc: "hb_set_next", dynlib: dynlibhb_set_post.}

proc hb_set_previous*(set: ptr hb_set_t; codepoint: ptr hb_codepoint_t): bool {.
    cdecl, importc: "hb_set_previous", dynlib: dynlibhb_set_post.}

proc hb_set_next_range*(set: ptr hb_set_t; first: ptr hb_codepoint_t;
                       last: ptr hb_codepoint_t): bool {.cdecl,
    importc: "hb_set_next_range", dynlib: dynlibhb_set_post.}

proc hb_set_previous_range*(set: ptr hb_set_t; first: ptr hb_codepoint_t;
                           last: ptr hb_codepoint_t): bool {.cdecl,
    importc: "hb_set_previous_range", dynlib: dynlibhb_set_post.}