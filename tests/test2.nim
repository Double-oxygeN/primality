import unittest

include primality/private/modular

suite "Modular calculation tests":
  test "addMod":
    check(addMod(20, 30, 80) == 50)
    check(addMod(20, 30, 40) == 10)
    check(addMod(120'i8, 120'i8, 127'i8) == 113'i8)
    check(addMod(240'u8, 240'u8, 255'u8) == 225'u8)
    check(addMod(96'i8, 48'i8, 97'i8) == 47'i8)

  test "doubleMod":
    check(doubleMod(20, 50) == 40)
    check(doubleMod(20, 32) == 8)
    check(doubleMod(120'i8, 127'i8) == 113'i8)
    check(doubleMod(240'u8, 255'u8) == 225'u8)

  test "multMod":
    check(multMod(12, 34, 500) == 408)
    check(multMod(12, 34, 56) == 16)
    check(multMod(118'i8, 117'i8, 120'i8) == 6'i8)
    check(multMod(238'u8, 247'u8, 250'u8) == 36'u8)

  test "expMod":
    check(expMod(2, 20, 2_000_000) == 1_048_576)
    check(expMod(2, 20, 555) == 181)
    check(expMod(3, 5, 753) == 243)
    check(expMod(2, 3, 7) == 1)
    check(expMod(54'i8, 32'i8, 43'i8) == 21'i8)
