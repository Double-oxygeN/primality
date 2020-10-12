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

## Wheel factorization

import sequtils

# const basis = [2, 3, 5]
# const basis = [2, 3, 5, 7]
const basis = [2, 3, 5, 7, 11]

func product(xs: openarray[int]): int {.compileTime.} =
  result = 1
  for x in xs:
    result *= x

proc genWheel(basis: openarray[int]; wheelSize: int): seq[int] {.compileTime.} =
  result = @[1]

  for i in countup(3, wheelSize, +2):
    if basis.allIt(i mod it > 0):
      result.add i

const
  wheelSize = product(basis)
  wheel = genWheel(basis, wheelSize)
  wheelLen = wheel.len

proc createInvWheelTable(wheel: openarray[int]): array[0..wheelSize div 2 - 1, int] {.compileTime.} =
  var idx = 0
  for i, x in mpairs(result):
    let val = succ(i shl 1)

    if val > wheel[idx]:
      inc idx

    x = idx

const invWheelTbl = createInvWheelTable(wheel)

iterator primeCandidates*[T: SomeInteger](x: Slice[T]): T =
  assert(x.a <= x.b)

  if x.a < T(max(basis)):
    for b in basis:
      if T(b) in x: yield T(b)

  if T(wheel[1]) < x.b:
    const noRotateFlag = when sizeof(T) <= 2: int(high(T)) < wheelSize else: false

    template rotation(x: T): int =
      when noRotateFlag: 0 else: int(x div T(wheelSize))
    template offset(x: T): int =
      when noRotateFlag: int(x) else: int(x mod T(wheelSize))
    template num(idx: int): T =
      let rotated =
        when T is uint64: T(idx div wheelLen) * T(wheelSize)
        else: T((idx div wheelLen) * wheelSize)

      if high(T) - rotated < T(wheel[idx mod wheelLen]):
        T(0) # to avoid overflow
      else:
        rotated + T(wheel[idx mod wheelLen])

    let
      startIdx = if x.a <= T(wheel[1]): 1 else: rotation(x.a) * wheelLen + invWheelTbl[offset(x.a) div 2]
      endIdx0 = rotation(x.b) * wheelLen + invWheelTbl[offset(x.b) div 2]
      endIdx = if num(endIdx0) == x.b: endIdx0 else: endIdx0 - 1

    for idx in startIdx..endIdx:
      yield num(idx)
