# Copyright 2020 Double-oxygeN
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from bitops import countTrailingZeroBits
import modular

type
  Primality* {.pure.} = enum
    composite
    prime
    neitherPrimeNorComposite # just 1
    probablyPrime

func isOdd*(x: SomeInteger): bool {.inline.} = (x and 1) == 1
template isEven*(x: SomeInteger): bool = not isOdd(x)

iterator sprpBases[T: SomeInteger](n: T): T =
  let bases =
    when sizeof(T) <= 1: @[2]
    elif sizeof(T) <= 2:
      if n < T(2_047): @[2]
      else: @[2, 3]
    elif sizeof(T) <= 4:
      if n < T(2_047): @[2]
      elif n < T(9_080_191): @[31, 73]
      else: @[2, 7, 61]
    else:
      if n < T(2_047): @[2]
      elif n < T(4_759_123_141): @[2, 7, 61]
      else: @[2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37]

  for base in bases:
    yield T(base)

proc millerRabinPass[T: SomeInteger](n, d, s, base: T): Primality =
  result = Primality.composite
  var x = expMod(base, d, n)

  if x == T(1) or x == n - T(1):
    return Primality.probablyPrime

  for i in 1..<int(s):
    x = multMod(x, x, n)

    if x == n - T(1):
      return Primality.probablyPrime

proc millerRabinTest*[T: SomeInteger](n: T): Primality =
  assert((n >= 3) and n.isOdd,
    "The Miller-Rabin primality test is suitable for only odd numbers greater than or equal 3.")

  let
    s = T(countTrailingZeroBits(pred(n)))
    d = pred(n) shr s

  for base in sprpBases(n):
    result = millerRabinPass(n, d, s, base)

    if result == Primality.composite: break

  if result == Primality.probablyPrime:
    result = Primality.prime

  assert(result != Primality.neitherPrimeNorComposite)
  assert(result != Primality.probablyPrime)
