when defined(Linux):
  const dynlibhb_icu_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}
proc hb_icu_script_to_script*(script: UScriptCode): hb_script_t {.cdecl,
    importc: "hb_icu_script_to_script", dynlib: dynlibhb_icu_post.}
proc hb_icu_script_from_script*(script: hb_script_t): UScriptCode {.cdecl,
    importc: "hb_icu_script_from_script", dynlib: dynlibhb_icu_post.}
proc hb_icu_get_unicode_funcs*(): ptr hb_unicode_funcs_t {.cdecl,
    importc: "hb_icu_get_unicode_funcs", dynlib: dynlibhb_icu_post.}