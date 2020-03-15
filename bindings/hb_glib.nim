when defined(Linux):
  const dynlibhb_glib_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}
proc hb_glib_script_to_script*(script: GUnicodeScript): hb_script_t {.cdecl,
    importc: "hb_glib_script_to_script", dynlib: dynlibhb_glib_post.}
proc hb_glib_script_from_script*(script: hb_script_t): GUnicodeScript {.cdecl,
    importc: "hb_glib_script_from_script", dynlib: dynlibhb_glib_post.}
proc hb_glib_get_unicode_funcs*(): ptr hb_unicode_funcs_t {.cdecl,
    importc: "hb_glib_get_unicode_funcs", dynlib: dynlibhb_glib_post.}
when GLIB_CHECK_VERSION(2, 31, 10):
  proc hb_glib_blob_create*(gbytes: ptr GBytes): ptr hb_blob_t {.cdecl,
      importc: "hb_glib_blob_create", dynlib: dynlibhb_glib_post.}