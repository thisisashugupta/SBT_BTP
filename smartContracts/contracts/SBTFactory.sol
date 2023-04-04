//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SBTFactory {
    event AddedStudent(address acc, string cid);

    address public uni;

    constructor() {
        uni = msg.sender;
    }

    address[] private accountArray;
    mapping(address => string) private addressToCID;

    function addStudent(address acc, string memory cid) public onlyUni {
        accountArray.push(acc);
        addressToCID[acc] = cid;
        emit AddedStudent(acc, cid);
    }

    function studentExists(address acc) private view returns (bool) {
        require(msg.sender == acc);
        for (uint i = 0; i < accountArray.length; i++) {
            if (accountArray[i] == acc) {
                return true;
            }
        }
        return false;
    }

    function searchStudent(address acc) public view returns (string memory) {
        require(studentExists(acc));
        return addressToCID[acc];
    }

    modifier onlyUni() {
        require(msg.sender == uni);
        _;
    }
}
// Deployed Contract Address: 0x64800F063Eb4FBD9AF3c9F8CDB7B787f4116558c
// on goerli network
