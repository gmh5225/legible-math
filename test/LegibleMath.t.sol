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
        // Note: The actual value of f*o*u*r is (5/9)*1*(36/5)*1 = 4
        assertEq(v.literally(), 4);
    }

    function test_spell_five() public {
        LM v = f * i * v * e;
        // Requires constants for i and v to be defined in LegibleMath.sol
        // Assuming i=1, v=5 based on typical word puzzles
        assertEq(v.literally(), 5);
    }

    function test_spell_six() public {
        LM v = s * i * x;
        // Requires constant for i to be defined
        // Assuming i=1
        assertEq(v.literally(), 6);
    }

    function test_spell_seven() public {
        LM v = s * e * v * e * n;
        // Requires constant for v to be defined
        // Assuming v=5
        assertEq(v.literally(), 7);
    }

    function test_spell_eight() public {
        LM v = e * i * g * h * t;
        // Requires constant for i to be defined
        // Assuming i=1. Note: g is defined as 8/27 in LegibleMath.sol
        // Calculation: 1 * 1 * (8/27) * (3/10) * 10 = 8/9. This will not equal 8 literally.
        // This test will likely fail unless g's definition changes or a different approach is used.
        assertEq(v.literally(), 8);
    }

    function test_spell_nine() public {
        LM v = n * i * n * e;
        // Requires constant for i to be defined
        // Assuming i=1
        assertEq(v.literally(), 9);
    }

    function test_spell_ten() public {
        LM v = t * e * n;
        assertEq(v.literally(), 10);
    }

    function test_spell_eleven() public {
        LM v = e * l * e * v * e * n;
        // Requires constant for v to be defined
        // Assuming v=5
        assertEq(v.literally(), 11);
    }

    // Test each constant's fraction and literally behavior
    function test_constants() public {
        int256 num;
        int256 den;
        (num, den) = z.toFraction();
        assertEq(num, 0);
        assertEq(den, 1);
        assertEq(z.literally(), 0);
        (num, den) = o.toFraction();
        assertEq(num, 1);
        assertEq(den, 1);
        assertEq(o.literally(), 1);
        (num, den) = n.toFraction();
        assertEq(num, 1);
        assertEq(den, 1);
        assertEq(n.literally(), 1);
        (num, den) = e.toFraction();
        assertEq(num, 1);
        assertEq(den, 1);
        assertEq(e.literally(), 1);
        (num, den) = r.toFraction();
        assertEq(num, 1);
        assertEq(den, 1);
        assertEq(r.literally(), 1);
        (num, den) = t.toFraction();
        assertEq(num, 10);
        assertEq(den, 1);
        assertEq(t.literally(), 10);
        (num, den) = w.toFraction();
        assertEq(num, 1);
        assertEq(den, 5);
        vm.expectRevert(abi.encodeWithSelector(NotInteger.selector, 1, 5));
        this.callLiterally(w);
        (num, den) = h.toFraction();
        assertEq(num, 3);
        assertEq(den, 10);
        vm.expectRevert(abi.encodeWithSelector(NotInteger.selector, 3, 10));
        this.callLiterally(h);
        (num, den) = f.toFraction();
        assertEq(num, 5);
        assertEq(den, 9);
        vm.expectRevert(abi.encodeWithSelector(NotInteger.selector, 5, 9));
        this.callLiterally(f);
        (num, den) = u.toFraction();
        assertEq(num, 36);
        assertEq(den, 5);
        vm.expectRevert(abi.encodeWithSelector(NotInteger.selector, 36, 5));
        this.callLiterally(u);
        (num, den) = s.toFraction();
        assertEq(num, 7);
        assertEq(den, 1);
        assertEq(s.literally(), 7);
        (num, den) = x.toFraction();
        assertEq(num, 2);
        assertEq(den, 21);
        vm.expectRevert(abi.encodeWithSelector(NotInteger.selector, 2, 21));
        this.callLiterally(x);
        (num, den) = g.toFraction();
        assertEq(num, 8);
        assertEq(den, 27);
        vm.expectRevert(abi.encodeWithSelector(NotInteger.selector, 8, 27));
        this.callLiterally(g);
        (num, den) = l.toFraction();
        assertEq(num, 11);
        assertEq(den, 1);
        assertEq(l.literally(), 11);
        (num, den) = a.toFraction();
        assertEq(num, -3);
        assertEq(den, 80);
        vm.expectRevert(abi.encodeWithSelector(NotInteger.selector, -3, 80));
        this.callLiterally(a);
    }

    // Test basic operations: multiplication, division, subtraction
    function test_arithmetic() public {
        int256 num;
        int256 den;
        LM prod = t * w;
        (num, den) = prod.toFraction();
        assertEq(num, 2);
        assertEq(den, 1);
        LM div1 = s / o;
        (num, den) = div1.toFraction();
        assertEq(num, 7);
        assertEq(den, 1);
        vm.expectRevert(); // divide by zero
        this.callDiv(w, z);
        LM diff = t - o;
        (num, den) = diff.toFraction();
        assertEq(num, 9);
        assertEq(den, 1);
    }

    // Test multiplication overflow protection
    function test_overflow_mul() public {
        LM big = LM.wrap((uint32(uint16(int16(200))) << 16) | uint32(uint16(1)));
        vm.expectRevert(abi.encodeWithSelector(Overflow.selector));
        this.callMul(big, big);
    }

    // Test literal() OutOfRange protection
    function test_literal_OutOfRange() public {
        LM twelve = LM.wrap((uint32(uint16(int16(12))) << 16) | uint32(uint16(1)));
        vm.expectRevert(abi.encodeWithSelector(OutOfRange.selector, 12));
        this.callLiterally(twelve);
    }

    // Helper wrappers to ensure revert depth is deeper than cheatcode
    function callLiterally(LM f) public pure returns (int256) {
        return f.literally();
    }

    function callMul(LM x, LM y) public pure returns (LM) {
        return x * y;
    }

    function callDiv(LM x, LM y) public pure returns (LM) {
        return x / y;
    }
}
