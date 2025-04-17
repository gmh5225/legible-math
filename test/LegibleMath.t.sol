pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import {
    LM, z, o, n, e, r, t, w, h, f, u, s, x, g, l, a, i, v,
    NotInteger, OutOfRange, Overflow
} from "../lib/LegibleMath.sol";

contract LegibleMathTest is Test {
    function test_one_plus_two() public pure {
        LM lhs = o * n * e;
        LM rhs = t * w * o;
        assertEq((lhs + rhs).literally(), 3, "o*n*e + t*w*o should equal 3");
    }

    function test_spell_zero() public pure {
        LM res = z * e * r * o;
        assertEq(res.literally(), 0);
    }

    function test_spell_one() public pure {
        LM res = o * n * e;
        assertEq(res.literally(), 1);
    }

    function test_spell_two() public pure {
        LM res = t * w * o;
        assertEq(res.literally(), 2);
    }

    function test_spell_three() public pure {
        LM res = t * h * r * e * e;
        assertEq(res.literally(), 3);
    }

    function test_spell_four() public pure {
        LM res = f * o * u * r;
        assertEq(res.literally(), 4);
    }

    function test_spell_five() public pure {
        LM res = f * i * v * e;
        assertEq(res.literally(), 5);
    }

    function test_spell_six() public pure {
        LM res = s * i * x;
        assertEq(res.literally(), 6);
    }

    function test_spell_seven() public pure {
        LM res = s * e * v * e * n;
        assertEq(res.literally(), 7);
    }

    function test_spell_eight() public pure {
        LM res = e * i * g * h * t;
        assertEq(res.literally(), 8);
    }

    function test_spell_nine() public pure {
        LM res = n * i * n * e;
        assertEq(res.literally(), 9);
    }

    function test_spell_ten() public pure {
        LM res = t * e * n;
        assertEq(res.literally(), 10);
    }

    function test_spell_eleven() public pure {
        LM res = e * l * e * v * e * n;
        assertEq(res.literally(), 11);
    }

    function test_spell_negative_four() public pure {
        LM negative = n * e * g * a * t * i * v * e;
        LM four = f * o * u * r;
        LM result = negative * four;
        assertEq(result.literally(), -4, "negative * four should equal -4");
    }

    function test_spell_one_plus_one_equals_two() public pure {
        LM one = o * n * e;
        LM two = t * w * o;
        assertEq((one + one).literally(), two.literally());
    }

    function test_spell_two_times_three_equals_six() public pure {
        LM two = t * w * o;
        LM three = t * h * r * e * e;
        LM six = s * i * x;
        assertEq((two * three).literally(), six.literally());
    }

    function test_spell_ten_minus_one_equals_nine() public pure {
        LM ten = t * e * n;
        LM one = o * n * e;
        LM nine = n * i * n * e;
        assertEq((ten - one).literally(), nine.literally());
    }

    /* OutOfRange Tests for literally() */
    function test_out_of_range_positive() public {
        // Create 12/1, which is outside the -11..11 range for literally()
        LM twelve = LM.wrap(0x000c0001);
        vm.expectRevert(abi.encodeWithSelector(OutOfRange.selector, 12));
        this.callLiterally(twelve);
    }

    function test_out_of_range_negative() public {
        // Create -12/1, which is outside the -11..11 range for literally()
        LM negative_twelve = LM.wrap(0xfff40001); // -12 signed 16-bit is 0xFFF4
        vm.expectRevert(abi.encodeWithSelector(OutOfRange.selector, -12));
        this.callLiterally(negative_twelve);
    }

    // Helper wrapper to ensure revert depth is deeper than cheatcode
    function callLiterally(LM _f) public pure returns (int256) {
        return _f.literally();
    }
}
