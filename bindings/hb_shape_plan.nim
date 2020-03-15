when defined(Linux):
  const dynlibhb_shape_plan_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}


proc hb_shape_plan_create*(face: ptr hb_face_t; props: ptr hb_segment_properties_t;
                          user_features: ptr hb_feature_t;
                          num_user_features: cuint; shaper_list: cstringArray): ptr hb_shape_plan_t {.
    cdecl, importc: "hb_shape_plan_create", dynlib: dynlibhb_shape_plan_post.}
proc hb_shape_plan_create_cached*(face: ptr hb_face_t;
                                 props: ptr hb_segment_properties_t;
                                 user_features: ptr hb_feature_t;
                                 num_user_features: cuint;
                                 shaper_list: cstringArray): ptr hb_shape_plan_t {.
    cdecl, importc: "hb_shape_plan_create_cached", dynlib: dynlibhb_shape_plan_post.}
proc hb_shape_plan_create2*(face: ptr hb_face_t; props: ptr hb_segment_properties_t;
                           user_features: ptr hb_feature_t;
                           num_user_features: cuint; coords: ptr cint;
                           num_coords: cuint; shaper_list: cstringArray): ptr hb_shape_plan_t {.
    cdecl, importc: "hb_shape_plan_create2", dynlib: dynlibhb_shape_plan_post.}
proc hb_shape_plan_create_cached2*(face: ptr hb_face_t;
                                  props: ptr hb_segment_properties_t;
                                  user_features: ptr hb_feature_t;
                                  num_user_features: cuint; coords: ptr cint;
                                  num_coords: cuint; shaper_list: cstringArray): ptr hb_shape_plan_t {.
    cdecl, importc: "hb_shape_plan_create_cached2",
    dynlib: dynlibhb_shape_plan_post.}
proc hb_shape_plan_get_empty*(): ptr hb_shape_plan_t {.cdecl,
    importc: "hb_shape_plan_get_empty", dynlib: dynlibhb_shape_plan_post.}
proc hb_shape_plan_reference*(shape_plan: ptr hb_shape_plan_t): ptr hb_shape_plan_t {.
    cdecl, importc: "hb_shape_plan_reference", dynlib: dynlibhb_shape_plan_post.}
proc hb_shape_plan_destroy*(shape_plan: ptr hb_shape_plan_t) {.cdecl,
    importc: "hb_shape_plan_destroy", dynlib: dynlibhb_shape_plan_post.}
proc hb_shape_plan_set_user_data*(shape_plan: ptr hb_shape_plan_t;
                                 key: ptr hb_user_data_key_t; data: pointer;
                                 destroy: hb_destroy_func_t; replace: bool): bool {.
    cdecl, importc: "hb_shape_plan_set_user_data", dynlib: dynlibhb_shape_plan_post.}
proc hb_shape_plan_get_user_data*(shape_plan: ptr hb_shape_plan_t;
                                 key: ptr hb_user_data_key_t): pointer {.cdecl,
    importc: "hb_shape_plan_get_user_data", dynlib: dynlibhb_shape_plan_post.}
proc hb_shape_plan_execute*(shape_plan: ptr hb_shape_plan_t; font: ptr hb_font_t;
                           buffer: ptr hb_buffer_t; features: ptr hb_feature_t;
                           num_features: cuint): bool {.cdecl,
    importc: "hb_shape_plan_execute", dynlib: dynlibhb_shape_plan_post.}
proc hb_shape_plan_get_shaper*(shape_plan: ptr hb_shape_plan_t): cstring {.cdecl,
    importc: "hb_shape_plan_get_shaper", dynlib: dynlibhb_shape_plan_post.}