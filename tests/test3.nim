import unittest

import primality

suite "Primality":
  test "isPrime":
    check(isPrime(2))
    check(isPrime(3))
    check(isPrime(5))
    check(isPrime(7))
    check(isPrime(11))

    check(not isPrime(4))
    check(not isPrime(6))
    check(not isPrime(9))
    check(not isPrime(15))
    check(not isPrime(57))

    check(not isPrime(1))
    check(not isPrime(0))
    check(not isPrime(-2))

  test "isComposite":
    check(isComposite(4))
    check(isComposite(6))
    check(isComposite(9))
    check(isComposite(15))
    check(isComposite(57))

    check(not isComposite(2))
    check(not isComposite(3))
    check(not isComposite(5))
    check(not isComposite(7))
    check(not isComposite(11))

    check(not isComposite(1))
    check(not isComposite(0))
    check(not isComposite(-4))
