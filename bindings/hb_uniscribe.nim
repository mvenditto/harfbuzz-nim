when defined(Linux):
  const dynlibhb_uniscribe_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}
proc hb_uniscribe_font_get_logfontw*(font: ptr hb_font_t): ptr LOGFONTW {.cdecl,
    importc: "hb_uniscribe_font_get_logfontw", dynlib: dynlibhb_uniscribe_post.}
proc hb_uniscribe_font_get_hfont*(font: ptr hb_font_t): HFONT {.cdecl,
    importc: "hb_uniscribe_font_get_hfont", dynlib: dynlibhb_uniscribe_post.}