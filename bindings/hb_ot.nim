when defined(Linux):
  const dynlibhb_ot_post = "harfbuzz.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "harfbuzz/src\"".}
