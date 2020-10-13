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
from sequtils import repeat, all
import private/[rho, eratosthenes]
import check

proc primeFactorization*[T: SomeInteger](n: T): seq[T] =
  assert(n >= 2)

  let
    exponentBase2 = countTrailingZeroBits(n)
    oddFactor = n shr exponentBase2

  result = repeat(T(2), exponentBase2)

  if oddFactor == 1:
    return

  if isPrime(oddFactor):
    result.add oddFactor
    return

  var
    numRho = oddFactor
    factorsRho = @[pollardsRho(numRho)]

  while factorsRho[^1] < numRho:
    numRho = numRho div factorsRho[^1]
    factorsRho.add pollardsRho(numRho)

  echo factorsRho

  if factorsRho.all(isPrime):
    result.add factorsRho
    return

  var factorsSieve = newSeq[T]()

  for factor in factorsRho:
    var numSieve = factor
    factorsSieve.add eratosthenesSieve(numSieve)

    while factorsSieve[^1] < numSieve:
      numSieve = numSieve div factorsSieve[^1]
      factorsSieve.add eratosthenesSieve(numSieve)

  result.add factorsSieve

  assert(result.all(isPrime))


when isMainModule:
  from strutils import join, parseBiggestUInt
  from os import paramStr, paramCount

  if paramCount() >= 1:
    try:
      let num = paramStr(1).parseBiggestUInt()
      echo num, " = ", num.primeFactorization().join(" * ")

    except ValueError:
      echo "not a number"

  else:
    echo "an argument needed"
