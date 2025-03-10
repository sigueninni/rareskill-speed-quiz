// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract ConvertToNegative {
    error TooBig();

    function convertToNegative(uint256 x) external pure returns (int256) {
        // return -x
        // if -x cannot be computed, revert with "TooBig()"
        // do not hardcode any constants
        int256 max = type(int256).max;
        if (x > uint256(max)) revert TooBig();
        int256 y = int256(x);
        return -y;
    }
}
