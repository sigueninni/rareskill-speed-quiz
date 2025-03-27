// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract Account2 {
    address immutable owner;

    constructor(address _owner) payable {
        owner = _owner;
    }

    function withdraw() external {
        require(msg.sender == owner, "Not owner");
        (bool ok, ) = owner.call{value: address(this).balance}("");
        require(ok);
    }
}

contract AccountMaker {
    function makeAccount(address owner) external payable returns (address) {
        // use create2 to create an account with the owner address
        // the salt should be the owner address
        // the value sent to them should be msg.value

        //      Adress : 20 bytes - 160 bits
        //      hash(0xFF, sender, salt, bytecode)
        //      bytes32 hashAdress = keccak256( abi.encodePacked(bytes1(0xff), msg.sender, owner, owner.code)

        bytes32 salt;
        salt = bytes32(bytes20(owner));
        address add = address(
            new Account2{salt: salt, value: msg.value}(owner)
        );
        return add;
    }
}
