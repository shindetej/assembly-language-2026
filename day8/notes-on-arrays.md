# Assembly Language Notes — Arrays

**Topic:** Array
**Date:** 19-08-2026

---

## Array Representation

In C, arrays can be created:

* Statically
* Dynamically using `malloc()`

### Array Address Calculation

```text
Effective Address = Offset + Base Address + (Index × Size)
```

Example:

```asm
-12(%ebp,%eax,4)
```

```text
Address = -12 + %ebp + (%eax × 4)
```

**Note:** Base address and index must be registers.

---

## Array Addressing Scenarios

| Scenario | Offset Address | Base Address | Meaning                        | Assembly Example   | Address Calculation       |
| -------- | -------------- | ------------ | ------------------------------ | ------------------ | ------------------------- |
| I        | No             | No           | Not applicable                 | —                  | —                         |
| II       | Yes            | No           | Global array                   | `arr(,%eax,4)`     | `arr + (%eax × 4)`        |
| III      | No             | Yes          | Dynamic array using `malloc()` | `(%ebx,%eax,4)`    | `%ebx + (%eax × 4)`       |
| IV       | Yes            | Yes          | Local array                    | `-12(%ebp,%eax,4)` | `-12 + %ebp + (%eax × 4)` |

---

## Example

```asm
movl %edx, arr(,%eax,4)
```

| Part           | Meaning                   |
| -------------- | ------------------------- |
| `%edx`         | Value to store            |
| `arr`          | Global array base address |
| `%eax`         | Array index               |
| `4`            | Size of each element      |
| `arr(,%eax,4)` | Address of `arr[index]`   |

Conceptually:

```c
arr[index] = value;
```

### GAS Addressing Syntax

```asm
displacement(base, index, scale)
```

| Component      | Meaning                   |
| -------------- | ------------------------- |
| `displacement` | Constant offset           |
| `base`         | Base-address register     |
| `index`        | Index register            |
| `scale`        | Element size / multiplier |

### Important Examples

```asm
arr(,%eax,4)          # Global array
(%ebx,%eax,4)         # Dynamic array
-12(%ebp,%eax,4)      # Local array
```

## Macros / Constants for Array Index and Size

In C, `#define` macros are often used to define array-related constants such as the maximum size or index limit.

- it can be represented as

```c
#define MAX 10
```

The equivalent constant can be defined using:

```asm
.equ MAX, 10
```

`.equ` defines a **symbolic constant**. It can then be used wherever the constant is required, including array-related calculations.

| C                | GAS Assembly                                    | Meaning                       |
| ---------------- | ----------------------------------------------- | ----------------------------- |
| `#define MAX 10` | `.equ MAX, 10`                                  | Define constant `MAX` as `10` |
| `arr[MAX]`       | `MAX` can be used in address/index calculations | Use the defined constant      |

### Example

```asm
.equ MAX, 10
```

```asm
movl $MAX, %eax
```

-  `#define` is a C preprocessor macro, while `.equ` is an assembler directive used to define a symbolic constant. They serve a similar purpose for simple constant values, but they are not technically the same mechanism.
