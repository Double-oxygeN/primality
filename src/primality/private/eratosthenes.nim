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

import sequtils
import wheel

func upperBound[T: SomeInteger](ty: typedesc[T]): T {.compileTime.} =
  when ty is SomeUnsignedInt:
    result = ty(1) shl (sizeof(ty) shl 2)
  elif sizeof(ty) == 1:
    result = ty(0xC)
  elif sizeof(ty) == 2:
    result = ty(0xB6)
  elif sizeof(ty) == 4:
    result = ty(0xB505)
  elif sizeof(ty) == 8:
    result = ty(0xB504_F334)

func sqrtInt[T: SomeInteger](x: T): T =
  assert(x >= T(1))
  const ub = upperBound(T)
  result = ub shr 1

  var
    lower = T(1)
    upper = ub

  while true:
    if x < result * result:
      upper = result
      result = (lower + upper) shr 1

    elif succ(result) * succ(result) <= x:
      lower = result
      result = (lower + upper) shr 1

    else:
      break

    if succ(result) == ub: break

  assert(result * result <= x and (succ(result) == ub or x < succ(result) * succ(result)))

proc eratosthenesSieve*[T: SomeInteger](n: T): T =
  ## Eratosthenes's sieve with wheel factorization

  let upperBound = sqrtInt(n)
  var sieve = toSeq(primeCandidates(T(2)..upperBound))

  while sieve.len > 0:
    if n mod sieve[0] == 0: break

    sieve = sieve.filterIt(it mod sieve[0] > 0)

  result = if sieve.len > 0: sieve[0] else: n
