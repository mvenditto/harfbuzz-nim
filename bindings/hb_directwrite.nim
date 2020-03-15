when defined(Linux):
  const dynlibhb_directwrite_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}
proc hb_directwrite_face_create*(font_face: ptr IDWriteFontFace): ptr hb_face_t {.
    cdecl, importc: "hb_directwrite_face_create", dynlib: dynlibhb_directwrite_post.}
proc hb_directwrite_face_get_font_face*(face: ptr hb_face_t): ptr IDWriteFontFace {.
    cdecl, importc: "hb_directwrite_face_get_font_face",
    dynlib: dynlibhb_directwrite_post.}