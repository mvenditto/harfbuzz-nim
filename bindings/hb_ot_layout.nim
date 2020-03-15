when defined(Linux):
  const dynlibhb_ot_layout_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}

import hb_common
import hb_font
import hb_face
import hb_ot_color
import hb_set
import hb_map

const
  HB_OT_TAG_BASE* = HB_TAG('B', 'A', 'S', 'E')
  HB_OT_TAG_GDEF* = HB_TAG('G', 'D', 'E', 'F')
  HB_OT_TAG_GSUB* = HB_TAG('G', 'S', 'U', 'B')
  HB_OT_TAG_GPOS* = HB_TAG('G', 'P', 'O', 'S')
  HB_OT_TAG_JSTF* = HB_TAG('J', 'S', 'T', 'F')


const
  HB_OT_TAG_DEFAULT_SCRIPT* = HB_TAG('D', 'F', 'L', 'T')
  HB_OT_TAG_DEFAULT_LANGUAGE* = HB_TAG('d', 'f', 'l', 't')


const
  HB_OT_MAX_TAGS_PER_SCRIPT* = 3


const
  HB_OT_MAX_TAGS_PER_LANGUAGE* = 3

proc hb_ot_tags_from_script_and_language*(script: hb_script_t;
    language: hb_language_t; script_count: ptr cuint; script_tags: ptr hb_tag_t;
    language_count: ptr cuint; language_tags: ptr hb_tag_t) {.cdecl,
    importc: "hb_ot_tags_from_script_and_language",
    dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_tag_to_script*(tag: hb_tag_t): hb_script_t {.cdecl,
    importc: "hb_ot_tag_to_script", dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_tag_to_language*(tag: hb_tag_t): hb_language_t {.cdecl,
    importc: "hb_ot_tag_to_language", dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_tags_to_script_and_language*(script_tag: hb_tag_t;
                                       language_tag: hb_tag_t;
                                       script: ptr hb_script_t;
                                       language: ptr hb_language_t) {.cdecl,
    importc: "hb_ot_tags_to_script_and_language", dynlib: dynlibhb_ot_layout_post.}

proc hb_ot_layout_has_glyph_classes*(face: ptr hb_face_t): bool {.cdecl,
    importc: "hb_ot_layout_has_glyph_classes", dynlib: dynlibhb_ot_layout_post.}

type
  hb_ot_layout_glyph_class_t* {.size: sizeof(cint).} = enum
    HB_OT_LAYOUT_GLYPH_CLASS_UNCLASSIFIED = 0,
    HB_OT_LAYOUT_GLYPH_CLASS_BASE_GLYPH = 1, HB_OT_LAYOUT_GLYPH_CLASS_LIGATURE = 2,
    HB_OT_LAYOUT_GLYPH_CLASS_MARK = 3, HB_OT_LAYOUT_GLYPH_CLASS_COMPONENT = 4


proc hb_ot_layout_get_glyph_class*(face: ptr hb_face_t; glyph: hb_codepoint_t): hb_ot_layout_glyph_class_t {.
    cdecl, importc: "hb_ot_layout_get_glyph_class", dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_get_glyphs_in_class*(face: ptr hb_face_t;
                                      klass: hb_ot_layout_glyph_class_t;
                                      glyphs: ptr hb_set_t) {.cdecl,
    importc: "hb_ot_layout_get_glyphs_in_class", dynlib: dynlibhb_ot_layout_post.}

proc hb_ot_layout_get_attach_points*(face: ptr hb_face_t; glyph: hb_codepoint_t;
                                    start_offset: cuint; point_count: ptr cuint;
                                    point_array: ptr cuint): cuint {.cdecl,
    importc: "hb_ot_layout_get_attach_points", dynlib: dynlibhb_ot_layout_post.}

proc hb_ot_layout_get_ligature_carets*(font: ptr hb_font_t;
                                      direction: hb_direction_t;
                                      glyph: hb_codepoint_t; start_offset: cuint;
                                      caret_count: ptr cuint;
                                      caret_array: ptr hb_position_t): cuint {.
    cdecl, importc: "hb_ot_layout_get_ligature_carets",
    dynlib: dynlibhb_ot_layout_post.}

const
  HB_OT_LAYOUT_NO_SCRIPT_INDEX* = 0x0000FFFF
  HB_OT_LAYOUT_NO_FEATURE_INDEX* = 0x0000FFFF
  HB_OT_LAYOUT_DEFAULT_LANGUAGE_INDEX* = 0x0000FFFF
  HB_OT_LAYOUT_NO_VARIATIONS_INDEX* = 0xFFFFFFFF

proc hb_ot_layout_table_get_script_tags*(face: ptr hb_face_t; table_tag: hb_tag_t;
                                        start_offset: cuint;
                                        script_count: ptr cuint;
                                        script_tags: ptr hb_tag_t): cuint {.cdecl,
    importc: "hb_ot_layout_table_get_script_tags", dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_table_find_script*(face: ptr hb_face_t; table_tag: hb_tag_t;
                                    script_tag: hb_tag_t; script_index: ptr cuint): bool {.
    cdecl, importc: "hb_ot_layout_table_find_script",
    dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_table_select_script*(face: ptr hb_face_t; table_tag: hb_tag_t;
                                      script_count: cuint;
                                      script_tags: ptr hb_tag_t;
                                      script_index: ptr cuint;
                                      chosen_script: ptr hb_tag_t): bool {.
    cdecl, importc: "hb_ot_layout_table_select_script",
    dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_table_get_feature_tags*(face: ptr hb_face_t; table_tag: hb_tag_t;
    start_offset: cuint; feature_count: ptr cuint; feature_tags: ptr hb_tag_t): cuint {.
    cdecl, importc: "hb_ot_layout_table_get_feature_tags",
    dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_script_get_language_tags*(face: ptr hb_face_t;
    table_tag: hb_tag_t; script_index: cuint; start_offset: cuint;
    language_count: ptr cuint; language_tags: ptr hb_tag_t): cuint {.cdecl,
    importc: "hb_ot_layout_script_get_language_tags",
    dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_script_select_language*(face: ptr hb_face_t; table_tag: hb_tag_t;
    script_index: cuint; language_count: cuint; language_tags: ptr hb_tag_t;
    language_index: ptr cuint): bool {.cdecl, importc: "hb_ot_layout_script_select_language",
                                        dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_language_get_required_feature_index*(face: ptr hb_face_t;
    table_tag: hb_tag_t; script_index: cuint; language_index: cuint;
    feature_index: ptr cuint): bool {.cdecl, importc: "hb_ot_layout_language_get_required_feature_index",
                                       dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_language_get_required_feature*(face: ptr hb_face_t;
    table_tag: hb_tag_t; script_index: cuint; language_index: cuint;
    feature_index: ptr cuint; feature_tag: ptr hb_tag_t): bool {.cdecl,
    importc: "hb_ot_layout_language_get_required_feature",
    dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_language_get_feature_indexes*(face: ptr hb_face_t;
    table_tag: hb_tag_t; script_index: cuint; language_index: cuint;
    start_offset: cuint; feature_count: ptr cuint; feature_indexes: ptr cuint): cuint {.
    cdecl, importc: "hb_ot_layout_language_get_feature_indexes",
    dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_language_get_feature_tags*(face: ptr hb_face_t;
    table_tag: hb_tag_t; script_index: cuint; language_index: cuint;
    start_offset: cuint; feature_count: ptr cuint; feature_tags: ptr hb_tag_t): cuint {.
    cdecl, importc: "hb_ot_layout_language_get_feature_tags",
    dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_language_find_feature*(face: ptr hb_face_t; table_tag: hb_tag_t;
                                        script_index: cuint;
                                        language_index: cuint;
                                        feature_tag: hb_tag_t;
                                        feature_index: ptr cuint): bool {.
    cdecl, importc: "hb_ot_layout_language_find_feature",
    dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_feature_get_lookups*(face: ptr hb_face_t; table_tag: hb_tag_t;
                                      feature_index: cuint; start_offset: cuint;
                                      lookup_count: ptr cuint;
                                      lookup_indexes: ptr cuint): cuint {.cdecl,
    importc: "hb_ot_layout_feature_get_lookups", dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_table_get_lookup_count*(face: ptr hb_face_t; table_tag: hb_tag_t): cuint {.
    cdecl, importc: "hb_ot_layout_table_get_lookup_count",
    dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_collect_features*(face: ptr hb_face_t; table_tag: hb_tag_t;
                                   scripts: ptr hb_tag_t; languages: ptr hb_tag_t;
                                   features: ptr hb_tag_t;
                                   feature_indexes: ptr hb_set_t) {.cdecl,
    importc: "hb_ot_layout_collect_features", dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_collect_lookups*(face: ptr hb_face_t; table_tag: hb_tag_t;
                                  scripts: ptr hb_tag_t; languages: ptr hb_tag_t;
                                  features: ptr hb_tag_t;
                                  lookup_indexes: ptr hb_set_t) {.cdecl,
    importc: "hb_ot_layout_collect_lookups", dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_closure_lookups*(face: ptr hb_face_t; table_tag: hb_tag_t;
                                  glyphs: ptr hb_set_t;
                                  lookup_indexes: ptr hb_set_t) {.cdecl,
    importc: "hb_ot_layout_closure_lookups", dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_closure_features*(face: ptr hb_face_t; table_tag: hb_tag_t;
                                   lookup_indexes: ptr hb_map_t;
                                   feature_indexes: ptr hb_set_t) {.cdecl,
    importc: "hb_ot_layout_closure_features", dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_lookup_collect_glyphs*(face: ptr hb_face_t; table_tag: hb_tag_t;
                                        lookup_index: cuint;
                                        glyphs_before: ptr hb_set_t;
                                        glyphs_input: ptr hb_set_t;
                                        glyphs_after: ptr hb_set_t;
                                        glyphs_output: ptr hb_set_t) {.cdecl,
    importc: "hb_ot_layout_lookup_collect_glyphs", dynlib: dynlibhb_ot_layout_post.}

proc hb_ot_layout_table_find_feature_variations*(face: ptr hb_face_t;
    table_tag: hb_tag_t; coords: ptr cint; num_coords: cuint;
    variations_index: ptr cuint): bool {.cdecl,
    importc: "hb_ot_layout_table_find_feature_variations",
    dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_feature_with_variations_get_lookups*(face: ptr hb_face_t;
    table_tag: hb_tag_t; feature_index: cuint; variations_index: cuint;
    start_offset: cuint; lookup_count: ptr cuint; lookup_indexes: ptr cuint): cuint {.
    cdecl, importc: "hb_ot_layout_feature_with_variations_get_lookups",
    dynlib: dynlibhb_ot_layout_post.}

proc hb_ot_layout_has_substitution*(face: ptr hb_face_t): bool {.cdecl,
    importc: "hb_ot_layout_has_substitution", dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_lookup_would_substitute*(face: ptr hb_face_t; lookup_index: cuint;
    glyphs: ptr hb_codepoint_t; glyphs_length: cuint; zero_context: bool): bool {.
    cdecl, importc: "hb_ot_layout_lookup_would_substitute",
    dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_lookup_substitute_closure*(face: ptr hb_face_t;
    lookup_index: cuint; glyphs: ptr hb_set_t) {.cdecl,
    importc: "hb_ot_layout_lookup_substitute_closure",
    dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_lookups_substitute_closure*(face: ptr hb_face_t;
    lookups: ptr hb_set_t; glyphs: ptr hb_set_t) {.cdecl,
    importc: "hb_ot_layout_lookups_substitute_closure",
    dynlib: dynlibhb_ot_layout_post.}
when defined(HB_NOT_IMPLEMENTED):
  proc Xhb_ot_layout_lookup_substitute*(font: ptr hb_font_t; lookup_index: cuint;
      sequence: ptr hb_ot_layout_glyph_sequence_t; out_size: cuint;
                                       glyphs_out: ptr hb_codepoint_t;
                                       clusters_out: ptr cuint;
                                       out_length: ptr cuint): bool {.cdecl,
      importc: "Xhb_ot_layout_lookup_substitute", dynlib: dynlibhb_ot_layout_post.}

proc hb_ot_layout_has_positioning*(face: ptr hb_face_t): bool {.cdecl,
    importc: "hb_ot_layout_has_positioning", dynlib: dynlibhb_ot_layout_post.}
when defined(HB_NOT_IMPLEMENTED):
  proc Xhb_ot_layout_lookup_position*(font: ptr hb_font_t; lookup_index: cuint;
      sequence: ptr hb_ot_layout_glyph_sequence_t;
                                     positions: ptr hb_glyph_position_t): bool {.
      cdecl, importc: "Xhb_ot_layout_lookup_position",
      dynlib: dynlibhb_ot_layout_post.}

proc hb_ot_layout_get_size_params*(face: ptr hb_face_t; design_size: ptr cuint;
                                  subfamily_id: ptr cuint;
                                  subfamily_name_id: ptr hb_ot_name_id_t;
                                  range_start: ptr cuint; range_end: ptr cuint): bool {.
    cdecl, importc: "hb_ot_layout_get_size_params", dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_feature_get_name_ids*(face: ptr hb_face_t; table_tag: hb_tag_t;
                                       feature_index: cuint;
                                       label_id: ptr hb_ot_name_id_t;
                                       tooltip_id: ptr hb_ot_name_id_t;
                                       sample_id: ptr hb_ot_name_id_t;
                                       num_named_parameters: ptr cuint;
                                       first_param_id: ptr hb_ot_name_id_t): bool {.
    cdecl, importc: "hb_ot_layout_feature_get_name_ids",
    dynlib: dynlibhb_ot_layout_post.}
proc hb_ot_layout_feature_get_characters*(face: ptr hb_face_t; table_tag: hb_tag_t;
    feature_index: cuint; start_offset: cuint; char_count: ptr cuint;
    characters: ptr hb_codepoint_t): cuint {.cdecl,
    importc: "hb_ot_layout_feature_get_characters",
    dynlib: dynlibhb_ot_layout_post.}

type
  hb_ot_layout_baseline_tag_t* = uint32
let
    HB_OT_LAYOUT_BASELINE_TAG_ROMAN = HB_TAG('r', 'o', 'm', 'n')
    HB_OT_LAYOUT_BASELINE_TAG_HANGING = HB_TAG('h', 'a', 'n', 'g')
    HB_OT_LAYOUT_BASELINE_TAG_IDEO_FACE_BOTTOM_OR_LEFT = HB_TAG('i', 'c', 'f', 'b')
    HB_OT_LAYOUT_BASELINE_TAG_IDEO_FACE_TOP_OR_RIGHT = HB_TAG('i', 'c', 'f', 't')
    HB_OT_LAYOUT_BASELINE_TAG_IDEO_EMBOX_BOTTOM_OR_LEFT = HB_TAG('i', 'd', 'e', 'o')
    HB_OT_LAYOUT_BASELINE_TAG_IDEO_EMBOX_TOP_OR_RIGHT = HB_TAG('i', 'd', 't', 'p')
    HB_OT_LAYOUT_BASELINE_TAG_MATH = HB_TAG('m', 'a', 't', 'h')
    HB_OT_LAYOUT_BASELINE_TAG_MAX_VALUE = HB_TAG_MAX_SIGNED


proc hb_ot_layout_get_baseline*(font: ptr hb_font_t;
                               baseline_tag: hb_ot_layout_baseline_tag_t;
                               direction: hb_direction_t; script_tag: hb_tag_t;
                               language_tag: hb_tag_t; coord: ptr hb_position_t): bool {.
    cdecl, importc: "hb_ot_layout_get_baseline", dynlib: dynlibhb_ot_layout_post.}