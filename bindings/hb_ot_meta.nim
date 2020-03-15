when defined(Linux):
  const dynlibhb_ot_meta_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}

import hb_common
import hb_face
import hb_blob

type
  hb_ot_meta_tag_t* {.size: sizeof(cint).} = enum
    HB_OT_META_TAG_DESIGN_LANGUAGES = HB_TAG('d', 'l', 'n', 'g'),
    HB_OT_META_TAG_SUPPORTED_LANGUAGES = HB_TAG('s', 'l', 'n', 'g'),
    HB_OT_META_TAG_MAX_VALUE = HB_TAG_MAX_SIGNED


proc hb_ot_meta_get_entry_tags*(face: ptr hb_face_t; start_offset: cuint;
                               entries_count: ptr cuint;
                               entries: ptr hb_ot_meta_tag_t): cuint {.cdecl,
    importc: "hb_ot_meta_get_entry_tags", dynlib: dynlibhb_ot_meta_post.}
proc hb_ot_meta_reference_entry*(face: ptr hb_face_t; meta_tag: hb_ot_meta_tag_t): ptr hb_blob_t {.
    cdecl, importc: "hb_ot_meta_reference_entry", dynlib: dynlibhb_ot_meta_post.}