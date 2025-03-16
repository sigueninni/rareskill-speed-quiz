// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract ConvertToNegative {
    error TooBig();

    function convertToNegative(uint256 x) external pure returns (int256) {
        // return -x
        // if -x cannot be computed, revert with "TooBig()"
        // do not hardcode any constants
        int256 y;
        uint256 min = uint256(type(int256).max);
        min = min + 1;
        if (x > min) revert TooBig();
        // if( x == uint256(type(int256).max) + 1)
        if (x == min) {
            y = int256(x - 1);
            return -y - 1;
        } else {
            y = int256(x);
        }

        return -y;
    }
}
