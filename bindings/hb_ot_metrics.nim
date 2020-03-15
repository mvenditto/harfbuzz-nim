when defined(Linux):
  const dynlibhb_ot_metrics_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}

import hb_common
import hb_font

type hb_ot_metrics_tag_t = uint32
let
    HB_OT_METRICS_TAG_HORIZONTAL_ASCENDER = HB_TAG('h', 'a', 's', 'c')
    HB_OT_METRICS_TAG_HORIZONTAL_DESCENDER = HB_TAG('h', 'd', 's', 'c')
    HB_OT_METRICS_TAG_HORIZONTAL_LINE_GAP = HB_TAG('h', 'l', 'g', 'p')
    HB_OT_METRICS_TAG_HORIZONTAL_CLIPPING_ASCENT = HB_TAG('h', 'c', 'l', 'a')
    HB_OT_METRICS_TAG_HORIZONTAL_CLIPPING_DESCENT = HB_TAG('h', 'c', 'l', 'd')
    HB_OT_METRICS_TAG_VERTICAL_ASCENDER = HB_TAG('v', 'a', 's', 'c')
    HB_OT_METRICS_TAG_VERTICAL_DESCENDER = HB_TAG('v', 'd', 's', 'c')
    HB_OT_METRICS_TAG_VERTICAL_LINE_GAP = HB_TAG('v', 'l', 'g', 'p')
    HB_OT_METRICS_TAG_HORIZONTAL_CARET_RISE = HB_TAG('h', 'c', 'r', 's')
    HB_OT_METRICS_TAG_HORIZONTAL_CARET_RUN = HB_TAG('h', 'c', 'r', 'n')
    HB_OT_METRICS_TAG_HORIZONTAL_CARET_OFFSET = HB_TAG('h', 'c', 'o', 'f')
    HB_OT_METRICS_TAG_VERTICAL_CARET_RISE = HB_TAG('v', 'c', 'r', 's')
    HB_OT_METRICS_TAG_VERTICAL_CARET_RUN = HB_TAG('v', 'c', 'r', 'n')
    HB_OT_METRICS_TAG_VERTICAL_CARET_OFFSET = HB_TAG('v', 'c', 'o', 'f')
    HB_OT_METRICS_TAG_X_HEIGHT = HB_TAG('x', 'h', 'g', 't')
    HB_OT_METRICS_TAG_CAP_HEIGHT = HB_TAG('c', 'p', 'h', 't')
    HB_OT_METRICS_TAG_SUBSCRIPT_EM_X_SIZE = HB_TAG('s', 'b', 'x', 's')
    HB_OT_METRICS_TAG_SUBSCRIPT_EM_Y_SIZE = HB_TAG('s', 'b', 'y', 's')
    HB_OT_METRICS_TAG_SUBSCRIPT_EM_X_OFFSET = HB_TAG('s', 'b', 'x', 'o')
    HB_OT_METRICS_TAG_SUBSCRIPT_EM_Y_OFFSET = HB_TAG('s', 'b', 'y', 'o')
    HB_OT_METRICS_TAG_SUPERSCRIPT_EM_X_SIZE = HB_TAG('s', 'p', 'x', 's')
    HB_OT_METRICS_TAG_SUPERSCRIPT_EM_Y_SIZE = HB_TAG('s', 'p', 'y', 's')
    HB_OT_METRICS_TAG_SUPERSCRIPT_EM_X_OFFSET = HB_TAG('s', 'p', 'x', 'o')
    HB_OT_METRICS_TAG_SUPERSCRIPT_EM_Y_OFFSET = HB_TAG('s', 'p', 'y', 'o')
    HB_OT_METRICS_TAG_STRIKEOUT_SIZE = HB_TAG('s', 't', 'r', 's')
    HB_OT_METRICS_TAG_STRIKEOUT_OFFSET = HB_TAG('s', 't', 'r', 'o')
    HB_OT_METRICS_TAG_UNDERLINE_SIZE = HB_TAG('u', 'n', 'd', 's')
    HB_OT_METRICS_TAG_UNDERLINE_OFFSET = HB_TAG('u', 'n', 'd', 'o')
    HB_OT_METRICS_TAG_MAX_VALUE = HB_TAG_MAX_SIGNED


proc hb_ot_metrics_get_position*(font: ptr hb_font_t;
                                metrics_tag: hb_ot_metrics_tag_t;
                                position: ptr hb_position_t): bool {.cdecl,
    importc: "hb_ot_metrics_get_position", dynlib: dynlibhb_ot_metrics_post.}
proc hb_ot_metrics_get_variation*(font: ptr hb_font_t;
                                 metrics_tag: hb_ot_metrics_tag_t): cfloat {.cdecl,
    importc: "hb_ot_metrics_get_variation", dynlib: dynlibhb_ot_metrics_post.}
proc hb_ot_metrics_get_x_variation*(font: ptr hb_font_t;
                                   metrics_tag: hb_ot_metrics_tag_t): hb_position_t {.
    cdecl, importc: "hb_ot_metrics_get_x_variation",
    dynlib: dynlibhb_ot_metrics_post.}
proc hb_ot_metrics_get_y_variation*(font: ptr hb_font_t;
                                   metrics_tag: hb_ot_metrics_tag_t): hb_position_t {.
    cdecl, importc: "hb_ot_metrics_get_y_variation",
    dynlib: dynlibhb_ot_metrics_post.}