//SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Counter {
    uint public count;
    uint timestop = block.timestamp + 30 seconds;

    function add() public {
      require(block.timestamp <= timestop, "your time is up");
      count ++;
    }
   
    function dec() public {
        require(block.timestamp <= timestop, "your time is up");
        count --;
    }

     function getCount() public view returns (uint) {
        return count;
    }

    function timeReturn() public view returns (uint e) {
        e = timestop - block.timestamp;
        return e;
    }

     function timeStamp() public view returns (uint) {
       return block.timestamp;
    }

}
