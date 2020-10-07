# Copyright 2020 double-oxygen
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

from math import `^`

type
  Primality* {.pure.} = enum
    composite
    prime
    neitherPrimeNorComposite # just 1

  OddFactorResult[T: SomeInteger] = tuple
    oddFactor, exponentOnBase2: T

func isOdd(x: SomeInteger): bool {.inline.} = (x and 1) == 1
template isEven(x: SomeInteger): bool = not isOdd(x)

func getOddFactor[T: SomeInteger](n: T): OddFactorResult[T] =
  assert((n >= 2) and n.isEven,
    "Only even numbers greater than or equal 2 are allowed as the argument of getOddFactor.")

  result.oddFactor = n

  template invariantCondition: bool =
    n == result.oddFactor * (T(1) shl result.exponentOnBase2)

  while not result.oddFactor.isOdd:
    result.oddFactor = result.oddFactor shr 1
    inc result.exponentOnBase2

    assert(invariantCondition)

  assert((result.oddFactor > 0) and result.oddFactor.isOdd)
  assert(result.exponentOnBase2 > 0)
  assert(invariantCondition)

proc millerRabinTest(n: SomeInteger): Primality =
  assert((n >= 3) and n.isOdd,
    "The Miller-Rabin primality test is suitable for only odd numbers greater than or equal 3.")

  result = Primality.prime

  # TODO: impl.

  assert(result != Primality.neitherPrimeNorComposite)

proc checkPrimality*(n: SomeInteger): Primality =
  result = if n < 2: Primality.neitherPrimeNorComposite
    elif n == 2: Primality.prime
    elif n.isEven: Primality.composite
    else: millerRabinTest(n)
