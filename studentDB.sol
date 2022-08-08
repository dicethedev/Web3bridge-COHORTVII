//SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract StudentDB {
    
     address owner;

      struct student {
          string name;
          uint256 age;
          uint256[] score;
      }
      
      mapping(address => student ) public _studentDb;

       constructor() {
         owner = msg.sender;
       }

       //add admin to Register & access their data
       modifier onlyAdmin() {
           require(owner == msg.sender, "Only Admin has access");
           _;
       }

       //Register a student
       function InitalRecord(address _address, string memory _name, uint256 _age, uint256 _score) public onlyAdmin {
           student storage s = _studentDb[_address];
           s.name = _name;
           s.age = _age;
           s.score.push(_score);
       }

       //returns the data one a particular student

       function returnInitalRecord(address _address) public view returns ( student memory) {
           return _studentDb[_address];
       }

       //returns the array of student information
       function returnArray(address[] memory query) public view returns(student[] memory e) {
           e = new student[](query.length);
          for(uint256 i=0; i < query.length; i++) {
              e[i] = _studentDb[query[i]];
          }
       }
       
       //update the array of score
       function updateScore(address _address, uint256 _score) onlyAdmin public {
           student storage r = _studentDb[_address];
           r.score.push(_score);
       }


}
