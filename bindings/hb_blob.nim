when defined(Linux):
  const dynlibhb_blob_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}

import hb_common

type
  hb_memory_mode_t* {.size: sizeof(cint).} = enum
    HB_MEMORY_MODE_DUPLICATE, 
    HB_MEMORY_MODE_READONLY, 
    HB_MEMORY_MODE_WRITABLE,
    HB_MEMORY_MODE_READONLY_MAY_MAKE_WRITABLE

type 
    hb_blob_t* = object of RootObj

proc hb_blob_create*(data: cstring; length: cuint; mode: hb_memory_mode_t;
                    user_data: pointer; destroy: hb_destroy_func_t): ptr hb_blob_t {.
    cdecl, importc: "hb_blob_create", dynlib: dynlibhb_blob_post.}
proc hb_blob_create_from_file*(file_name: cstring): ptr hb_blob_t {.cdecl,
    importc: "hb_blob_create_from_file", dynlib: dynlibhb_blob_post.}

proc hb_blob_create_sub_blob*(parent: ptr hb_blob_t; offset: cuint; length: cuint): ptr hb_blob_t {.
    cdecl, importc: "hb_blob_create_sub_blob", dynlib: dynlibhb_blob_post.}
proc hb_blob_copy_writable_or_fail*(blob: ptr hb_blob_t): ptr hb_blob_t {.cdecl,
    importc: "hb_blob_copy_writable_or_fail", dynlib: dynlibhb_blob_post.}
proc hb_blob_get_empty*(): ptr hb_blob_t {.cdecl, importc: "hb_blob_get_empty",
                                       dynlib: dynlibhb_blob_post.}
proc hb_blob_reference*(blob: ptr hb_blob_t): ptr hb_blob_t {.cdecl,
    importc: "hb_blob_reference", dynlib: dynlibhb_blob_post.}
proc hb_blob_destroy*(blob: ptr hb_blob_t) {.cdecl, importc: "hb_blob_destroy",
    dynlib: dynlibhb_blob_post.}
proc hb_blob_set_user_data*(blob: ptr hb_blob_t; key: ptr hb_user_data_key_t;
                           data: pointer; destroy: hb_destroy_func_t;
                           replace: bool): bool {.cdecl,
    importc: "hb_blob_set_user_data", dynlib: dynlibhb_blob_post.}
proc hb_blob_get_user_data*(blob: ptr hb_blob_t; key: ptr hb_user_data_key_t): pointer {.
    cdecl, importc: "hb_blob_get_user_data", dynlib: dynlibhb_blob_post.}
proc hb_blob_make_immutable*(blob: ptr hb_blob_t) {.cdecl,
    importc: "hb_blob_make_immutable", dynlib: dynlibhb_blob_post.}
proc hb_blob_is_immutable*(blob: ptr hb_blob_t): bool {.cdecl,
    importc: "hb_blob_is_immutable", dynlib: dynlibhb_blob_post.}
proc hb_blob_get_length*(blob: ptr hb_blob_t): cuint {.cdecl,
    importc: "hb_blob_get_length", dynlib: dynlibhb_blob_post.}
proc hb_blob_get_data*(blob: ptr hb_blob_t; length: ptr cuint): cstring {.cdecl,
    importc: "hb_blob_get_data", dynlib: dynlibhb_blob_post.}
proc hb_blob_get_data_writable*(blob: ptr hb_blob_t; length: ptr cuint): cstring {.
    cdecl, importc: "hb_blob_get_data_writable", dynlib: dynlibhb_blob_post.}