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

import std/random
import check

export randomize

proc genRandomPrime*[T: SomeInteger](x: Slice[T]): T =
  while not result.isPrime:
    result = rand(x)


proc genRandomPrime*[T: SomeInteger](ty: typedesc[T]): T =
  while not result.isPrime:
    result = rand(ty)


proc genRandomPrime*[T: SomeInteger](max: T): T =
  genRandomPrime(T(2)..max)
