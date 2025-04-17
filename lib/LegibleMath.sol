// SPDX‑License‑Identifier: MIT
pragma solidity ^0.8.24;

/*───────────────────────────────────────────────────────────────*
 *  16‑bit signed numerator ⬆️ | 16‑bit unsigned denominator ⬇️   *
 *  packed into a single uint32  →  type LM is uint32             *
 *───────────────────────────────────────────────────────────────*/

type LM is uint32;
uint32 constant _DEN_MASK = 0xFFFF;
int256 constant _LIM = 32767;

/* ───────── errors ───────── */
error NotInteger(int256 num, int256 den);
error OutOfRange(int256 value);
error Overflow();

/* ───────── helpers ───────── */
function _split(LM f) pure returns (int256 num, int256 den) {
    uint32 raw = LM.unwrap(f);
    den = int256(uint16(raw & _DEN_MASK));
    num = int256(int16(uint16(raw >> 16)));      // sign‑extend
}

function _gcd(int256 a, int256 b) pure returns (int256) {
    while (b != 0) { (a, b) = (b, a % b); }
    return a >= 0 ? a : -a;
}

function _encode(int256 n, int256 d) pure returns (LM) {
    if (n < -_LIM || n > _LIM || d <= 0 || d > _LIM) revert Overflow();
    return LM.wrap(uint32(uint16(int16(n)) << 16 | uint16(uint256(d))));
}

function _reduce(int256 n, int256 d) pure returns (LM) {
    int256 g = _gcd(n, d);
    return _encode(n / g, d / g);
}

/* ───────── operator overloads ───────── */
function _plus (LM a, LM b) pure returns (LM) {
    (int256 na,int256 da) = _split(a);
    (int256 nb,int256 db) = _split(b);
    return _reduce(na*db + nb*da, da*db);
}
function _minus(LM a, LM b) pure returns (LM) {
    (int256 na,int256 da) = _split(a);
    (int256 nb,int256 db) = _split(b);
    return _reduce(na*db - nb*da, da*db);
}
function _times(LM a, LM b) pure returns (LM) {
    (int256 na,int256 da) = _split(a);
    (int256 nb,int256 db) = _split(b);
    return _reduce(na*nb, da*db);
}
function _over (LM a, LM b) pure returns (LM) {
    (int256 na,int256 da) = _split(a);
    (int256 nb,int256 db) = _split(b);
    if (nb == 0) revert();
    return _reduce(na*db, da*nb);
}

/* make the symbols global */
using {_plus as +, _minus as -, _times as *, _over as /} for LM global;

/* ───────── LegibleMath helpers ───────── */
library LegibleMath {
    function literally(LM f) internal pure returns (int256) {
        (int256 n,int256 d) = _split(f);
        if (n % d != 0) revert NotInteger(n, d);
        int256 v = n / d;
        if (v < -11 || v > 11) revert OutOfRange(v);
        return v;
    }

    struct Fraction { int256 num; int256 den; }
    function toFraction(LM f) internal pure returns (Fraction memory fr) {
        (fr.num, fr.den) = _split(f);
    }
}
using LegibleMath for LM global;

/*────────────────── pre‑packed constants (compile‑time literals) ──────────*/
/* Values taken from the letter‑product solution. letter-product-o4-mini-v2.pdf](file-service://file-SxRBUiP5LHs8LngXUnYyAW) */
LM constant z = LM.wrap(0x00000001);  // 0 / 1
LM constant o = LM.wrap(0x00010001);  // 1 / 1
LM constant n = LM.wrap(0x00010001);  // 1 / 1
LM constant e = LM.wrap(0x00010001);  // 1 / 1
LM constant r = LM.wrap(0x00010001);  // 1 / 1
LM constant t = LM.wrap(0x000a0001);  // 10 / 1
LM constant w = LM.wrap(0x00010005);  // 1 / 5
LM constant h = LM.wrap(0x0003000a);  // 3 / 10
LM constant f = LM.wrap(0x00050009);  // 5 / 9
LM constant u = LM.wrap(0x00240005);  // 36 / 5
LM constant s = LM.wrap(0x00070001);  // 7 / 1
LM constant x = LM.wrap(0x00020015);  // 2 / 21
LM constant g = LM.wrap(0x0008001b);  // 8 / 27
LM constant l = LM.wrap(0x000b0001);  // 11 / 1
LM constant a = LM.wrap(0xfffd0050);  // -3 / 80
