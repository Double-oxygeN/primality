import unittest

include primality/modular

suite "Modular calculation tests":
  test "addMod":
    check(addMod(20, 30, 80) == 50)
    check(addMod(20, 30, 40) == 10)
    check(addMod(120'i8, 120'i8, 127'i8) == 113'i8)
    check(addMod(240'u8, 240'u8, 255'u8) == 225'u8)
