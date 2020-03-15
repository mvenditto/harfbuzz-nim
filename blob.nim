import bindings/[
  hb_face,
  hb_blob
]

import streams

type
  Blob* = ref object
    native*: ptr hb_blob_t

  MemoryMode* = enum
    Duplicate = HB_MEMORY_MODE_DUPLICATE
    ReadOnly = HB_MEMORY_MODE_READONLY
    Writable = HB_MEMORY_MODE_WRITABLE
    ReadOnlyMayMakeWriteable = HB_MEMORY_MODE_READONLY_MAY_MAKE_WRITABLE

template dispose*(blob: Blob) = hb_blob_destroy(blob.native)

template length*(blob: Blob): uint = hb_blob_get_length(blob.native)

template len*(blob: Blob): int = length(blob).int

template faceCount*(blob: Blob): uint = hb_face_count(blob.native)

template isImmutable*(blob: Blob): bool = hb_blob_is_immutable(blob.native)

template makeImmutable*(blob: Blob) = hb_blob_make_immutable(blob.native)
    
proc asString*(blob: Blob): string =
  var length: cuint = 0
  $hb_blob_get_data(blob.native, length.addr)

template asStream*(blob: Blob): StringStream =
  newStringStream(asString(blob))

proc newBlobFromFile*(fileName: string): Blob = 
  # TODO: check file existence
  Blob(native: hb_blob_create_from_file(fileName))

proc newBlob*(data: string, length: uint, mode: MemoryMode, destroyProc: proc (user_data: pointer)): Blob = 
  Blob(native: hb_blob_create(
    data, 
    length.cuint,
    mode.hb_memory_mode_t,
    nil,
    destroyProc
  ))

proc newBlob*(data: string, mode: MemoryMode): Blob =
  newBlob(data, data.len.uint, mode, nil)

