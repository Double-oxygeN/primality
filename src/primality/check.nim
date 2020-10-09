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

import private/millerrabin


proc isPrime*(n: SomeInteger): bool =
  ## Check if the argument is prime.
  ## 
  runnableExamples:
    assert(isPrime(47))
    assert(not isPrime(57))
    assert(not isPrime(1))

  result = checkPrimality(n) == Primality.prime


proc isComposite*(n: SomeInteger): bool =
  ## Check if the argument is composite number.
  ## 
  runnableExamples:
    assert(isComposite(57))
    assert(not isComposite(67))
    assert(not isComposite(1))

  result = checkPrimality(n) == Primality.composite
