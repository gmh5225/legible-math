// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { console } from "forge-std/console.sol";

/// @dev A rational number type and operator overloads for natural letter multiplication
struct Fraction { int256 num; int256 den; }
/// @dev Value type for Fraction to enable operator overloading
type Frac is Fraction;

error ZeroDenominator();
error NonInteger();
error OutOfBounds();

// Global operator overloads
function add(Frac x, Frac y) pure returns (Frac) {
    Fraction memory A = Frac.unwrap(x);
    Fraction memory B = Frac.unwrap(y);
    return Frac.wrap(Fraction(A.num * B.den + B.num * A.den, A.den * B.den));
}
function sub(Frac x, Frac y) pure returns (Frac) {
    Fraction memory A = Frac.unwrap(x);
    Fraction memory B = Frac.unwrap(y);
    return Frac.wrap(Fraction(A.num * B.den - B.num * A.den, A.den * B.den));
}
function mul(Frac x, Frac y) pure returns (Frac) {
    Fraction memory A = Frac.unwrap(x);
    Fraction memory B = Frac.unwrap(y);
    return Frac.wrap(Fraction(A.num * B.num, A.den * B.den));
}
function div(Frac x, Frac y) pure returns (Frac) {
    Fraction memory A = Frac.unwrap(x);
    Fraction memory B = Frac.unwrap(y);
    if (B.num == 0) revert ZeroDenominator();
    return Frac.wrap(Fraction(A.num * B.den, A.den * B.num));
}
function neg(Frac x) pure returns (Frac) {
    Fraction memory A = Frac.unwrap(x);
    return Frac.wrap(Fraction(-A.num, A.den));
}

using { add as +, sub as -, mul as *, div as /, neg as unary- } for Frac global;

/// @title LegibleMath
/// @notice Spell –11…11 by direct letter constants and arithmetic
library LegibleMath {
    // Letter constants as Fractions wrapped in Frac
    Frac public constant z = Frac.wrap(Fraction({ num: 0, den: 1 }));    // zero
    Frac public constant e = Frac.wrap(Fraction({ num: 1, den: 1 }));
    Frac public constant r = Frac.wrap(Fraction({ num: 1, den: 1 }));
    Frac public constant o = Frac.wrap(Fraction({ num: 1, den: 1 }));
    Frac public constant n = Frac.wrap(Fraction({ num: 1, den: 1 }));
    Frac public constant t = Frac.wrap(Fraction({ num: 10, den: 1 }));
    Frac public constant w = Frac.wrap(Fraction({ num: 1, den: 5 }));
    Frac public constant h = Frac.wrap(Fraction({ num: 3, den: 10 }));
    Frac public constant f = Frac.wrap(Fraction({ num: 5, den: 9 }));
    Frac public constant u = Frac.wrap(Fraction({ num: 36, den: 5 }));
    Frac public constant v = Frac.wrap(Fraction({ num: 1, den: 1 }));
    Frac public constant i = Frac.wrap(Fraction({ num: 9, den: 1 }));
    Frac public constant s = Frac.wrap(Fraction({ num: 7, den: 1 }));
    Frac public constant x = Frac.wrap(Fraction({ num: 2, den: 21 }));
    Frac public constant g = Frac.wrap(Fraction({ num: 8, den: 27 }));
    Frac public constant l = Frac.wrap(Fraction({ num: 11, den: 1 }));
    Frac public constant a = Frac.wrap(Fraction({ num: -3, den: 80 }));

    /// @notice Decode Frac to integer with bound check
    function decode(Frac word) internal pure returns (int256) {
        Fraction memory W = Frac.unwrap(word);
        if (W.den == 0 || W.num % W.den != 0) revert NonInteger();
        int256 val = W.num / W.den;
        if (val < -11 || val > 11) revert OutOfBounds();
        return val;
    }
}


// ─── Example ─────────────────────────────────
import { console } from "forge-std/console.sol";
// import letters and decode:
// import { z, e, r, o, n, t, w, h, f, u, v, i, s, x, g, l, a } from "./LegibleMath.sol";
// using the overloaded operators and decode directly:

contract Demo {
    function demo() external {
        // 1 + 2 = 3
        Frac one = o * n * e;
        Frac two = t * w * o;
        console.logInt(LegibleMath.decode(one + two)); // 3

        // (3 * 5) - (7 + 4) = 4
        Frac three = t * h * r * e * e;
        Frac five  = f * i * v * e;
        Frac seven = s * e * v * e * n;
        Frac four  = f * o * u * r;
        console.logInt(LegibleMath.decode(three * five - (seven + four))); // 4

        // negative eleven = -11
        Frac negOne = n * e * g * a * t * i * v * e;
        Frac eleven = e * l * e * v * e * n;
        console.logInt(LegibleMath.decode(negOne * eleven)); // -11
    }
}
