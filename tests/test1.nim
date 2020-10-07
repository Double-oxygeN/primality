import unittest

include primality/millerrabin

suite "Miller-Rabin primality test":
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
