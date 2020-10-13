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

from strutils import join
from sequtils import toSeq
import primality, primality/random

proc echoPrimality(n: int) =
  if n.isPrime:
    echo n, " is a prime number"

  elif n.isComposite:
    echo n, " is a composite number"
    echo n, " = ", primeFactorization(n).join(" * ")

randomize()

let
  x1 = genRandomPrime(10_000..60_000)
  x2 = genRandomPrime(10_000..60_000)

echoPrimality x1
echoPrimality x2
echoPrimality x1 * x2

echo "There are ", toSeq(primes(min(x1, x2)..max(x1, x2))).len, " primes between ", min(x1, x2), " and ", max(x1, x2)
