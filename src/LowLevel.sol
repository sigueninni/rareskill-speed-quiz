// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract LowLevel {
    function main(address a) public returns (bool) {
        // call function "foo()" on address a
        // do not use an interface, use a low level call
        // return true if the call succeeded
        // return false if the call failed

        (bool callSuccess,) = a.call(abi.encodeWithSignature("foo()"));
        return callSuccess;
    }

    // bonus challenge: use an interface and a high level call to accomplish the same task
    function callByInterface(address a) public returns (bool) {
        try IFoo(a).foo() {
            return true;
        } catch {
            return false;
        }
    }
}

interface IFoo {
    function foo() external;
}
