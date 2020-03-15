when defined(Linux):
  const dynlibhb_ot_shape_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}

import hb_common
import hb_buffer
import hb_set
import hb_font

type
  hb_shape_plan_t* = object

proc hb_ot_shape_glyphs_closure*(font: ptr hb_font_t; buffer: ptr hb_buffer_t;
                                features: ptr hb_feature_t; num_features: cuint;
                                glyphs: ptr hb_set_t) {.cdecl,
    importc: "hb_ot_shape_glyphs_closure", dynlib: dynlibhb_ot_shape_post.}
proc hb_ot_shape_plan_collect_lookups*(shape_plan: ptr hb_shape_plan_t;
                                      table_tag: hb_tag_t;
                                      lookup_indexes: ptr hb_set_t) {.cdecl,
    importc: "hb_ot_shape_plan_collect_lookups", dynlib: dynlibhb_ot_shape_post.}