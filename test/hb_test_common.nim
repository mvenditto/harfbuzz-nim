import ../font
import ../blob
import ../face

proc init*(): (Blob, Face, Font) =
  
  let blob = newBlobFromFile(
    "resources/content-font.ttf"
  )
  blob.makeImmutable()

  let face = newFace(blob, 0)

  let font = newFont(face)

  (blob, face, font)
