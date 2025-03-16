// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract LowLevelArgs2 {
    function main(address a, uint256 x, uint256 y) public {
        // call rare(x, y) using a low-level call
        // if the low level call reverts, revert also

        (bool successLowLevelCall, ) = a.call(
            abi.encodeWithSignature("rare(uint256,uint256)", x, y) //I noticed uint instead of uint256 do not work, normal it is an encoding
        );

        require(successLowLevelCall, "Low Level Call failed");

        // bonus challenge: use an interface and a high level call to accomplish the same task
    }

    // bonus challenge: use an interface and a high level call to accomplish the same task
    function callByInterface(
        address a,
        uint256 x,
        uint256 y
    ) public returns (bool) {
        try IRare(a).rare(x, y) {
            return true;
        } catch {
            revert("High level Call failed");
        }
    }
}

interface IRare {
    function rare(uint256, uint256) external;
}
