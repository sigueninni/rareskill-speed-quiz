// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract NinetyNinePercent {
    function is99Percent(uint256 x, uint256 y) public pure returns (bool) {
        // assume y < (2^256 - 1) / 10_000
        // example: x = 990, y = 1000, return true
        // example: x = 989, y = 1000, return false
        // example: x = 4499, y = 4545 return false
        // example: x = 32999999999, y = 33333333333 return false
        //i understood to check if x = 0.99 of y !  == 100 x = 99y
        //return ( x*99 == y*100);
        require(y > 0);
        return (((x * 100) / y) == 99);
    }
}
