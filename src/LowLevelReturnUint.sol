// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract LowLevelReturnUint {
    function main(address a) public returns (uint256) {
        // call function "bar()" on address a
        // do not use an interface
        // return the return value of the call

        (bool callSuccess, bytes memory data) = a.call(
            abi.encodeWithSignature("bar()")
        );
        require(callSuccess, "execution failled");
        return abi.decode(data, (uint256));

        // bonus challenge: use an interface and a high level call to accomplish the same task
    }

    function callByInterface(address a) public returns (uint256) {
        // call function "bar()" on address a
        // do not use an interface
        // return the return value of the call

        try Bar(a).bar() {
            return Bar(a).bar();
        } catch {
            revert("execution failled");
        }

        // bonus challenge: use an interface and a high level call to accomplish the same task
    }
}

interface Bar {
    function bar() external returns (uint256);
}
