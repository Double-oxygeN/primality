import unittest

include primality/private/millerrabin

suite "Miller-Rabin primality tests":
  test "isOdd":
    for x in 0..4:
      check(isOdd(int8(x) * 2 + 1))
      check(isOdd(uint8(x) * 2 + 1))
      check(isOdd(int64(x) * 2 + 1))
      check(isOdd(int64(x) * 2 + 1))

    check(isOdd(-1))

    check(isOdd(high(int64)))

  test "isEven":
    for x in 0..5:
      check(isEven(int8(x) * 2))
      check(isEven(uint8(x) * 2))
      check(isEven(int64(x) * 2))
      check(isEven(uint64(x) * 2))

    check(isEven(-2))

    check(isEven(low(int64)))

  test "getOddFactor":
    let (d1, s1) = getOddFactor(2)
    check(d1 == 1)
    check(s1 == 1)

    let (d2, s2) = getOddFactor(2820)
    check(d2 == 705)
    check(s2 == 2)

    let (d3, s3) = getOddFactor(0x9000_0000_0000_0000'u64)
    check(d3 == 9'u64)
    check(s3 == 60'u64)

    expect AssertionError: discard getOddFactor(3)
    expect AssertionError: discard getOddFactor(1)
    expect AssertionError: discard getOddFactor(0)
    expect AssertionError: discard getOddFactor(-2820)

  test "primes":
    check(checkPrimality(2) == Primality.prime)
    check(checkPrimality(3) == Primality.prime)
    check(checkPrimality(5) == Primality.prime)
    check(checkPrimality(7) == Primality.prime)
    check(checkPrimality(11) == Primality.prime)
    check(checkPrimality(13) == Primality.prime)

    check(checkPrimality(109'i8) == Primality.prime)
    check(checkPrimality(19_231'i16) == Primality.prime)
    check(checkPrimality(31_139'i16) == Primality.prime)
    check(checkPrimality(1_255_604_549'i32) == Primality.prime)
    check(checkPrimality(1_757_722_691'i32) == Primality.prime)
    check(checkPrimality(2_147_275_399'i32) == Primality.prime)
    check(checkPrimality(6_775_151_198_842_152_593'i64) == Primality.prime)
    check(checkPrimality(8_608_492_677_523_157_389'i64) == Primality.prime)
    check(checkPrimality(9_223_372_036_854_771_703'i64) == Primality.prime)

    check(checkPrimality(223'u8) == Primality.prime)
    check(checkPrimality(44_257'u16) == Primality.prime)
    check(checkPrimality(62_057'u16) == Primality.prime)
    check(checkPrimality(2_625_581_771'u32) == Primality.prime)
    check(checkPrimality(3_742_077_707'u32) == Primality.prime)
    check(checkPrimality(4_138_009_703'u32) == Primality.prime)
    check(checkPrimality(13_054_575_889_583_851_933'u64) == Primality.prime)
    check(checkPrimality(16_337_922_703_268_404_439'u64) == Primality.prime)
    check(checkPrimality(18_296_337_350_099_515_129'u64) == Primality.prime)

  test "composites":
    check(checkPrimality(4) == Primality.composite)
    check(checkPrimality(9) == Primality.composite)
    check(checkPrimality(15) == Primality.composite)
    check(checkPrimality(21) == Primality.composite)
    check(checkPrimality(39) == Primality.composite)
    check(checkPrimality(221) == Primality.composite)

    check(checkPrimality(121'i8) == Primality.composite)
    check(checkPrimality(14_803'i16) == Primality.composite)
    check(checkPrimality(32_399'i16) == Primality.composite)
    check(checkPrimality(2_108_599_049'i32) == Primality.composite)
    check(checkPrimality(2_125_525_169'i32) == Primality.composite)
    check(checkPrimality(2_146_375_841'i32) == Primality.composite)
    check(checkPrimality(8_687_511_201_745_258_601'i64) == Primality.composite)
    check(checkPrimality(9_223_279_670_410_152_733'i64) == Primality.composite)
    check(checkPrimality(9_223_371_994_482_243_049'i64) == Primality.composite)

    check(checkPrimality(253'u8) == Primality.composite)
    check(checkPrimality(56_129'u16) == Primality.composite)
    check(checkPrimality(64_507'u16) == Primality.composite)
    check(checkPrimality(3_869_710_423'u32) == Primality.composite)
    check(checkPrimality(4_269_897_173'u32) == Primality.composite)
    check(checkPrimality(4_294_049_777'u32) == Primality.composite)
    check(checkPrimality(17_896_754_726_664_901_627'u64) == Primality.composite)
    check(checkPrimality(18_446_668_332_231_546_713'u64) == Primality.composite)
    check(checkPrimality(18_446_744_030_759_878_681'u64) == Primality.composite)

    check(checkPrimality(2_047'i16) == Primality.composite)
    check(checkPrimality(2_047'i32) == Primality.composite)
