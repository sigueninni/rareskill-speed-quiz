// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract LowLevelArgs1 {
    function main(address a, uint256 x) public {
        // call rare(x) using a low-level call
        // if the low level call reverts, revert also
        (bool successLowLevelCall, ) = a.call(
            abi.encodeWithSignature("rare(uint256)", x)
        );

        require(successLowLevelCall, "Low Level Call failed");
    }

    // bonus challenge: use an interface and a high level call to accomplish the same task
    function callByInterface(address a, uint256 x) public returns (bool) {
        try IRare(a).rare(x) {
            return true;
        } catch {
            revert("High level Call failed");
        }
    }
}

interface IRare {
    function rare(uint256) external;
}
