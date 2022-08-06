// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

    //increment and decrement in solidity
contract Counter {
    uint public count;

    function get() public view returns (uint) {
        return count;
    }

  //function to increment count by 1
    function inc() public {
        count += 1;
    } 

// function to decrement count by 1
    function dec() public {
     count -= 1;
    }
}
