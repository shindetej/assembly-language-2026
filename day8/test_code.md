# Test Cases

## 39_1D_array_static.s

Array is fixed-size: `arr[MAX]` where `MAX = 10`. `iMax` is read but **never checked**
against `MAX` before the fill loop, so it's a good place to see that missing-bounds-check
in action.

| # | n (input) | elements | Purpose | Expected result |
|---|-----------|----------|---------|------------------|
| 1 | `5` | `1 2 3 4 5` | Normal case, well within `MAX` | Prints all 5 values back correctly |
| 2 | `10` | `1 2 3 4 5 6 7 8 9 10` | Boundary case, `n == MAX` | Still works — last index used is `arr[9]`, exactly fits |
| 3 | `15` | `1 2 3 4 5 6 7 8 9 10 11 12 13 14 15` | `n > MAX`, no bounds check exists | Elements 11–15 write past `arr[9]` into `iCounter`/`iMax`'s stack slots — expect corrupted loop behavior, garbage output, or a crash. This demonstrates why the missing `if (iMax > MAX)` check matters |

## 40_1D_array_dynamic.s

Array is `malloc`'d as `iMax * sizeof(int)` bytes, so there's no fixed `MAX` — but size
comes from `mull`, and `malloc` can legitimately fail.

| # | n (input) | elements | Purpose | Expected result |
|---|-----------|----------|---------|------------------|
| 1 | `5` | `1 2 3 4 5` | Normal case | `malloc` succeeds, prints all 5 values back, `free`d cleanly |
| 2 | `0` | *(none)* | Edge case, empty array | `malloc(0)` — implementation-defined (may return `NULL` or a valid non-dereferenceable pointer); with `NULL` this exercises `label_malloc_null` → `exit(-1)`; with non-NULL, both loops skip entirely (fall through on `jl` since `0 < 0` is false) and exits normally |
| 3 | `500000000` | *(any, loop will likely never be reached)* | Stress case, huge `n` | `iMax * 4` ≈ 2GB request — likely triggers a genuine `malloc` failure, exercising the `label_malloc_null` path (`puts` "Memory allocation FAILED" then `exit(-1)`) without needing to fake anything |
