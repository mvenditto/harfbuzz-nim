when defined(Linux):
  const dynlibhb_version_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}
const
  HB_VERSION_MAJOR* = 2
  HB_VERSION_MINOR* = 6
  HB_VERSION_MICRO* = 4
  HB_VERSION_STRING* = "2.6.4"

template HB_VERSION_ATLEAST*(major, minor, micro: untyped): untyped =
  ((major) * 10000 + (minor) * 100 + (micro) <=
      HB_VERSION_MAJOR * 10000 + HB_VERSION_MINOR * 100 + HB_VERSION_MICRO)

proc hb_version*(major: ptr cuint; minor: ptr cuint; micro: ptr cuint) {.cdecl,
    importc: "hb_version", dynlib: dynlibhb_version_post.}
proc hb_version_string*(): cstring {.cdecl, importc: "hb_version_string",
                                  dynlib: dynlibhb_version_post.}
proc hb_version_atleast*(major: cuint; minor: cuint; micro: cuint): bool {.cdecl,
    importc: "hb_version_atleast", dynlib: dynlibhb_version_post.}