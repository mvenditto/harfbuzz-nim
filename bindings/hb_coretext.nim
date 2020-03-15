when defined(Linux):
  const dynlibhb_coretext_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}

import hb_common
import hb_font
import hb_face

const
  HB_CORETEXT_TAG_MORT* = HB_TAG('m', 'o', 'r', 't')
  HB_CORETEXT_TAG_MORX* = HB_TAG('m', 'o', 'r', 'x')
  HB_CORETEXT_TAG_KERX* = HB_TAG('k', 'e', 'r', 'x')

proc hb_coretext_face_create*(cg_font: CGFontRef): ptr hb_face_t {.cdecl,
    importc: "hb_coretext_face_create", dynlib: dynlibhb_coretext_post.}
proc hb_coretext_font_create*(ct_font: CTFontRef): ptr hb_font_t {.cdecl,
    importc: "hb_coretext_font_create", dynlib: dynlibhb_coretext_post.}
proc hb_coretext_face_get_cg_font*(face: ptr hb_face_t): CGFontRef {.cdecl,
    importc: "hb_coretext_face_get_cg_font", dynlib: dynlibhb_coretext_post.}
proc hb_coretext_font_get_ct_font*(font: ptr hb_font_t): CTFontRef {.cdecl,
    importc: "hb_coretext_font_get_ct_font", dynlib: dynlibhb_coretext_post.}