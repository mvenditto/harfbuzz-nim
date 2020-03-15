import hb_common

when defined(Linux):
  const dynlibhb_unicode_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}


const
  HB_UNICODE_MAX* = 0x0010FFFF


type
  hb_unicode_general_category_t* {.size: sizeof(cint).} = enum
    HB_UNICODE_GENERAL_CATEGORY_CONTROL, HB_UNICODE_GENERAL_CATEGORY_FORMAT,
    HB_UNICODE_GENERAL_CATEGORY_UNASSIGNED,
    HB_UNICODE_GENERAL_CATEGORY_PRIVATE_USE,
    HB_UNICODE_GENERAL_CATEGORY_SURROGATE,
    HB_UNICODE_GENERAL_CATEGORY_LOWERCASE_LETTER,
    HB_UNICODE_GENERAL_CATEGORY_MODIFIER_LETTER,
    HB_UNICODE_GENERAL_CATEGORY_OTHER_LETTER,
    HB_UNICODE_GENERAL_CATEGORY_TITLECASE_LETTER,
    HB_UNICODE_GENERAL_CATEGORY_UPPERCASE_LETTER,
    HB_UNICODE_GENERAL_CATEGORY_SPACING_MARK,
    HB_UNICODE_GENERAL_CATEGORY_ENCLOSING_MARK,
    HB_UNICODE_GENERAL_CATEGORY_NON_SPACING_MARK,
    HB_UNICODE_GENERAL_CATEGORY_DECIMAL_NUMBER,
    HB_UNICODE_GENERAL_CATEGORY_LETTER_NUMBER,
    HB_UNICODE_GENERAL_CATEGORY_OTHER_NUMBER,
    HB_UNICODE_GENERAL_CATEGORY_CONNECT_PUNCTUATION,
    HB_UNICODE_GENERAL_CATEGORY_DASH_PUNCTUATION,
    HB_UNICODE_GENERAL_CATEGORY_CLOSE_PUNCTUATION,
    HB_UNICODE_GENERAL_CATEGORY_FINAL_PUNCTUATION,
    HB_UNICODE_GENERAL_CATEGORY_INITIAL_PUNCTUATION,
    HB_UNICODE_GENERAL_CATEGORY_OTHER_PUNCTUATION,
    HB_UNICODE_GENERAL_CATEGORY_OPEN_PUNCTUATION,
    HB_UNICODE_GENERAL_CATEGORY_CURRENCY_SYMBOL,
    HB_UNICODE_GENERAL_CATEGORY_MODIFIER_SYMBOL,
    HB_UNICODE_GENERAL_CATEGORY_MATH_SYMBOL,
    HB_UNICODE_GENERAL_CATEGORY_OTHER_SYMBOL,
    HB_UNICODE_GENERAL_CATEGORY_LINE_SEPARATOR,
    HB_UNICODE_GENERAL_CATEGORY_PARAGRAPH_SEPARATOR,
    HB_UNICODE_GENERAL_CATEGORY_SPACE_SEPARATOR



type
  hb_unicode_combining_class_t* {.size: sizeof(cint).} = enum
    HB_UNICODE_COMBINING_CLASS_NOT_REORDERED = 0,
    HB_UNICODE_COMBINING_CLASS_OVERLAY = 1, HB_UNICODE_COMBINING_CLASS_NUKTA = 7,
    HB_UNICODE_COMBINING_CLASS_KANA_VOICING = 8,
    HB_UNICODE_COMBINING_CLASS_VIRAMA = 9, HB_UNICODE_COMBINING_CLASS_CCC10 = 10,
    HB_UNICODE_COMBINING_CLASS_CCC11 = 11, HB_UNICODE_COMBINING_CLASS_CCC12 = 12,
    HB_UNICODE_COMBINING_CLASS_CCC13 = 13, HB_UNICODE_COMBINING_CLASS_CCC14 = 14,
    HB_UNICODE_COMBINING_CLASS_CCC15 = 15, HB_UNICODE_COMBINING_CLASS_CCC16 = 16,
    HB_UNICODE_COMBINING_CLASS_CCC17 = 17, HB_UNICODE_COMBINING_CLASS_CCC18 = 18,
    HB_UNICODE_COMBINING_CLASS_CCC19 = 19, HB_UNICODE_COMBINING_CLASS_CCC20 = 20,
    HB_UNICODE_COMBINING_CLASS_CCC21 = 21, HB_UNICODE_COMBINING_CLASS_CCC22 = 22,
    HB_UNICODE_COMBINING_CLASS_CCC23 = 23, HB_UNICODE_COMBINING_CLASS_CCC24 = 24,
    HB_UNICODE_COMBINING_CLASS_CCC25 = 25, HB_UNICODE_COMBINING_CLASS_CCC26 = 26,
    HB_UNICODE_COMBINING_CLASS_CCC27 = 27, HB_UNICODE_COMBINING_CLASS_CCC28 = 28,
    HB_UNICODE_COMBINING_CLASS_CCC29 = 29, HB_UNICODE_COMBINING_CLASS_CCC30 = 30,
    HB_UNICODE_COMBINING_CLASS_CCC31 = 31, HB_UNICODE_COMBINING_CLASS_CCC32 = 32,
    HB_UNICODE_COMBINING_CLASS_CCC33 = 33, HB_UNICODE_COMBINING_CLASS_CCC34 = 34,
    HB_UNICODE_COMBINING_CLASS_CCC35 = 35, HB_UNICODE_COMBINING_CLASS_CCC36 = 36,
    HB_UNICODE_COMBINING_CLASS_CCC84 = 84, HB_UNICODE_COMBINING_CLASS_CCC91 = 91,
    HB_UNICODE_COMBINING_CLASS_CCC103 = 103,
    HB_UNICODE_COMBINING_CLASS_CCC107 = 107,
    HB_UNICODE_COMBINING_CLASS_CCC118 = 118,
    HB_UNICODE_COMBINING_CLASS_CCC122 = 122,
    HB_UNICODE_COMBINING_CLASS_CCC129 = 129,
    HB_UNICODE_COMBINING_CLASS_CCC130 = 130,
    HB_UNICODE_COMBINING_CLASS_CCC133 = 132,
    HB_UNICODE_COMBINING_CLASS_ATTACHED_BELOW_LEFT = 200,
    HB_UNICODE_COMBINING_CLASS_ATTACHED_BELOW = 202,
    HB_UNICODE_COMBINING_CLASS_ATTACHED_ABOVE = 214,
    HB_UNICODE_COMBINING_CLASS_ATTACHED_ABOVE_RIGHT = 216,
    HB_UNICODE_COMBINING_CLASS_BELOW_LEFT = 218,
    HB_UNICODE_COMBINING_CLASS_BELOW = 220,
    HB_UNICODE_COMBINING_CLASS_BELOW_RIGHT = 222,
    HB_UNICODE_COMBINING_CLASS_LEFT = 224, HB_UNICODE_COMBINING_CLASS_RIGHT = 226,
    HB_UNICODE_COMBINING_CLASS_ABOVE_LEFT = 228,
    HB_UNICODE_COMBINING_CLASS_ABOVE = 230,
    HB_UNICODE_COMBINING_CLASS_ABOVE_RIGHT = 232,
    HB_UNICODE_COMBINING_CLASS_DOUBLE_BELOW = 233,
    HB_UNICODE_COMBINING_CLASS_DOUBLE_ABOVE = 234,
    HB_UNICODE_COMBINING_CLASS_IOTA_SUBSCRIPT = 240,
    HB_UNICODE_COMBINING_CLASS_INVALID = 255

type
    hb_unicode_funcs_t* = object of RootObj

proc hb_unicode_funcs_get_default*(): ptr hb_unicode_funcs_t {.cdecl,
    importc: "hb_unicode_funcs_get_default", dynlib: dynlibhb_unicode_post.}
proc hb_unicode_funcs_create*(parent: ptr hb_unicode_funcs_t): ptr hb_unicode_funcs_t {.
    cdecl, importc: "hb_unicode_funcs_create", dynlib: dynlibhb_unicode_post.}
proc hb_unicode_funcs_get_empty*(): ptr hb_unicode_funcs_t {.cdecl,
    importc: "hb_unicode_funcs_get_empty", dynlib: dynlibhb_unicode_post.}
proc hb_unicode_funcs_reference*(ufuncs: ptr hb_unicode_funcs_t): ptr hb_unicode_funcs_t {.
    cdecl, importc: "hb_unicode_funcs_reference", dynlib: dynlibhb_unicode_post.}
proc hb_unicode_funcs_destroy*(ufuncs: ptr hb_unicode_funcs_t) {.cdecl,
    importc: "hb_unicode_funcs_destroy", dynlib: dynlibhb_unicode_post.}
proc hb_unicode_funcs_set_user_data*(ufuncs: ptr hb_unicode_funcs_t;
                                    key: ptr hb_user_data_key_t; data: pointer;
                                    destroy: hb_destroy_func_t; replace: bool): bool {.
    cdecl, importc: "hb_unicode_funcs_set_user_data", dynlib: dynlibhb_unicode_post.}
proc hb_unicode_funcs_get_user_data*(ufuncs: ptr hb_unicode_funcs_t;
                                    key: ptr hb_user_data_key_t): pointer {.cdecl,
    importc: "hb_unicode_funcs_get_user_data", dynlib: dynlibhb_unicode_post.}
proc hb_unicode_funcs_make_immutable*(ufuncs: ptr hb_unicode_funcs_t) {.cdecl,
    importc: "hb_unicode_funcs_make_immutable", dynlib: dynlibhb_unicode_post.}
proc hb_unicode_funcs_is_immutable*(ufuncs: ptr hb_unicode_funcs_t): bool {.
    cdecl, importc: "hb_unicode_funcs_is_immutable", dynlib: dynlibhb_unicode_post.}
proc hb_unicode_funcs_get_parent*(ufuncs: ptr hb_unicode_funcs_t): ptr hb_unicode_funcs_t {.
    cdecl, importc: "hb_unicode_funcs_get_parent", dynlib: dynlibhb_unicode_post.}

type
  hb_unicode_combining_class_func_t* = proc (ufuncs: ptr hb_unicode_funcs_t;
      unicode: hb_codepoint_t; user_data: pointer): hb_unicode_combining_class_t {.
      cdecl.}
  hb_unicode_general_category_func_t* = proc (ufuncs: ptr hb_unicode_funcs_t;
      unicode: hb_codepoint_t; user_data: pointer): hb_unicode_general_category_t {.
      cdecl.}
  hb_unicode_mirroring_func_t* = proc (ufuncs: ptr hb_unicode_funcs_t;
                                    unicode: hb_codepoint_t; user_data: pointer): hb_codepoint_t {.
      cdecl.}
  hb_unicode_script_func_t* = proc (ufuncs: ptr hb_unicode_funcs_t;
                                 unicode: hb_codepoint_t; user_data: pointer): hb_script_t {.
      cdecl.}
  hb_unicode_compose_func_t* = proc (ufuncs: ptr hb_unicode_funcs_t;
                                  a: hb_codepoint_t; b: hb_codepoint_t;
                                  ab: ptr hb_codepoint_t; user_data: pointer): bool {.
      cdecl.}
  hb_unicode_decompose_func_t* = proc (ufuncs: ptr hb_unicode_funcs_t;
                                    ab: hb_codepoint_t; a: ptr hb_codepoint_t;
                                    b: ptr hb_codepoint_t; user_data: pointer): bool {.
      cdecl.}


proc hb_unicode_funcs_set_combining_class_func*(ufuncs: ptr hb_unicode_funcs_t;
    `func`: hb_unicode_combining_class_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl, importc: "hb_unicode_funcs_set_combining_class_func",
                                dynlib: dynlibhb_unicode_post.}

proc hb_unicode_funcs_set_general_category_func*(ufuncs: ptr hb_unicode_funcs_t;
    `func`: hb_unicode_general_category_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl, importc: "hb_unicode_funcs_set_general_category_func",
                                dynlib: dynlibhb_unicode_post.}

proc hb_unicode_funcs_set_mirroring_func*(ufuncs: ptr hb_unicode_funcs_t;
    `func`: hb_unicode_mirroring_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl,
                                importc: "hb_unicode_funcs_set_mirroring_func",
                                dynlib: dynlibhb_unicode_post.}

proc hb_unicode_funcs_set_script_func*(ufuncs: ptr hb_unicode_funcs_t;
                                      `func`: hb_unicode_script_func_t;
                                      user_data: pointer;
                                      destroy: hb_destroy_func_t) {.cdecl,
    importc: "hb_unicode_funcs_set_script_func", dynlib: dynlibhb_unicode_post.}

proc hb_unicode_funcs_set_compose_func*(ufuncs: ptr hb_unicode_funcs_t;
                                       `func`: hb_unicode_compose_func_t;
                                       user_data: pointer;
                                       destroy: hb_destroy_func_t) {.cdecl,
    importc: "hb_unicode_funcs_set_compose_func", dynlib: dynlibhb_unicode_post.}

proc hb_unicode_funcs_set_decompose_func*(ufuncs: ptr hb_unicode_funcs_t;
    `func`: hb_unicode_decompose_func_t; user_data: pointer;
    destroy: hb_destroy_func_t) {.cdecl,
                                importc: "hb_unicode_funcs_set_decompose_func",
                                dynlib: dynlibhb_unicode_post.}

proc hb_unicode_combining_class*(ufuncs: ptr hb_unicode_funcs_t;
                                unicode: hb_codepoint_t): hb_unicode_combining_class_t {.
    cdecl, importc: "hb_unicode_combining_class", dynlib: dynlibhb_unicode_post.}

proc hb_unicode_general_category*(ufuncs: ptr hb_unicode_funcs_t;
                                 unicode: hb_codepoint_t): hb_unicode_general_category_t {.
    cdecl, importc: "hb_unicode_general_category", dynlib: dynlibhb_unicode_post.}

proc hb_unicode_mirroring*(ufuncs: ptr hb_unicode_funcs_t; unicode: hb_codepoint_t): hb_codepoint_t {.
    cdecl, importc: "hb_unicode_mirroring", dynlib: dynlibhb_unicode_post.}

proc hb_unicode_script*(ufuncs: ptr hb_unicode_funcs_t; unicode: hb_codepoint_t): hb_script_t {.
    cdecl, importc: "hb_unicode_script", dynlib: dynlibhb_unicode_post.}
proc hb_unicode_compose*(ufuncs: ptr hb_unicode_funcs_t; a: hb_codepoint_t;
                        b: hb_codepoint_t; ab: ptr hb_codepoint_t): bool {.cdecl,
    importc: "hb_unicode_compose", dynlib: dynlibhb_unicode_post.}
proc hb_unicode_decompose*(ufuncs: ptr hb_unicode_funcs_t; ab: hb_codepoint_t;
                          a: ptr hb_codepoint_t; b: ptr hb_codepoint_t): bool {.
    cdecl, importc: "hb_unicode_decompose", dynlib: dynlibhb_unicode_post.}