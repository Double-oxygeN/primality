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

func addMod*[T: SomeInteger](x, y, modulus: T): T =
  assert(x >= 0 and y >= 0 and modulus > 1)

  let overflowLimit = high(T) - x

  result =
    if overflowLimit < y:
      (y - overflowLimit + (high(T) mod modulus)) mod modulus

    else:
      (x + y) mod modulus

func doubleMod*[T: SomeInteger](x, modulus: T): T =
  assert(x >= 0 and modulus > 1)

  let overflowMask = succ(high(T) shr 1)

  result =
    if (x and overflowMask) == 0:
      (x shl 1) mod modulus

    else:
      (((x xor overflowMask) shl 1) + succ(high(T) mod modulus)) mod modulus

func multMod*[T: SomeInteger](x, y, modulus: T): T =
  assert(x >= 0 and y >= 0 and modulus > 1)

  result = T(0)
  var
    s = y mod modulus
    r = x mod modulus

  while s != T(0):
    if (s and T(1)) != 0:
      result = result.addMod(r, modulus)

    s = s shr 1
    r = doubleMod(r, modulus)

func expMod*[T: SomeInteger](x, y, modulus: T): T =
  assert(x >= 0 and y >= 0 and modulus > 1)

  result = T(1)
  var
    s = y
    r = x mod modulus

  while s != T(0):
    if (s and T(1)) != 0:
      result = result.multMod(r, modulus)

    s = s shr 1
    r = r.multMod(r, modulus)
