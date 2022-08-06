//SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Mapping {
    mapping(address => uint256) balances;

    function deposit(address _address) public payable {
            balances[_address] += msg.value;
    }

    function returnDeposit(address _account) public view returns(uint256) {
        return balances[_account];
    }

    //function to return the balance of ether
     function getDeposit() public view returns(uint256) {
         return address(this).balance;
     }

}
