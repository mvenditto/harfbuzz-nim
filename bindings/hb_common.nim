when defined(Linux):
  const dynlibhb_common_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}


type
  hb_codepoint_t* = uint32
  hb_position_t* = int32
  hb_mask_t* = uint32
  hb_var_int_t* {.bycopy.} = object {.union.}
    u32*: uint32
    i32*: int32
    u16*: array[2, uint16]
    i16*: array[2, int16]
    u8*: array[4, uint8]
    i8*: array[4, int8]

type
  hb_tag_t* = uint32

template HB_TAG*(c1, c2, c3, c4: untyped): untyped =
  ((hb_tag_t)((((uint32)(c1) and 0x000000FF) shl 24) or
      (((uint32)(c2) and 0x000000FF) shl 16) or
      (((uint32)(c3) and 0x000000FF) shl 8) or ((uint32)(c4) and 0x000000FF)))

template HB_UNTAG*(tag: untyped): untyped =
  (uint8)(((tag) shr 24) and 0x000000FF)
  (uint8)(((tag) shr 16) and 0x000000FF)
  (uint8)(((tag) shr 8) and 0x000000FF)
  (uint8)((tag) and 0x000000FF)

const
  HB_TAG_NONE* = HB_TAG(0, 0, 0, 0)
  HB_TAG_MAX* = HB_TAG(0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF)
  HB_TAG_MAX_SIGNED* = HB_TAG(0x0000007F, 0x000000FF, 0x000000FF, 0x000000FF)


proc hb_tag_from_string*(str: cstring; len: cint): hb_tag_t {.cdecl,
    importc: "hb_tag_from_string", dynlib: dynlibhb_common_post.}

proc hb_tag_to_string*(tag: hb_tag_t; buf: cstring) {.cdecl,
    importc: "hb_tag_to_string", dynlib: dynlibhb_common_post.}

type
  hb_direction_t* {.size: sizeof(cint).} = enum
    HB_DIRECTION_INVALID = 0, HB_DIRECTION_LTR = 4, HB_DIRECTION_RTL, HB_DIRECTION_TTB,
    HB_DIRECTION_BTT



proc hb_direction_from_string*(str: cstring; len: cint): hb_direction_t {.cdecl,
    importc: "hb_direction_from_string", dynlib: dynlibhb_common_post.}
proc hb_direction_to_string*(direction: hb_direction_t): cstring {.cdecl,
    importc: "hb_direction_to_string", dynlib: dynlibhb_common_post.}
template HB_DIRECTION_IS_VALID*(dir: untyped): untyped =
  (((cast[cuint]((dir))) and not 3) == 4)


template HB_DIRECTION_IS_HORIZONTAL*(dir: untyped): untyped =
  (((cast[cuint]((dir))) and not 1) == 4)

template HB_DIRECTION_IS_VERTICAL*(dir: untyped): untyped =
  (((cast[cuint]((dir))) and not 1) == 6)

template HB_DIRECTION_IS_FORWARD*(dir: untyped): untyped =
  (((cast[cuint]((dir))) and not 2) == 4)

template HB_DIRECTION_IS_BACKWARD*(dir: untyped): untyped =
  (((cast[cuint]((dir))) and not 2) == 5)

template HB_DIRECTION_REVERSE*(dir: untyped): untyped =
  ((hb_direction_t)((cast[cuint]((dir))) xor 1))


type
  hb_language_impl_t = object of RootObj
  hb_language_t* = ptr hb_language_impl_t

proc hb_language_from_string*(str: cstring; len: cint): hb_language_t {.cdecl,
    importc: "hb_language_from_string", dynlib: dynlibhb_common_post.}
proc hb_language_to_string*(language: hb_language_t): cstring {.cdecl,
    importc: "hb_language_to_string", dynlib: dynlibhb_common_post.}
let
  HB_LANGUAGE_INVALID* = (cast[hb_language_t](0))

proc hb_language_get_default*(): hb_language_t {.cdecl,
    importc: "hb_language_get_default", dynlib: dynlibhb_common_post.}

type
  hb_script_t* = uint32
const
    HB_SCRIPT_WANCHO* = HB_TAG('W', 'c', 'h', 'o')
    HB_SCRIPT_NYIAKENG_PUACHUE_HMONG* = HB_TAG('H', 'm', 'n', 'p')
    HB_SCRIPT_NANDINAGARI* = HB_TAG('N', 'a', 'n', 'd')
    HB_SCRIPT_ELYMAIC* = HB_TAG('E', 'l', 'y', 'm')
    HB_SCRIPT_SOGDIAN* = HB_TAG('S', 'o', 'g', 'd')
    HB_SCRIPT_OLD_SOGDIAN* = HB_TAG('S', 'o', 'g', 'o')
    HB_SCRIPT_MEDEFAIDRIN* = HB_TAG('M', 'e', 'd', 'f')
    HB_SCRIPT_MAKASAR* = HB_TAG('M', 'a', 'k', 'a')
    HB_SCRIPT_HANIFI_ROHINGYA* = HB_TAG('R', 'o', 'h', 'g')
    HB_SCRIPT_GUNJALA_GONDI* = HB_TAG('G', 'o', 'n', 'g')
    HB_SCRIPT_DOGRA* = HB_TAG('D', 'o', 'g', 'r')
    HB_SCRIPT_ZANABAZAR_SQUARE* = HB_TAG('Z', 'a', 'n', 'b')
    HB_SCRIPT_SOYOMBO* = HB_TAG('S', 'o', 'y', 'o')
    HB_SCRIPT_NUSHU* = HB_TAG('N', 's', 'h', 'u')
    HB_SCRIPT_MASARAM_GONDI* = HB_TAG('G', 'o', 'n', 'm')
    HB_SCRIPT_NEWA* = HB_TAG('N', 'e', 'w', 'a')
    HB_SCRIPT_TANGUT* = HB_TAG('T', 'a', 'n', 'g')
    HB_SCRIPT_OSAGE* = HB_TAG('O', 's', 'g', 'e')
    HB_SCRIPT_MARCHEN* = HB_TAG('M', 'a', 'r', 'c')
    HB_SCRIPT_BHAIKSUKI* = HB_TAG('B', 'h', 'k', 's')
    HB_SCRIPT_ADLAM* = HB_TAG('A', 'd', 'l', 'm')
    HB_SCRIPT_SIGNWRITING* = HB_TAG('S', 'g', 'n', 'w')
    HB_SCRIPT_OLD_HUNGARIAN* = HB_TAG('H', 'u', 'n', 'g')
    HB_SCRIPT_MULTANI* = HB_TAG('M', 'u', 'l', 't')
    HB_SCRIPT_HATRAN* = HB_TAG('H', 'a', 't', 'r')
    HB_SCRIPT_ANATOLIAN_HIEROGLYPHS* = HB_TAG('H', 'l', 'u', 'w')
    HB_SCRIPT_AHOM* = HB_TAG('A', 'h', 'o', 'm')
    HB_SCRIPT_WARANG_CITI* = HB_TAG('W', 'a', 'r', 'a')
    HB_SCRIPT_TIRHUTA* = HB_TAG('T', 'i', 'r', 'h')
    HB_SCRIPT_SIDDHAM* = HB_TAG('S', 'i', 'd', 'd')
    HB_SCRIPT_PSALTER_PAHLAVI* = HB_TAG('P', 'h', 'l', 'p')
    HB_SCRIPT_PAU_CIN_HAU* = HB_TAG('P', 'a', 'u', 'c')
    HB_SCRIPT_PALMYRENE* = HB_TAG('P', 'a', 'l', 'm')
    HB_SCRIPT_PAHAWH_HMONG* = HB_TAG('H', 'm', 'n', 'g')
    HB_SCRIPT_OLD_PERMIC* = HB_TAG('P', 'e', 'r', 'm')
    HB_SCRIPT_OLD_NORTH_ARABIAN* = HB_TAG('N', 'a', 'r', 'b')
    HB_SCRIPT_NABATAEAN* = HB_TAG('N', 'b', 'a', 't')
    HB_SCRIPT_MRO* = HB_TAG('M', 'r', 'o', 'o')
    HB_SCRIPT_MODI* = HB_TAG('M', 'o', 'd', 'i')
    HB_SCRIPT_MENDE_KIKAKUI* = HB_TAG('M', 'e', 'n', 'd')
    HB_SCRIPT_MANICHAEAN* = HB_TAG('M', 'a', 'n', 'i')
    HB_SCRIPT_MAHAJANI* = HB_TAG('M', 'a', 'h', 'j')
    HB_SCRIPT_LINEAR_A* = HB_TAG('L', 'i', 'n', 'a')
    HB_SCRIPT_KHUDAWADI* = HB_TAG('S', 'i', 'n', 'd')
    HB_SCRIPT_KHOJKI* = HB_TAG('K', 'h', 'o', 'j')
    HB_SCRIPT_GRANTHA* = HB_TAG('G', 'r', 'a', 'n')
    HB_SCRIPT_ELBASAN* = HB_TAG('E', 'l', 'b', 'a')
    HB_SCRIPT_DUPLOYAN* = HB_TAG('D', 'u', 'p', 'l')
    HB_SCRIPT_CAUCASIAN_ALBANIAN* = HB_TAG('A', 'g', 'h', 'b')
    HB_SCRIPT_BASSA_VAH* = HB_TAG('B', 'a', 's', 's')
    HB_SCRIPT_TAKRI* = HB_TAG('T', 'a', 'k', 'r')
    HB_SCRIPT_SORA_SOMPENG* = HB_TAG('S', 'o', 'r', 'a')
    HB_SCRIPT_SHARADA* = HB_TAG('S', 'h', 'r', 'd')
    HB_SCRIPT_MIAO* = HB_TAG('P', 'l', 'r', 'd')
    HB_SCRIPT_MEROITIC_HIEROGLYPHS* = HB_TAG('M', 'e', 'r', 'o')
    HB_SCRIPT_MEROITIC_CURSIVE* = HB_TAG('M', 'e', 'r', 'c')
    HB_SCRIPT_CHAKMA* = HB_TAG('C', 'a', 'k', 'm')
    HB_SCRIPT_MANDAIC* = HB_TAG('M', 'a', 'n', 'd')
    HB_SCRIPT_BRAHMI* = HB_TAG('B', 'r', 'a', 'h')
    HB_SCRIPT_BATAK* = HB_TAG('B', 'a', 't', 'k')
    HB_SCRIPT_TAI_VIET* = HB_TAG('T', 'a', 'v', 't')
    HB_SCRIPT_TAI_THAM* = HB_TAG('L', 'a', 'n', 'a')
    HB_SCRIPT_SAMARITAN* = HB_TAG('S', 'a', 'm', 'r')
    HB_SCRIPT_OLD_TURKIC* = HB_TAG('O', 'r', 'k', 'h')
    HB_SCRIPT_OLD_SOUTH_ARABIAN* = HB_TAG('S', 'a', 'r', 'b')
    HB_SCRIPT_MEETEI_MAYEK* = HB_TAG('M', 't', 'e', 'i')
    HB_SCRIPT_LISU* = HB_TAG('L', 'i', 's', 'u')
    HB_SCRIPT_KAITHI* = HB_TAG('K', 't', 'h', 'i')
    HB_SCRIPT_JAVANESE* = HB_TAG('J', 'a', 'v', 'a')
    HB_SCRIPT_INSCRIPTIONAL_PARTHIAN* = HB_TAG('P', 'r', 't', 'i')
    HB_SCRIPT_INSCRIPTIONAL_PAHLAVI* = HB_TAG('P', 'h', 'l', 'i')
    HB_SCRIPT_IMPERIAL_ARAMAIC* = HB_TAG('A', 'r', 'm', 'i')
    HB_SCRIPT_EGYPTIAN_HIEROGLYPHS* = HB_TAG('E', 'g', 'y', 'p')
    HB_SCRIPT_BAMUM* = HB_TAG('B', 'a', 'm', 'u')
    HB_SCRIPT_AVESTAN* = HB_TAG('A', 'v', 's', 't')
    HB_SCRIPT_VAI* = HB_TAG('V', 'a', 'i', 'i')
    HB_SCRIPT_SUNDANESE* = HB_TAG('S', 'u', 'n', 'd')
    HB_SCRIPT_SAURASHTRA* = HB_TAG('S', 'a', 'u', 'r')
    HB_SCRIPT_REJANG* = HB_TAG('R', 'j', 'n', 'g')
    HB_SCRIPT_OL_CHIKI* = HB_TAG('O', 'l', 'c', 'k')
    HB_SCRIPT_LYDIAN* = HB_TAG('L', 'y', 'd', 'i')
    HB_SCRIPT_LYCIAN* = HB_TAG('L', 'y', 'c', 'i')
    HB_SCRIPT_LEPCHA* = HB_TAG('L', 'e', 'p', 'c')
    HB_SCRIPT_KAYAH_LI* = HB_TAG('K', 'a', 'l', 'i')
    HB_SCRIPT_CHAM* = HB_TAG('C', 'h', 'a', 'm')
    HB_SCRIPT_CARIAN* = HB_TAG('C', 'a', 'r', 'i')
    HB_SCRIPT_PHOENICIAN* = HB_TAG('P', 'h', 'n', 'x')
    HB_SCRIPT_PHAGS_PA* = HB_TAG('P', 'h', 'a', 'g')
    HB_SCRIPT_NKO* = HB_TAG('N', 'k', 'o', 'o')
    HB_SCRIPT_CUNEIFORM* = HB_TAG('X', 's', 'u', 'x')
    HB_SCRIPT_BALINESE* = HB_TAG('B', 'a', 'l', 'i')
    HB_SCRIPT_TIFINAGH* = HB_TAG('T', 'f', 'n', 'g')
    HB_SCRIPT_SYLOTI_NAGRI* = HB_TAG('S', 'y', 'l', 'o')
    HB_SCRIPT_OLD_PERSIAN* = HB_TAG('X', 'p', 'e', 'o')
    HB_SCRIPT_NEW_TAI_LUE* = HB_TAG('T', 'a', 'l', 'u')
    HB_SCRIPT_KHAROSHTHI* = HB_TAG('K', 'h', 'a', 'r')
    HB_SCRIPT_GLAGOLITIC* = HB_TAG('G', 'l', 'a', 'g')
    HB_SCRIPT_COPTIC* = HB_TAG('C', 'o', 'p', 't')
    HB_SCRIPT_BUGINESE* = HB_TAG('B', 'u', 'g', 'i')
    HB_SCRIPT_UGARITIC* = HB_TAG('U', 'g', 'a', 'r')
    HB_SCRIPT_TAI_LE* = HB_TAG('T', 'a', 'l', 'e')
    HB_SCRIPT_SHAVIAN* = HB_TAG('S', 'h', 'a', 'w')
    HB_SCRIPT_OSMANYA* = HB_TAG('O', 's', 'm', 'a')
    HB_SCRIPT_LINEAR_B* = HB_TAG('L', 'i', 'n', 'b')
    HB_SCRIPT_LIMBU* = HB_TAG('L', 'i', 'm', 'b')
    HB_SCRIPT_CYPRIOT* = HB_TAG('C', 'p', 'r', 't')
    HB_SCRIPT_TAGBANWA* = HB_TAG('T', 'a', 'g', 'b')
    HB_SCRIPT_TAGALOG* = HB_TAG('T', 'g', 'l', 'g')
    HB_SCRIPT_HANUNOO* = HB_TAG('H', 'a', 'n', 'o')
    HB_SCRIPT_BUHID* = HB_TAG('B', 'u', 'h', 'd')
    HB_SCRIPT_OLD_ITALIC* = HB_TAG('I', 't', 'a', 'l')
    HB_SCRIPT_GOTHIC* = HB_TAG('G', 'o', 't', 'h')
    HB_SCRIPT_DESERET* = HB_TAG('D', 's', 'r', 't')
    HB_SCRIPT_YI* = HB_TAG('Y', 'i', 'i', 'i')
    HB_SCRIPT_THAANA* = HB_TAG('T', 'h', 'a', 'a')
    HB_SCRIPT_SYRIAC* = HB_TAG('S', 'y', 'r', 'c')
    HB_SCRIPT_SINHALA* = HB_TAG('S', 'i', 'n', 'h')
    HB_SCRIPT_RUNIC* = HB_TAG('R', 'u', 'n', 'r')
    HB_SCRIPT_OGHAM* = HB_TAG('O', 'g', 'a', 'm')
    HB_SCRIPT_MYANMAR* = HB_TAG('M', 'y', 'm', 'r')
    HB_SCRIPT_MONGOLIAN* = HB_TAG('M', 'o', 'n', 'g')
    HB_SCRIPT_KHMER* = HB_TAG('K', 'h', 'm', 'r')
    HB_SCRIPT_ETHIOPIC* = HB_TAG('E', 't', 'h', 'i')
    HB_SCRIPT_CHEROKEE* = HB_TAG('C', 'h', 'e', 'r')
    HB_SCRIPT_CANADIAN_SYLLABICS* = HB_TAG('C', 'a', 'n', 's')
    HB_SCRIPT_BRAILLE* = HB_TAG('B', 'r', 'a', 'i')
    HB_SCRIPT_BOPOMOFO* = HB_TAG('B', 'o', 'p', 'o')
    HB_SCRIPT_TIBETAN* = HB_TAG('T', 'i', 'b', 't')
    HB_SCRIPT_THAI* = HB_TAG('T', 'h', 'a', 'i')
    HB_SCRIPT_TELUGU* = HB_TAG('T', 'e', 'l', 'u')
    HB_SCRIPT_TAMIL* = HB_TAG('T', 'a', 'm', 'l')
    HB_SCRIPT_ORIYA* = HB_TAG('O', 'r', 'y', 'a')
    HB_SCRIPT_MALAYALAM* = HB_TAG('M', 'l', 'y', 'm')
    HB_SCRIPT_LATIN* = HB_TAG('L', 'a', 't', 'n')
    HB_SCRIPT_LAO* = HB_TAG('L', 'a', 'o', 'o')
    HB_SCRIPT_KATAKANA* = HB_TAG('K', 'a', 'n', 'a')
    HB_SCRIPT_KANNADA* = HB_TAG('K', 'n', 'd', 'a')
    HB_SCRIPT_HIRAGANA* = HB_TAG('H', 'i', 'r', 'a')
    HB_SCRIPT_HEBREW* = HB_TAG('H', 'e', 'b', 'r')
    HB_SCRIPT_HAN* = HB_TAG('H', 'a', 'n', 'i')
    HB_SCRIPT_HANGUL* = HB_TAG('H', 'a', 'n', 'g')
    HB_SCRIPT_UNKNOWN* = HB_TAG('Z', 'z', 'z', 'z')
    HB_SCRIPT_COMMON* = HB_TAG('Z', 'y', 'y', 'y')
    HB_SCRIPT_INHERITED* = HB_TAG('Z', 'i', 'n', 'h')
    HB_SCRIPT_GURMUKHI* = HB_TAG('G', 'u', 'r', 'u')
    HB_SCRIPT_GUJARATI* = HB_TAG('G', 'u', 'j', 'r')
    HB_SCRIPT_GREEK* = HB_TAG('G', 'r', 'e', 'k')
    HB_SCRIPT_GEORGIAN* = HB_TAG('G', 'e', 'o', 'r')
    HB_SCRIPT_DEVANAGARI* = HB_TAG('D', 'e', 'v', 'a')
    HB_SCRIPT_CYRILLIC* = HB_TAG('C', 'y', 'r', 'l')
    HB_SCRIPT_BENGALI* = HB_TAG('B', 'e', 'n', 'g')
    HB_SCRIPT_ARMENIAN* = HB_TAG('A', 'r', 'm', 'n')
    HB_SCRIPT_ARABIC* = HB_TAG('A', 'r', 'a', 'b')
    HB_SCRIPT_INVALID* = HB_TAG_NONE
    HB_SCRIPT_MAX_VALUE_SIGNED* = HB_TAG_MAX_SIGNED
    HB_SCRIPT_MAX_VALUE* = HB_TAG_MAX_SIGNED
    



proc hb_script_from_iso15924_tag*(tag: hb_tag_t): hb_script_t {.cdecl,
    importc: "hb_script_from_iso15924_tag", dynlib: dynlibhb_common_post.}
proc hb_script_from_string*(str: cstring; len: cint): hb_script_t {.cdecl,
    importc: "hb_script_from_string", dynlib: dynlibhb_common_post.}
proc hb_script_to_iso15924_tag*(script: hb_script_t): hb_tag_t {.cdecl,
    importc: "hb_script_to_iso15924_tag", dynlib: dynlibhb_common_post.}
proc hb_script_get_horizontal_direction*(script: hb_script_t): hb_direction_t {.
    cdecl, importc: "hb_script_get_horizontal_direction",
    dynlib: dynlibhb_common_post.}

type
  hb_user_data_key_t* {.bycopy.} = object
    unused*: char

  hb_destroy_func_t* = proc (user_data: pointer) 


const
  HB_FEATURE_GLOBAL_START* = 0


const
  HB_FEATURE_GLOBAL_END* = (cast[cuint](-1))


type
  hb_feature_t* {.bycopy.} = object
    tag*: hb_tag_t
    value*: uint32
    start*: cuint
    `end`*: cuint


proc hb_feature_from_string*(str: cstring; len: cint; feature: ptr hb_feature_t): bool {.
    cdecl, importc: "hb_feature_from_string", dynlib: dynlibhb_common_post.}
proc hb_feature_to_string*(feature: ptr hb_feature_t; buf: cstring; size: cuint) {.
    cdecl, importc: "hb_feature_to_string", dynlib: dynlibhb_common_post.}

type
  hb_variation_t* {.bycopy.} = object
    tag*: hb_tag_t
    value*: cfloat


proc hb_variation_from_string*(str: cstring; len: cint; variation: ptr hb_variation_t): bool {.
    cdecl, importc: "hb_variation_from_string", dynlib: dynlibhb_common_post.}
proc hb_variation_to_string*(variation: ptr hb_variation_t; buf: cstring; size: cuint) {.
    cdecl, importc: "hb_variation_to_string", dynlib: dynlibhb_common_post.}

type
  hb_color_t* = uint32

template HB_COLOR*(b, g, r, a: untyped): untyped =
  (cast[hb_color_t](HB_TAG((b), (g), (r), (a))))

proc hb_color_get_alpha*(color: hb_color_t): uint8 {.cdecl,
    importc: "hb_color_get_alpha", dynlib: dynlibhb_common_post.}
template hb_color_get_alpha*(color: untyped): untyped =
  ((color) and 0x000000FF)

proc hb_color_get_red*(color: hb_color_t): uint8 {.cdecl,
    importc: "hb_color_get_red", dynlib: dynlibhb_common_post.}
template hb_color_get_red*(color: untyped): untyped =
  (((color) shr 8) and 0x000000FF)

proc hb_color_get_green*(color: hb_color_t): uint8 {.cdecl,
    importc: "hb_color_get_green", dynlib: dynlibhb_common_post.}
template hb_color_get_green*(color: untyped): untyped =
  (((color) shr 16) and 0x000000FF)

proc hb_color_get_blue*(color: hb_color_t): uint8 {.cdecl,
    importc: "hb_color_get_blue", dynlib: dynlibhb_common_post.}
template hb_color_get_blue*(color: untyped): untyped =
  (((color) shr 24) and 0x000000FF)
