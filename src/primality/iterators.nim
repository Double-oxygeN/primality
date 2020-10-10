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

import check

iterator primes*[T: SomeInteger](x: Slice[T]): T =
  ## Iterates over each primes between ``x``.

  if T(2) in x:
    yield T(2)

    for p in countup(T(3), x.b, T(2)):
      if isPrime(p): yield p

  else:
    for p in countup((x.a div T(2)) * T(2) + 1, x.b, T(2)):
      if isPrime(p): yield p


iterator primes*[T: SomeInteger](max: T): T =
  ## Iterates over each primes up to ``max``.

  if T(2) <= max: yield T(2)

  for p in countup(T(3), max, T(2)):
    if isPrime(p): yield p
