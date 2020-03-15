when defined(Linux):
  const dynlibhb_face_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}

import hb_common
import hb_blob
import hb_set

type
    hb_face_t* = object

proc hb_face_count*(blob: ptr hb_blob_t): cuint {.cdecl, importc: "hb_face_count",
    dynlib: dynlibhb_face_post.}


proc hb_face_create*(blob: ptr hb_blob_t; index: cuint): ptr hb_face_t {.cdecl,
    importc: "hb_face_create", dynlib: dynlibhb_face_post.}
type
  hb_reference_table_func_t* = proc (face: ptr hb_face_t; tag: hb_tag_t;
                                  user_data: pointer): ptr hb_blob_t {.cdecl.}


proc hb_face_create_for_tables*(reference_table_func: hb_reference_table_func_t;
                               user_data: pointer; destroy: hb_destroy_func_t): ptr hb_face_t {.
    cdecl, importc: "hb_face_create_for_tables", dynlib: dynlibhb_face_post.}
proc hb_face_get_empty*(): ptr hb_face_t {.cdecl, importc: "hb_face_get_empty",
                                       dynlib: dynlibhb_face_post.}
proc hb_face_reference*(face: ptr hb_face_t): ptr hb_face_t {.cdecl,
    importc: "hb_face_reference", dynlib: dynlibhb_face_post.}
proc hb_face_destroy*(face: ptr hb_face_t) {.cdecl, importc: "hb_face_destroy",
    dynlib: dynlibhb_face_post.}
proc hb_face_set_user_data*(face: ptr hb_face_t; key: ptr hb_user_data_key_t;
                           data: pointer; destroy: hb_destroy_func_t;
                           replace: bool): bool {.cdecl,
    importc: "hb_face_set_user_data", dynlib: dynlibhb_face_post.}
proc hb_face_get_user_data*(face: ptr hb_face_t; key: ptr hb_user_data_key_t): pointer {.
    cdecl, importc: "hb_face_get_user_data", dynlib: dynlibhb_face_post.}
proc hb_face_make_immutable*(face: ptr hb_face_t) {.cdecl,
    importc: "hb_face_make_immutable", dynlib: dynlibhb_face_post.}
proc hb_face_is_immutable*(face: ptr hb_face_t): bool {.cdecl,
    importc: "hb_face_is_immutable", dynlib: dynlibhb_face_post.}
proc hb_face_reference_table*(face: ptr hb_face_t; tag: hb_tag_t): ptr hb_blob_t {.
    cdecl, importc: "hb_face_reference_table", dynlib: dynlibhb_face_post.}
proc hb_face_reference_blob*(face: ptr hb_face_t): ptr hb_blob_t {.cdecl,
    importc: "hb_face_reference_blob", dynlib: dynlibhb_face_post.}
proc hb_face_set_index*(face: ptr hb_face_t; index: cuint) {.cdecl,
    importc: "hb_face_set_index", dynlib: dynlibhb_face_post.}
proc hb_face_get_index*(face: ptr hb_face_t): cuint {.cdecl,
    importc: "hb_face_get_index", dynlib: dynlibhb_face_post.}
proc hb_face_set_upem*(face: ptr hb_face_t; upem: cuint) {.cdecl,
    importc: "hb_face_set_upem", dynlib: dynlibhb_face_post.}
proc hb_face_get_upem*(face: ptr hb_face_t): cuint {.cdecl,
    importc: "hb_face_get_upem", dynlib: dynlibhb_face_post.}
proc hb_face_set_glyph_count*(face: ptr hb_face_t; glyph_count: cuint) {.cdecl,
    importc: "hb_face_set_glyph_count", dynlib: dynlibhb_face_post.}
proc hb_face_get_glyph_count*(face: ptr hb_face_t): cuint {.cdecl,
    importc: "hb_face_get_glyph_count", dynlib: dynlibhb_face_post.}
proc hb_face_get_table_tags*(face: ptr hb_face_t; start_offset: cuint;
                            table_count: ptr cuint; table_tags: ptr hb_tag_t): cuint {.
    cdecl, importc: "hb_face_get_table_tags", dynlib: dynlibhb_face_post.}

proc hb_face_collect_unicodes*(face: ptr hb_face_t; `out`: ptr hb_set_t) {.cdecl,
    importc: "hb_face_collect_unicodes", dynlib: dynlibhb_face_post.}
proc hb_face_collect_variation_selectors*(face: ptr hb_face_t; `out`: ptr hb_set_t) {.
    cdecl, importc: "hb_face_collect_variation_selectors",
    dynlib: dynlibhb_face_post.}
proc hb_face_collect_variation_unicodes*(face: ptr hb_face_t;
                                        variation_selector: hb_codepoint_t;
                                        `out`: ptr hb_set_t) {.cdecl,
    importc: "hb_face_collect_variation_unicodes", dynlib: dynlibhb_face_post.}

proc hb_face_builder_create*(): ptr hb_face_t {.cdecl,
    importc: "hb_face_builder_create", dynlib: dynlibhb_face_post.}
proc hb_face_builder_add_table*(face: ptr hb_face_t; tag: hb_tag_t;
                               blob: ptr hb_blob_t): bool {.cdecl,
    importc: "hb_face_builder_add_table", dynlib: dynlibhb_face_post.}