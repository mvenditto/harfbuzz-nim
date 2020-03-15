when defined(Linux):
  const dynlibhb_gobject_structs_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}


proc hb_gobject_blob_get_type*(): GType {.cdecl,
                                       importc: "hb_gobject_blob_get_type",
                                       dynlib: dynlibhb_gobject_structs_post.}
const
  HB_GOBJECT_TYPE_BLOB* = (hb_gobject_blob_get_type())


proc hb_gobject_buffer_get_type*(): GType {.cdecl,
    importc: "hb_gobject_buffer_get_type", dynlib: dynlibhb_gobject_structs_post.}
const
  HB_GOBJECT_TYPE_BUFFER* = (hb_gobject_buffer_get_type())


proc hb_gobject_face_get_type*(): GType {.cdecl,
                                       importc: "hb_gobject_face_get_type",
                                       dynlib: dynlibhb_gobject_structs_post.}
const
  HB_GOBJECT_TYPE_FACE* = (hb_gobject_face_get_type())


proc hb_gobject_font_get_type*(): GType {.cdecl,
                                       importc: "hb_gobject_font_get_type",
                                       dynlib: dynlibhb_gobject_structs_post.}
const
  HB_GOBJECT_TYPE_FONT* = (hb_gobject_font_get_type())


proc hb_gobject_font_funcs_get_type*(): GType {.cdecl,
    importc: "hb_gobject_font_funcs_get_type",
    dynlib: dynlibhb_gobject_structs_post.}
const
  HB_GOBJECT_TYPE_FONT_FUNCS* = (hb_gobject_font_funcs_get_type())

proc hb_gobject_set_get_type*(): GType {.cdecl, importc: "hb_gobject_set_get_type",
                                      dynlib: dynlibhb_gobject_structs_post.}
const
  HB_GOBJECT_TYPE_SET* = (hb_gobject_set_get_type())

proc hb_gobject_map_get_type*(): GType {.cdecl, importc: "hb_gobject_map_get_type",
                                      dynlib: dynlibhb_gobject_structs_post.}
const
  HB_GOBJECT_TYPE_MAP* = (hb_gobject_map_get_type())

proc hb_gobject_shape_plan_get_type*(): GType {.cdecl,
    importc: "hb_gobject_shape_plan_get_type",
    dynlib: dynlibhb_gobject_structs_post.}
const
  HB_GOBJECT_TYPE_SHAPE_PLAN* = (hb_gobject_shape_plan_get_type())


proc hb_gobject_unicode_funcs_get_type*(): GType {.cdecl,
    importc: "hb_gobject_unicode_funcs_get_type",
    dynlib: dynlibhb_gobject_structs_post.}
const
  HB_GOBJECT_TYPE_UNICODE_FUNCS* = (hb_gobject_unicode_funcs_get_type())


proc hb_gobject_feature_get_type*(): GType {.cdecl,
    importc: "hb_gobject_feature_get_type", dynlib: dynlibhb_gobject_structs_post.}
const
  HB_GOBJECT_TYPE_FEATURE* = (hb_gobject_feature_get_type())

proc hb_gobject_glyph_info_get_type*(): GType {.cdecl,
    importc: "hb_gobject_glyph_info_get_type",
    dynlib: dynlibhb_gobject_structs_post.}
const
  HB_GOBJECT_TYPE_GLYPH_INFO* = (hb_gobject_glyph_info_get_type())

proc hb_gobject_glyph_position_get_type*(): GType {.cdecl,
    importc: "hb_gobject_glyph_position_get_type",
    dynlib: dynlibhb_gobject_structs_post.}
const
  HB_GOBJECT_TYPE_GLYPH_POSITION* = (hb_gobject_glyph_position_get_type())

proc hb_gobject_segment_properties_get_type*(): GType {.cdecl,
    importc: "hb_gobject_segment_properties_get_type",
    dynlib: dynlibhb_gobject_structs_post.}
const
  HB_GOBJECT_TYPE_SEGMENT_PROPERTIES* = (hb_gobject_segment_properties_get_type())

proc hb_gobject_user_data_key_get_type*(): GType {.cdecl,
    importc: "hb_gobject_user_data_key_get_type",
    dynlib: dynlibhb_gobject_structs_post.}
const
  HB_GOBJECT_TYPE_USER_DATA_KEY* = (hb_gobject_user_data_key_get_type())

proc hb_gobject_ot_math_glyph_variant_get_type*(): GType {.cdecl,
    importc: "hb_gobject_ot_math_glyph_variant_get_type",
    dynlib: dynlibhb_gobject_structs_post.}
const
  HB_GOBJECT_TYPE_OT_MATH_GLYPH_VARIANT* = (
    hb_gobject_ot_math_glyph_variant_get_type())

proc hb_gobject_ot_math_glyph_part_get_type*(): GType {.cdecl,
    importc: "hb_gobject_ot_math_glyph_part_get_type",
    dynlib: dynlibhb_gobject_structs_post.}
const
  HB_GOBJECT_TYPE_OT_MATH_GLYPH_PART* = (hb_gobject_ot_math_glyph_part_get_type())
