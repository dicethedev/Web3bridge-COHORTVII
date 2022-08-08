//SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Erc20Token is ERC20("Blessing", "BLE"){
    
    address public owner;

    event transferToken(address from, address  to, uint tokens);
    event approvalToken(address tokenOwner, address spender, uint tokens);

    modifier onlyOwner {
     require(msg.sender == owner, "No Permission. Fuck of!");
     _;
    }

    constructor() {
        owner = msg.sender;
        _mint(address(this), 1000e18);
    }
      
    function sendToken(address _to, uint256 amount) public onlyOwner {
       require(_to != address(0), "not a valid address");

       require(owner == msg.sender, "I mean Fuck off!");

       uint _balance = balanceOf(address(this));

       require(_balance >= amount, "insufficient fund");

       _transfer(address(this), _to, amount);
    }
     
    // mapping(address => uint256) public _balanceOf;

    modifier checkBalanceFirst(address _from, uint amount) {
        uint balance = balanceOf(_from);
         require(balance >= amount, "insufficent funds");
        _;
    }

   // when you get the address.. get the address to aprove another transfer 

      function approveToken(address spender, uint _tokenAmount) external checkBalanceFirst(msg.sender, _tokenAmount) {
         require(spender != address(0), "you are not spender");
        uint allowThis = _allowance[msg.sender][spender];
        if(allowThis == 0){
          _allowance[msg.sender][spender] = _tokenAmount;
        }
        else{
          _allowance[msg.sender][spender] += _tokenAmount;
        }\\\\\\\\\\
    }
    
    // ++++ mapping from the address +++++ //
    mapping(address => mapping( address => uint)) private _allowance;
    mapping(address => uint) balances;
      
      //manipulation of simple maths
       function Add(uint a, uint b) private pure returns (uint c) {
        c = a + b;
        require(c >= a);
       }
 
      function Sub(uint a, uint b) private pure returns (uint c) {
        require(b <= a);
         c = a - b;
      }

       function transferFromToken(address from, address to, uint tokensAmount) public returns (bool success) {
        balances[from] = Sub(balances[from], tokensAmount);
        _allowance[from][msg.sender] = Sub(_allowance[from][msg.sender], tokensAmount);
        balances[to] = Add(balances[to], tokensAmount);
        emit transferToken(from, to, tokensAmount);
        return true;
    }
 
     //the spender that is given approval in (3)  should be able to call 
     //the transferfrom function in order to spend the allowance given to him.


 }
