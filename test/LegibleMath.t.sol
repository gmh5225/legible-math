pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import {
    LM, z, o, n, e, r, t, w, h, f, u, s, x, g, l, a, i, v,
    NotInteger, OutOfRange, Overflow
} from "../lib/LegibleMath.sol";

contract LegibleMathTest is Test {
    function test_one_plus_two() public {
        LM lhs = o * n * e;
        LM rhs = t * w * o;
        assertEq((lhs + rhs).literally(), 3, "o*n*e + t*w*o should equal 3");
    }

    function test_spell_zero() public {
        LM v = z * e * r * o;
        assertEq(v.literally(), 0);
    }

    function test_spell_one() public {
        LM v = o * n * e;
        assertEq(v.literally(), 1);
    }

    function test_spell_two() public {
        LM v = t * w * o;
        assertEq(v.literally(), 2);
    }

    function test_spell_three() public {
        LM v = t * h * r * e * e;
        assertEq(v.literally(), 3);
    }

    function test_spell_four() public {
        LM v = f * o * u * r;
        assertEq(v.literally(), 4);
    }

    function test_spell_five() public {
        LM v = f * i * v * e;
        assertEq(v.literally(), 5);
    }

    function test_spell_six() public {
        LM v = s * i * x;
        assertEq(v.literally(), 6);
    }

    function test_spell_seven() public {
        LM v = s * e * v * e * n;
        assertEq(v.literally(), 7);
    }

    function test_spell_eight() public {
        LM v = e * i * g * h * t;
        assertEq(v.literally(), 8);
    }

    function test_spell_nine() public {
        LM v = n * i * n * e;
        assertEq(v.literally(), 9);
    }

    function test_spell_ten() public {
        LM v = t * e * n;
        assertEq(v.literally(), 10);
    }

    function test_spell_eleven() public {
        LM v = e * l * e * v * e * n;
        assertEq(v.literally(), 11);
    }
}
