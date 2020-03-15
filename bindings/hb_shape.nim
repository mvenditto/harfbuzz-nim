when defined(Linux):
  const dynlibhb_shape_post = "harfbuzz.so"

import strutils

import hb_common
import hb_font
import hb_buffer

const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}
proc hb_shape*(font: ptr hb_font_t; buffer: ptr hb_buffer_t;
              features: ptr hb_feature_t; num_features: cuint) {.cdecl,
    importc: "hb_shape", dynlib: dynlibhb_shape_post.}
proc hb_shape_full*(font: ptr hb_font_t; buffer: ptr hb_buffer_t;
                   features: ptr hb_feature_t; num_features: cuint;
                   shaper_list: cstringArray): bool {.cdecl,
    importc: "hb_shape_full", dynlib: dynlibhb_shape_post.}
proc hb_shape_list_shapers*(): cstringArray {.cdecl,
    importc: "hb_shape_list_shapers", dynlib: dynlibhb_shape_post.}