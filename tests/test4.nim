import unittest

include primality/private/rho

suite "Pollard's rho":
  test "pollardsRho":
    check(pollardsRho(9) == 3)
    check(pollardsRho(91) == 7)
    check(pollardsRho(5963) == 67)
    check(pollardsRho(8051) == 97)
    check(pollardsRho(1_062_247_379'i32) == 1_019'i32)
    check(pollardsRho(1_152_921_515_344_265_237'u64) == 1_073_741_827'u64)

    check(pollardsRho(625) == 125)
