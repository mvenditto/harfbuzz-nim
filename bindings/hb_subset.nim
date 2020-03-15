when defined(Linux):
  const dynlibhb_subset_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}



proc hb_subset_input_create_or_fail*(): ptr hb_subset_input_t {.cdecl,
    importc: "hb_subset_input_create_or_fail", dynlib: dynlibhb_subset_post.}
proc hb_subset_input_reference*(subset_input: ptr hb_subset_input_t): ptr hb_subset_input_t {.
    cdecl, importc: "hb_subset_input_reference", dynlib: dynlibhb_subset_post.}
proc hb_subset_input_destroy*(subset_input: ptr hb_subset_input_t) {.cdecl,
    importc: "hb_subset_input_destroy", dynlib: dynlibhb_subset_post.}
proc hb_subset_input_unicode_set*(subset_input: ptr hb_subset_input_t): ptr hb_set_t {.
    cdecl, importc: "hb_subset_input_unicode_set", dynlib: dynlibhb_subset_post.}
proc hb_subset_input_glyph_set*(subset_input: ptr hb_subset_input_t): ptr hb_set_t {.
    cdecl, importc: "hb_subset_input_glyph_set", dynlib: dynlibhb_subset_post.}
proc hb_subset_input_nameid_set*(subset_input: ptr hb_subset_input_t): ptr hb_set_t {.
    cdecl, importc: "hb_subset_input_nameid_set", dynlib: dynlibhb_subset_post.}
proc hb_subset_input_namelangid_set*(subset_input: ptr hb_subset_input_t): ptr hb_set_t {.
    cdecl, importc: "hb_subset_input_namelangid_set", dynlib: dynlibhb_subset_post.}
proc hb_subset_input_drop_tables_set*(subset_input: ptr hb_subset_input_t): ptr hb_set_t {.
    cdecl, importc: "hb_subset_input_drop_tables_set", dynlib: dynlibhb_subset_post.}
proc hb_subset_input_set_drop_hints*(subset_input: ptr hb_subset_input_t;
                                    drop_hints: bool) {.cdecl,
    importc: "hb_subset_input_set_drop_hints", dynlib: dynlibhb_subset_post.}
proc hb_subset_input_get_drop_hints*(subset_input: ptr hb_subset_input_t): bool {.
    cdecl, importc: "hb_subset_input_get_drop_hints", dynlib: dynlibhb_subset_post.}
proc hb_subset_input_set_desubroutinize*(subset_input: ptr hb_subset_input_t;
                                        desubroutinize: bool) {.cdecl,
    importc: "hb_subset_input_set_desubroutinize", dynlib: dynlibhb_subset_post.}
proc hb_subset_input_get_desubroutinize*(subset_input: ptr hb_subset_input_t): bool {.
    cdecl, importc: "hb_subset_input_get_desubroutinize",
    dynlib: dynlibhb_subset_post.}
proc hb_subset_input_set_retain_gids*(subset_input: ptr hb_subset_input_t;
                                     retain_gids: bool) {.cdecl,
    importc: "hb_subset_input_set_retain_gids", dynlib: dynlibhb_subset_post.}
proc hb_subset_input_get_retain_gids*(subset_input: ptr hb_subset_input_t): bool {.
    cdecl, importc: "hb_subset_input_get_retain_gids", dynlib: dynlibhb_subset_post.}
proc hb_subset_input_set_name_legacy*(subset_input: ptr hb_subset_input_t;
                                     name_legacy: bool) {.cdecl,
    importc: "hb_subset_input_set_name_legacy", dynlib: dynlibhb_subset_post.}
proc hb_subset_input_get_name_legacy*(subset_input: ptr hb_subset_input_t): bool {.
    cdecl, importc: "hb_subset_input_get_name_legacy", dynlib: dynlibhb_subset_post.}

proc hb_subset*(source: ptr hb_face_t; input: ptr hb_subset_input_t): ptr hb_face_t {.
    cdecl, importc: "hb_subset", dynlib: dynlibhb_subset_post.}