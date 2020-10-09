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

from math import gcd
import modular

func f[T: SomeInteger](x, modulus: T): T {.inline.} =
  succ(multMod(x, x, modulus)) mod modulus

proc pollardsRho[T: SomeInteger](n: T): T =
  # Pollard's ρ algorithm
  # Returns a prime factor, or ``n`` itself.

  var
    singleStep = T(2)
    doubleStep = singleStep

  result = T(1)

  while result == T(1):
    singleStep = f(singleStep, n)
    doubleStep = f(f(doubleStep, n), n)
    let diff = if singleStep > doubleStep: singleStep - doubleStep else: doubleStep - singleStep

    result = gcd(diff, n)
    echo "[debug] ", singleStep, ", ", doubleStep, ", ", result
