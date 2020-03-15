when defined(Linux):
  const dynlibhb_ot_font_post = "harfbuzz.so"

import hb_font

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}
proc hb_ot_font_set_funcs*(font: ptr hb_font_t) {.cdecl,
    importc: "hb_ot_font_set_funcs", dynlib: dynlibhb_ot_font_post.}