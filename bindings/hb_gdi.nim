when defined(Linux):
  const dynlibhb_gdi_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}
proc hb_gdi_face_create*(hfont: HFONT): ptr hb_face_t {.cdecl,
    importc: "hb_gdi_face_create", dynlib: dynlibhb_gdi_post.}