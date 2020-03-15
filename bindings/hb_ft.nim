when defined(Linux):
  const dynlibhb_ft_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}


proc hb_ft_face_create*(ft_face: FT_Face; destroy: hb_destroy_func_t): ptr hb_face_t {.
    cdecl, importc: "hb_ft_face_create", dynlib: dynlibhb_ft_post.}

proc hb_ft_face_create_cached*(ft_face: FT_Face): ptr hb_face_t {.cdecl,
    importc: "hb_ft_face_create_cached", dynlib: dynlibhb_ft_post.}

proc hb_ft_face_create_referenced*(ft_face: FT_Face): ptr hb_face_t {.cdecl,
    importc: "hb_ft_face_create_referenced", dynlib: dynlibhb_ft_post.}

proc hb_ft_font_create*(ft_face: FT_Face; destroy: hb_destroy_func_t): ptr hb_font_t {.
    cdecl, importc: "hb_ft_font_create", dynlib: dynlibhb_ft_post.}

proc hb_ft_font_create_referenced*(ft_face: FT_Face): ptr hb_font_t {.cdecl,
    importc: "hb_ft_font_create_referenced", dynlib: dynlibhb_ft_post.}
proc hb_ft_font_get_face*(font: ptr hb_font_t): FT_Face {.cdecl,
    importc: "hb_ft_font_get_face", dynlib: dynlibhb_ft_post.}
proc hb_ft_font_lock_face*(font: ptr hb_font_t): FT_Face {.cdecl,
    importc: "hb_ft_font_lock_face", dynlib: dynlibhb_ft_post.}
proc hb_ft_font_unlock_face*(font: ptr hb_font_t) {.cdecl,
    importc: "hb_ft_font_unlock_face", dynlib: dynlibhb_ft_post.}
proc hb_ft_font_set_load_flags*(font: ptr hb_font_t; load_flags: cint) {.cdecl,
    importc: "hb_ft_font_set_load_flags", dynlib: dynlibhb_ft_post.}
proc hb_ft_font_get_load_flags*(font: ptr hb_font_t): cint {.cdecl,
    importc: "hb_ft_font_get_load_flags", dynlib: dynlibhb_ft_post.}

proc hb_ft_font_changed*(font: ptr hb_font_t) {.cdecl, importc: "hb_ft_font_changed",
    dynlib: dynlibhb_ft_post.}

proc hb_ft_font_set_funcs*(font: ptr hb_font_t) {.cdecl,
    importc: "hb_ft_font_set_funcs", dynlib: dynlibhb_ft_post.}