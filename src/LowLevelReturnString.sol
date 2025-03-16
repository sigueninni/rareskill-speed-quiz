// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract LowLevelReturnString {
    function main(address a) public returns (string memory) {
        // call function "baz()" on address a
        // do not use an interface
        // baz() returns a string. Return the string.
        // However, if baz reverts, return an empty string

        (bool callSuccess, bytes memory data) = a.call(
            abi.encodeWithSignature("baz()")
        );

        return (callSuccess ? abi.decode(data, (string)) : "");

        // bonus challenge: use an interface and a high level call to accomplish the same task
    }

    function callByInterface(address a) public returns (string memory) {
        // call function "bar()" on address a
        // do not use an interface
        // return the return value of the call

        try Baz(a).baz() {
            return Baz(a).baz();
        } catch {
            return "";
        }

        // bonus challenge: use an interface and a high level call to accomplish the same task
    }
}

interface Baz {
    function baz() external returns (string memory);
}
