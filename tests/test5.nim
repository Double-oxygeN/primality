import unittest

include primality/private/eratosthenes

suite "Eratosthenes's sieve":
  test "square root in integer":
    check(sqrtInt(1) == 1)
    check(sqrtInt(4) == 2)
    check(sqrtInt(9) == 3)

    check(sqrtInt(500) == 22)

    check(sqrtInt(127'i8) == 11'i8)
    check(sqrtInt(255'u8) == 15'u8)
    check(sqrtInt(0x7fff_ffff_ffff_ffff'i64) == 3_037_000_499'i64)
    check(sqrtInt(0xffff_ffff_ffff_ffff'u64) == 0xffff_ffff'u64)

  test "sieve":
    check(eratosthenesSieve(2) == 2)
    check(eratosthenesSieve(3) == 3)
    check(eratosthenesSieve(125) == 5)
    check(eratosthenesSieve(169) == 13)
    check(eratosthenesSieve(501_679) == 199)
