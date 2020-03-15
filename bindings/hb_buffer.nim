when defined(Linux):
  const dynlibhb_buffer_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}

import hb_common
import hb_unicode
import hb_font

type
  hb_glyph_info_t* {.bycopy.} = object
    codepoint*: hb_codepoint_t
    mask*: hb_mask_t
    cluster*: uint32
    var1*: hb_var_int_t
    var2*: hb_var_int_t



type
  hb_glyph_flags_t* {.size: sizeof(cint).} = enum
    HB_GLYPH_FLAG_UNSAFE_TO_BREAK = 0x00000001

const
  HB_GLYPH_FLAG_DEFINED = HB_GLYPH_FLAG_UNSAFE_TO_BREAK

proc hb_glyph_info_get_glyph_flags*(info: ptr hb_glyph_info_t): hb_glyph_flags_t {.
    cdecl, importc: "hb_glyph_info_get_glyph_flags", dynlib: dynlibhb_buffer_post.}
template hb_glyph_info_get_glyph_flags*(info: untyped): untyped =
  ((hb_glyph_flags_t)(cast[cuint]((info).mask) and HB_GLYPH_FLAG_DEFINED))


type
  hb_glyph_position_t* {.bycopy.} = object
    x_advance*: hb_position_t
    y_advance*: hb_position_t
    x_offset*: hb_position_t
    y_offset*: hb_position_t
    `var`*: hb_var_int_t

  hb_buffer_t* {.bycopy.} = object

type
  hb_segment_properties_t* {.bycopy.} = object
    direction*: hb_direction_t
    script*: hb_script_t
    language*: hb_language_t
    reserved1*: pointer
    reserved2*: pointer



proc hb_segment_properties_equal*(a: ptr hb_segment_properties_t;
                                 b: ptr hb_segment_properties_t): bool {.cdecl,
    importc: "hb_segment_properties_equal", dynlib: dynlibhb_buffer_post.}
proc hb_segment_properties_hash*(p: ptr hb_segment_properties_t): cuint {.cdecl,
    importc: "hb_segment_properties_hash", dynlib: dynlibhb_buffer_post.}


proc hb_buffer_create*(): ptr hb_buffer_t {.cdecl, importc: "hb_buffer_create",
                                        dynlib: dynlibhb_buffer_post.}
proc hb_buffer_get_empty*(): ptr hb_buffer_t {.cdecl, importc: "hb_buffer_get_empty",
    dynlib: dynlibhb_buffer_post.}
proc hb_buffer_reference*(buffer: ptr hb_buffer_t): ptr hb_buffer_t {.cdecl,
    importc: "hb_buffer_reference", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_destroy*(buffer: ptr hb_buffer_t) {.cdecl,
    importc: "hb_buffer_destroy", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_set_user_data*(buffer: ptr hb_buffer_t; key: ptr hb_user_data_key_t;
                             data: pointer; destroy: hb_destroy_func_t;
                             replace: bool): bool {.cdecl,
    importc: "hb_buffer_set_user_data", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_get_user_data*(buffer: ptr hb_buffer_t; key: ptr hb_user_data_key_t): pointer {.
    cdecl, importc: "hb_buffer_get_user_data", dynlib: dynlibhb_buffer_post.}

type
  hb_buffer_content_type_t* {.size: sizeof(cint).} = enum
    HB_BUFFER_CONTENT_TYPE_INVALID = 0, HB_BUFFER_CONTENT_TYPE_UNICODE,
    HB_BUFFER_CONTENT_TYPE_GLYPHS


proc hb_buffer_set_content_type*(buffer: ptr hb_buffer_t;
                                content_type: hb_buffer_content_type_t) {.cdecl,
    importc: "hb_buffer_set_content_type", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_get_content_type*(buffer: ptr hb_buffer_t): hb_buffer_content_type_t {.
    cdecl, importc: "hb_buffer_get_content_type", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_set_unicode_funcs*(buffer: ptr hb_buffer_t;
                                 unicode_funcs: ptr hb_unicode_funcs_t) {.cdecl,
    importc: "hb_buffer_set_unicode_funcs", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_get_unicode_funcs*(buffer: ptr hb_buffer_t): ptr hb_unicode_funcs_t {.
    cdecl, importc: "hb_buffer_get_unicode_funcs", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_set_direction*(buffer: ptr hb_buffer_t; direction: hb_direction_t) {.
    cdecl, importc: "hb_buffer_set_direction", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_get_direction*(buffer: ptr hb_buffer_t): hb_direction_t {.cdecl,
    importc: "hb_buffer_get_direction", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_set_script*(buffer: ptr hb_buffer_t; script: hb_script_t) {.cdecl,
    importc: "hb_buffer_set_script", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_get_script*(buffer: ptr hb_buffer_t): hb_script_t {.cdecl,
    importc: "hb_buffer_get_script", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_set_language*(buffer: ptr hb_buffer_t; language: hb_language_t) {.
    cdecl, importc: "hb_buffer_set_language", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_get_language*(buffer: ptr hb_buffer_t): hb_language_t {.cdecl,
    importc: "hb_buffer_get_language", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_set_segment_properties*(buffer: ptr hb_buffer_t;
                                      props: ptr hb_segment_properties_t) {.cdecl,
    importc: "hb_buffer_set_segment_properties", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_get_segment_properties*(buffer: ptr hb_buffer_t;
                                      props: ptr hb_segment_properties_t) {.cdecl,
    importc: "hb_buffer_get_segment_properties", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_guess_segment_properties*(buffer: ptr hb_buffer_t) {.cdecl,
    importc: "hb_buffer_guess_segment_properties", dynlib: dynlibhb_buffer_post.}

type
  hb_buffer_flags_t* {.size: sizeof(cint).} = enum
    HB_BUFFER_FLAG_DEFAULT = 0x00000000, HB_BUFFER_FLAG_BOT = 0x00000001,
    HB_BUFFER_FLAG_EOT = 0x00000002,
    HB_BUFFER_FLAG_PRESERVE_DEFAULT_IGNORABLES = 0x00000004,
    HB_BUFFER_FLAG_REMOVE_DEFAULT_IGNORABLES = 0x00000008,
    HB_BUFFER_FLAG_DO_NOT_INSERT_DOTTED_CIRCLE = 0x00000010


proc hb_buffer_set_flags*(buffer: ptr hb_buffer_t; flags: hb_buffer_flags_t) {.cdecl,
    importc: "hb_buffer_set_flags", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_get_flags*(buffer: ptr hb_buffer_t): hb_buffer_flags_t {.cdecl,
    importc: "hb_buffer_get_flags", dynlib: dynlibhb_buffer_post.}

type
  hb_buffer_cluster_level_t* {.size: sizeof(cint).} = enum
    HB_BUFFER_CLUSTER_LEVEL_MONOTONE_GRAPHEMES = 0,
    HB_BUFFER_CLUSTER_LEVEL_MONOTONE_CHARACTERS = 1,
    HB_BUFFER_CLUSTER_LEVEL_CHARACTERS = 2

const
  HB_BUFFER_CLUSTER_LEVEL_DEFAULT* = HB_BUFFER_CLUSTER_LEVEL_MONOTONE_GRAPHEMES

proc hb_buffer_set_cluster_level*(buffer: ptr hb_buffer_t;
                                 cluster_level: hb_buffer_cluster_level_t) {.
    cdecl, importc: "hb_buffer_set_cluster_level", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_get_cluster_level*(buffer: ptr hb_buffer_t): hb_buffer_cluster_level_t {.
    cdecl, importc: "hb_buffer_get_cluster_level", dynlib: dynlibhb_buffer_post.}

const
  HB_BUFFER_REPLACEMENT_CODEPOINT_DEFAULT* = 0x0000FFFD

proc hb_buffer_set_replacement_codepoint*(buffer: ptr hb_buffer_t;
    replacement: hb_codepoint_t) {.cdecl, importc: "hb_buffer_set_replacement_codepoint",
                                 dynlib: dynlibhb_buffer_post.}
proc hb_buffer_get_replacement_codepoint*(buffer: ptr hb_buffer_t): hb_codepoint_t {.
    cdecl, importc: "hb_buffer_get_replacement_codepoint",
    dynlib: dynlibhb_buffer_post.}
proc hb_buffer_set_invisible_glyph*(buffer: ptr hb_buffer_t;
                                   invisible: hb_codepoint_t) {.cdecl,
    importc: "hb_buffer_set_invisible_glyph", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_get_invisible_glyph*(buffer: ptr hb_buffer_t): hb_codepoint_t {.cdecl,
    importc: "hb_buffer_get_invisible_glyph", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_reset*(buffer: ptr hb_buffer_t) {.cdecl, importc: "hb_buffer_reset",
    dynlib: dynlibhb_buffer_post.}
proc hb_buffer_clear_contents*(buffer: ptr hb_buffer_t) {.cdecl,
    importc: "hb_buffer_clear_contents", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_pre_allocate*(buffer: ptr hb_buffer_t; size: cuint): bool {.cdecl,
    importc: "hb_buffer_pre_allocate", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_allocation_successful*(buffer: ptr hb_buffer_t): bool {.cdecl,
    importc: "hb_buffer_allocation_successful", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_reverse*(buffer: ptr hb_buffer_t) {.cdecl,
    importc: "hb_buffer_reverse", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_reverse_range*(buffer: ptr hb_buffer_t; start: cuint; `end`: cuint) {.
    cdecl, importc: "hb_buffer_reverse_range", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_reverse_clusters*(buffer: ptr hb_buffer_t) {.cdecl,
    importc: "hb_buffer_reverse_clusters", dynlib: dynlibhb_buffer_post.}

proc hb_buffer_add*(buffer: ptr hb_buffer_t; codepoint: hb_codepoint_t; cluster: cuint) {.
    cdecl, importc: "hb_buffer_add", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_add_utf8*(buffer: ptr hb_buffer_t; text: cstring; text_length: cint;
                        item_offset: cuint; item_length: cint) {.cdecl,
    importc: "hb_buffer_add_utf8", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_add_utf16*(buffer: ptr hb_buffer_t; text: ptr uint16;
                         text_length: cint; item_offset: cuint; item_length: cint) {.
    cdecl, importc: "hb_buffer_add_utf16", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_add_utf32*(buffer: ptr hb_buffer_t; text: ptr uint32;
                         text_length: cint; item_offset: cuint; item_length: cint) {.
    cdecl, importc: "hb_buffer_add_utf32", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_add_latin1*(buffer: ptr hb_buffer_t; text: ptr uint8;
                          text_length: cint; item_offset: cuint; item_length: cint) {.
    cdecl, importc: "hb_buffer_add_latin1", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_add_codepoints*(buffer: ptr hb_buffer_t; text: ptr hb_codepoint_t;
                              text_length: cint; item_offset: cuint;
                              item_length: cint) {.cdecl,
    importc: "hb_buffer_add_codepoints", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_append*(buffer: ptr hb_buffer_t; source: ptr hb_buffer_t; start: cuint;
                      `end`: cuint) {.cdecl, importc: "hb_buffer_append",
                                    dynlib: dynlibhb_buffer_post.}
proc hb_buffer_set_length*(buffer: ptr hb_buffer_t; length: cuint): bool {.cdecl,
    importc: "hb_buffer_set_length", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_get_length*(buffer: ptr hb_buffer_t): cuint {.cdecl,
    importc: "hb_buffer_get_length", dynlib: dynlibhb_buffer_post.}

proc hb_buffer_get_glyph_infos*(buffer: ptr hb_buffer_t; length: ptr cuint): ptr hb_glyph_info_t {.
    cdecl, importc: "hb_buffer_get_glyph_infos", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_get_glyph_positions*(buffer: ptr hb_buffer_t; length: ptr cuint): ptr hb_glyph_position_t {.
    cdecl, importc: "hb_buffer_get_glyph_positions", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_normalize_glyphs*(buffer: ptr hb_buffer_t) {.cdecl,
    importc: "hb_buffer_normalize_glyphs", dynlib: dynlibhb_buffer_post.}

type
  hb_buffer_serialize_flags_t* {.size: sizeof(cint).} = enum
    HB_BUFFER_SERIALIZE_FLAG_DEFAULT = 0x00000000,
    HB_BUFFER_SERIALIZE_FLAG_NO_CLUSTERS = 0x00000001,
    HB_BUFFER_SERIALIZE_FLAG_NO_POSITIONS = 0x00000002,
    HB_BUFFER_SERIALIZE_FLAG_NO_GLYPH_NAMES = 0x00000004,
    HB_BUFFER_SERIALIZE_FLAG_GLYPH_EXTENTS = 0x00000008,
    HB_BUFFER_SERIALIZE_FLAG_GLYPH_FLAGS = 0x00000010,
    HB_BUFFER_SERIALIZE_FLAG_NO_ADVANCES = 0x00000020



type
  hb_buffer_serialize_format_t* {.size: sizeof(cint).} = enum
    HB_BUFFER_SERIALIZE_FORMAT_INVALID = HB_TAG_NONE
    HB_BUFFER_SERIALIZE_FORMAT_JSON = HB_TAG('J', 'S', 'O', 'N'),
    HB_BUFFER_SERIALIZE_FORMAT_TEXT = HB_TAG('T', 'E', 'X', 'T'),


proc hb_buffer_serialize_format_from_string*(str: cstring; len: cint): hb_buffer_serialize_format_t {.
    cdecl, importc: "hb_buffer_serialize_format_from_string",
    dynlib: dynlibhb_buffer_post.}
proc hb_buffer_serialize_format_to_string*(format: hb_buffer_serialize_format_t): cstring {.
    cdecl, importc: "hb_buffer_serialize_format_to_string",
    dynlib: dynlibhb_buffer_post.}
proc hb_buffer_serialize_list_formats*(): cstringArray {.cdecl,
    importc: "hb_buffer_serialize_list_formats", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_serialize_glyphs*(buffer: ptr hb_buffer_t; start: cuint; `end`: cuint;
                                buf: cstring; buf_size: cuint;
                                buf_consumed: ptr cuint; font: ptr hb_font_t;
                                format: hb_buffer_serialize_format_t;
                                flags: hb_buffer_serialize_flags_t): cuint {.cdecl,
    importc: "hb_buffer_serialize_glyphs", dynlib: dynlibhb_buffer_post.}
proc hb_buffer_deserialize_glyphs*(buffer: ptr hb_buffer_t; buf: cstring;
                                  buf_len: cint; end_ptr: cstringArray;
                                  font: ptr hb_font_t;
                                  format: hb_buffer_serialize_format_t): bool {.
    cdecl, importc: "hb_buffer_deserialize_glyphs", dynlib: dynlibhb_buffer_post.}

type
  hb_buffer_diff_flags_t* {.size: sizeof(cint).} = enum
    HB_BUFFER_DIFF_FLAG_EQUAL = 0x00000000,
    HB_BUFFER_DIFF_FLAG_CONTENT_TYPE_MISMATCH = 0x00000001,
    HB_BUFFER_DIFF_FLAG_LENGTH_MISMATCH = 0x00000002,
    HB_BUFFER_DIFF_FLAG_NOTDEF_PRESENT = 0x00000004,
    HB_BUFFER_DIFF_FLAG_DOTTED_CIRCLE_PRESENT = 0x00000008,
    HB_BUFFER_DIFF_FLAG_CODEPOINT_MISMATCH = 0x00000010,
    HB_BUFFER_DIFF_FLAG_CLUSTER_MISMATCH = 0x00000020,
    HB_BUFFER_DIFF_FLAG_GLYPH_FLAGS_MISMATCH = 0x00000040,
    HB_BUFFER_DIFF_FLAG_POSITION_MISMATCH = 0x00000080



proc hb_buffer_diff*(buffer: ptr hb_buffer_t; reference: ptr hb_buffer_t;
                    dottedcircle_glyph: hb_codepoint_t; position_fuzz: cuint): hb_buffer_diff_flags_t {.
    cdecl, importc: "hb_buffer_diff", dynlib: dynlibhb_buffer_post.}

type
  hb_buffer_message_func_t* = proc (buffer: ptr hb_buffer_t; font: ptr hb_font_t;
                                 message: cstring; user_data: pointer): bool {.
      cdecl.}

proc hb_buffer_set_message_func*(buffer: ptr hb_buffer_t;
                                `func`: hb_buffer_message_func_t;
                                user_data: pointer; destroy: hb_destroy_func_t) {.
    cdecl, importc: "hb_buffer_set_message_func", dynlib: dynlibhb_buffer_post.}