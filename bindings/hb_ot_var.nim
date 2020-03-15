when defined(Linux):
  const dynlibhb_ot_var_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}

import hb_common
import hb_face
import hb_ot_name

const
  HB_OT_TAG_VAR_AXIS_ITALIC* = HB_TAG('i', 't', 'a', 'l')
  HB_OT_TAG_VAR_AXIS_OPTICAL_SIZE* = HB_TAG('o', 'p', 's', 'z')
  HB_OT_TAG_VAR_AXIS_SLANT* = HB_TAG('s', 'l', 'n', 't')
  HB_OT_TAG_VAR_AXIS_WIDTH* = HB_TAG('w', 'd', 't', 'h')
  HB_OT_TAG_VAR_AXIS_WEIGHT* = HB_TAG('w', 'g', 'h', 't')


proc hb_ot_var_has_data*(face: ptr hb_face_t): bool {.cdecl,
    importc: "hb_ot_var_has_data", dynlib: dynlibhb_ot_var_post.}

proc hb_ot_var_get_axis_count*(face: ptr hb_face_t): cuint {.cdecl,
    importc: "hb_ot_var_get_axis_count", dynlib: dynlibhb_ot_var_post.}

type
  hb_ot_var_axis_flags_t* {.size: sizeof(cint).} = enum
    HB_OT_VAR_AXIS_FLAG_HIDDEN = 0x00000001,
    HB_OT_VAR_AXIS_FLAG_MAX_VALUE = HB_TAG_MAX_SIGNED



type
  hb_ot_var_axis_info_t* {.bycopy.} = object
    axis_index*: cuint
    tag*: hb_tag_t
    name_id*: hb_ot_name_id_t
    flags*: hb_ot_var_axis_flags_t
    min_value*: cfloat
    default_value*: cfloat
    max_value*: cfloat
    reserved*: cuint


proc hb_ot_var_get_axis_infos*(face: ptr hb_face_t; start_offset: cuint;
                              axes_count: ptr cuint;
                              axes_array: ptr hb_ot_var_axis_info_t): cuint {.cdecl,
    importc: "hb_ot_var_get_axis_infos", dynlib: dynlibhb_ot_var_post.}
proc hb_ot_var_find_axis_info*(face: ptr hb_face_t; axis_tag: hb_tag_t;
                              axis_info: ptr hb_ot_var_axis_info_t): bool {.
    cdecl, importc: "hb_ot_var_find_axis_info", dynlib: dynlibhb_ot_var_post.}

proc hb_ot_var_get_named_instance_count*(face: ptr hb_face_t): cuint {.cdecl,
    importc: "hb_ot_var_get_named_instance_count", dynlib: dynlibhb_ot_var_post.}
proc hb_ot_var_named_instance_get_subfamily_name_id*(face: ptr hb_face_t;
    instance_index: cuint): hb_ot_name_id_t {.cdecl,
    importc: "hb_ot_var_named_instance_get_subfamily_name_id",
    dynlib: dynlibhb_ot_var_post.}
proc hb_ot_var_named_instance_get_postscript_name_id*(face: ptr hb_face_t;
    instance_index: cuint): hb_ot_name_id_t {.cdecl,
    importc: "hb_ot_var_named_instance_get_postscript_name_id",
    dynlib: dynlibhb_ot_var_post.}
proc hb_ot_var_named_instance_get_design_coords*(face: ptr hb_face_t;
    instance_index: cuint; coords_length: ptr cuint; coords: ptr cfloat): cuint {.cdecl,
    importc: "hb_ot_var_named_instance_get_design_coords",
    dynlib: dynlibhb_ot_var_post.}

proc hb_ot_var_normalize_variations*(face: ptr hb_face_t;
                                    variations: ptr hb_variation_t;
                                    variations_length: cuint; coords: ptr cint;
                                    coords_length: cuint) {.cdecl,
    importc: "hb_ot_var_normalize_variations", dynlib: dynlibhb_ot_var_post.}
proc hb_ot_var_normalize_coords*(face: ptr hb_face_t; coords_length: cuint;
                                design_coords: ptr cfloat;
                                normalized_coords: ptr cint) {.cdecl,
    importc: "hb_ot_var_normalize_coords", dynlib: dynlibhb_ot_var_post.}