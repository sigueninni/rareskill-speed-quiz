// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract Account2 {
    address immutable owner;

    constructor(address _owner) payable {
        owner = _owner;
    }

    function withdraw() external {
        require(msg.sender == owner, "Not owner");
        (bool ok,) = owner.call{value: address(this).balance}("");
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

        //NOT_CLEAR_FOR_ME the requirment!
        address create2Addr = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xff),
                            address(this),
                            bytes32(bytes20(uint160(owner))),
                            keccak256(abi.encodePacked(type(Account2).creationCode, abi.encode(owner)))
                        )
                    )
                )
            )
        );

        //send msg.value
        (bool success,) = create2Addr.call{value: msg.value}("");
        if (!success) {
            revert();
        }

        return create2Addr;
    }
}
