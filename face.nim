import bindings/hb_face
import common
import blob

type
  Face* = ref object
    native*: ptr hb_face_t

proc newFace*(blob: Blob, index: uint): Face =
  assert not isNil blob.native
  assert index >= 0u
  Face(native: hb_face_create(blob.native, index.cuint))

template index*(face: Face): uint = hb_face_get_index(face.native)
template `index=`*(face: Face, index: uint) = hb_face_set_index(face.native, index.cuint)

template unitsPerEm*(face: Face): uint = hb_face_get_upem(face.native)
template `unitsPerEm=`*(face: Face, upem: uint) = hb_face_set_upem(face.native, upem.cuint)

template glyphCount*(face: Face): uint = hb_face_get_glyph_count(face.native)
template `glyphCount=`*(face: Face, glyphCount: uint) = hb_face_set_glyph_count(face.native, glyphCount.cuint)

proc tables*(face: Face): seq[Tag] =
  var tableCount: cuint = 0
  var count: cuint = hb_face_get_table_tags(face.native, 0, tableCount.addr, nil)
  let buff = newSeqUninitialized[uint32](count)
  discard hb_face_get_table_tags(face.native, 0, count.addr, buff[0].unsafeAddr)
  return cast[seq[Tag]](buff)

proc referenceTable*(face: Face, table: Tag): Blob =
  Blob(native: hb_face_reference_table(face.native, table[]))

proc makeImmutable*(face: Face) = hb_face_make_immutable(face.native)

proc dispose*(face: Face) = hb_face_destroy(face.native)
