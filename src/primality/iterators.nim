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
import private/wheel

iterator primes*[T: SomeInteger](x: Slice[T]): T =
  ## Iterates over each primes between ``x``.

  for p in primeCandidates(x):
    if p.isPrime: yield p


iterator primes*[T: SomeInteger](max: T): T =
  ## Iterates over each primes up to ``max``.

  for p in primeCandidates(T(2)..max):
    if p.isPrime: yield p


iterator composites*[T: SomeInteger](x: Slice[T]): T =
  ## Iterates over each composite numbers between ``x``.

  for c in x:
    if c.isComposite: yield c


iterator composites*[T: SomeInteger](max: T): T =
  ## Iterates over each composite numbers up to ``max``.

  for c in T(4)..max:
    if c.isComposite: yield c
