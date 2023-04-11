//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SBTFactory {
    //state variable
    address public immutable i_uniAddress;
    address[] private s_accountsArray;
    mapping(address => string) private s_addressToCID;

    //events
    event AddedStudent(address _acc, string _cid);

    //errors
    error NotUniAccessDenied();
    error StudentDoesNotExists();

    //modifier
    modifier onlyUni() {
        if (msg.sender != i_uniAddress) revert NotUniAccessDenied();
        _;
    }

    //constructor
    constructor() {
        i_uniAddress = msg.sender;
    }

    //function to add a student
    function addStudent(address _acc, string memory _cid) public onlyUni {
        s_accountsArray.push(_acc);
        s_addressToCID[_acc] = _cid;
        emit AddedStudent(_acc, _cid);
    }

    //function to check if student exists
    function studentExists(address _acc) private view returns (bool) {
        require(msg.sender == _acc);

        //reading from state variables will take a lot of gas, so make an array in the memory here and iterate from that
        //  for (uint i = 0; i < s_accountsArray.length; i++) {
        //     if (s_accountsArray[i] == _acc) {
        //         return true;
        //     }
        // }

        //cheaper function
        address[] memory accountsArray = s_accountsArray;

        for (uint i = 0; i < accountsArray.length; i++) {
            if (accountsArray[i] == _acc) return true;
        }
        return false;
    }

    //function to search if the student exists
    function searchStudent(address _acc) public view returns (string memory) {
        if (!studentExists(_acc)) revert StudentDoesNotExists();
        return s_addressToCID[_acc];
    }
}
