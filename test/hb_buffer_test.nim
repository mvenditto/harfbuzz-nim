import unittest

import ../buffer
import ../font

import hb_test_common

const
  simpleText = "1234"

let(blob, face, ffont) = init()

suite "harfbuzz buffer test":

  test "should have correct content type":
    var buff = newBuffer()
    buff.direction = Direction.Ltr
    check(buff.contentType == ContentType.Invalid)
    buff.addUtf8(simpleText)
    check(buff.contentType == ContentType.Unicode)
    ffont.shape(buff)
    check(buff.contentType == ContentType.Glyphs)
    buff.dispose()

  test "should have default state after reset":
    var buff = newBuffer()
    buff.addUtf8(simpleText)
    buff.reset()
    check(buff.contentType == ContentType.Invalid)
    check(buff.length == 0)
    buff.dispose()

  test "should clear contents":
    var buff = newBuffer()
    buff.addUtf8(simpleText)
    check(buff.length == simpleText.len)
    buff.clearContents()
    check(buff.getGlyphInfos().len == 0)
    buff.dispose()

  test "should add":
    var buff = newBuffer()
    buff.add(55, 1337)
    check(1 == buff.length)
    check(55u == buff.getGlyphInfos()[0].codepoint)
    check(1337u == buff.getGlyphInfos()[0].cluster)
    buff.dispose()

  test "should add utf by string":
    var buff = newBuffer()
    buff.addUtf8("A")
    check(buff.length == 1)
    buff.addUtf16("B")
    check(buff.length == 2)
    buff.addUtf32("V")
    check(buff.length == 3)
    buff.dispose()

  test "should throw exception when addutf on shaped buffer":
    var buff = newBuffer()
    buff.direction = Direction.Ltr
    buff.addUtf8(simpleText)
    ffont.shape(buff)
    expect AssertionError:
      buff.addUtf8("A")
  
