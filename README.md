# LegibleMath 📚

_Safer than SafeMath. Goes up to 11!_

LegibleMath is a Solidity library providing readable arithmetic with compile-time constants for the letters you need to spell numbers.

## Features

- **Fun numbers:** As easy as `o*n*e`, `t*w*o`, `t*h*r*e*e`.
- **Robust math:** Just type your expression like `t*w*o + s*e*v*e*n`.
- **Easy conversion:** Use `.literally()` to convert words into an integer.
- **Negative numbers**: Type `n*e*g*a*t*i*v*e * f*i*v*e` to get -5.
- **Limitless expression**: You can do any sort of math in the [-11, 11] range.
- **Operator overloading:** Use `+`, `-`, `*`, and `/` for natural expressions.
- **Safety**: All operations revert safely; fractions are always reduced and never overflow.

## Getting Started

### 1. Installation

Copy `lib/LegibleMath.sol` to your project.

### 2. Recommended Import

To easily use all the letter constants and error types, **import everything:**

```solidity
import {
  LM, w, h, i, z, t, r, o, n, f, l, u, x, g, a, s, e, v,

  NotInteger, OutOfRange, Overflow
} from "../lib/LegibleMath.sol";
```

### 3. Example: Spelling a Number

```solidity
function answer() external pure returns (int256) {
    LM result = t*w*o + t*h*r*e*e;
    return result.literally(); // returns 5
}
```

### 4. Literal Safety

- To **retrieve the integer** result, use `.literally()`.  
- If the fraction isn’t an integer: `revert NotInteger(num, den);`
- If the value is not in `-11..11`: `revert OutOfRange(value);`
- If an overflow or invalid denominator: `revert Overflow();`

### 5. All Supported Letters

The constants available are:
- `a, e, f, g, h, i, l, n, o, r, s, t, u, v, w, x, z`

Read the [whitepaper](docs/whitepaper.pdf) to learn how their values were derived.
