// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract StringIndex {
    function main(
        string memory str,
        uint256 index
    ) public returns (string memory) {
        // return the character at index in str
        // assume str only consists of ascii characters

        require(index < bytes(str).length, "outside bounds");

        /*        bytes memory convStrBytes = bytes(str);
        bytes memory returnedBytesStr = new bytes(1);

        returnedBytesStr[0] = convStrBytes[index];
        return string(returnedBytesStr); */

        require(index < bytes(str).length, "");
        return string(abi.encodePacked(bytes(str)[index]));
    }
}
