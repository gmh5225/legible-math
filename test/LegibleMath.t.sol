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
        LM res = z * e * r * o;
        assertEq(res.literally(), 0);
    }

    function test_spell_one() public {
        LM res = o * n * e;
        assertEq(res.literally(), 1);
    }

    function test_spell_two() public {
        LM res = t * w * o;
        assertEq(res.literally(), 2);
    }

    function test_spell_three() public {
        LM res = t * h * r * e * e;
        assertEq(res.literally(), 3);
    }

    function test_spell_four() public {
        LM res = f * o * u * r;
        assertEq(res.literally(), 4);
    }

    function test_spell_five() public {
        LM res = f * i * v * e;
        assertEq(res.literally(), 5);
    }

    function test_spell_six() public {
        LM res = s * i * x;
        assertEq(res.literally(), 6);
    }

    function test_spell_seven() public {
        LM res = s * e * v * e * n;
        assertEq(res.literally(), 7);
    }

    function test_spell_eight() public {
        LM res = e * i * g * h * t;
        assertEq(res.literally(), 8);
    }

    function test_spell_nine() public {
        LM res = n * i * n * e;
        assertEq(res.literally(), 9);
    }

    function test_spell_ten() public {
        LM res = t * e * n;
        assertEq(res.literally(), 10);
    }

    function test_spell_eleven() public {
        LM res = e * l * e * v * e * n;
        assertEq(res.literally(), 11);
    }

    function test_spell_negative_four() public {
        LM negative = n * e * g * a * t * i * v * e;
        LM four = f * o * u * r;
        LM result = negative * four;
        assertEq(result.literally(), -4, "negative * four should equal -4");
    }

    function test_spell_one_plus_one_equals_two() public {
        LM one = o * n * e;
        LM two = t * w * o;
        assertEq((one + one).literally(), two.literally());
    }

    function test_spell_two_times_three_equals_six() public {
        LM two = t * w * o;
        LM three = t * h * r * e * e;
        LM six = s * i * x;
        assertEq((two * three).literally(), six.literally());
    }

    function test_spell_ten_minus_one_equals_nine() public {
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
        twelve.literally();
    }

    function test_out_of_range_negative() public {
        // Create -12/1, which is outside the -11..11 range for literally()
        LM negative_twelve = LM.wrap(0xfff40001); // -12 signed 16-bit is 0xFFF4
        vm.expectRevert(abi.encodeWithSelector(OutOfRange.selector, -12));
        negative_twelve.literally();
    }
}
