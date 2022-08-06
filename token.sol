//SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

contract Energy{
    
     //have total simply
     //transferrable
     //name
     //symbol
     //decimal
     //user balance
     //burnable

     //State Variables ////
     uint constant totalSupply = 1000;
     uint public circulatingSupply;
     string constant name = "Energy";
     string constant symbol = "ENG";
     uint constant decimal = 18;
     address public owner;

     mapping(address => uint) public _balance;

//event is very important when changing state 
     event tokenMint(address indexed _to, uint indexed _amount);
     event _transfer(address from, address _to, uint amount);

     modifier onlyOwner() {
         require(owner == msg.sender, "No Permission");
         _;
     }

     constructor(){
         owner = msg.sender;
     }

     function _name() public pure returns(string memory) {
         return name;
     }

      function _symbol() public pure returns(string memory) {
         return symbol;
     }

      function _decimal() public pure returns(uint) {
         return decimal;
     }

      function _totalSupply() public pure returns(uint) {
         return totalSupply;
     }
    
    //address - people you want to pass the mint to
     function mint(uint amount, address _to) public onlyOwner returns(uint) {
         circulatingSupply += amount; //increase total circulating supply
          require(circulatingSupply <= totalSupply, "totalSupply Exceeded");
          //address(0) is address that does not have private key... if you send anything to the address your money is gone for life
          require(_to != address(0), "mint to address zero");
           uint value = amount * decimal;
          _balance[_to] = value; //increase balance of token
          //emit is working with event
          emit tokenMint(_to, value);
          return value;
     }

     function transfer(address _to, uint amount) external {
         require(_to != address(0), "mint to address zero");
         uint userBalance = _balance[msg.sender];
         require(userBalance >= amount, "insufficient Funds");

         uint burnableToken = _burn(amount);
         uint transferrable = amount - burnableToken;

        //  _balance[msg.sender] -= amount;
        //  _balance[_to] += amount;
           _balance[msg.sender] -= amount;
         _balance[_to] += transferrable;
         emit _transfer(msg.sender, _to, amount);

     }
      
      function _burn(uint amount) private returns(uint256 burnableToken){
          burnableToken = calculateBurn(amount);
          circulatingSupply -= burnableToken / decimal;
      }

      function calculateBurn (uint amount) public pure returns(uint burn){
          burn = (amount + 10)/100;
      }

    function balanceOf(address who) public  view returns (uint){
    return _balance[who];
    }
    ////////////////////////////////////////////////////////////////////////////
    mapping(address => mapping( address => uint)) _allowance;

    modifier checkBalance(address _owner, uint amount) {
        uint balance = balanceOf(_owner);
        require(balance >= amount, "insufficent funds");
        _;
    }

    function Approve(address spender, uint amount) external checkBalance(msg.sender, amount) {
        require(spender != address(0));
        uint allow =  _allowance[msg.sender][spender];
        if(allow == 0){
        _allowance[msg.sender][spender] = amount;
        }
        else{
        _allowance[msg.sender][spender] += amount;

        }
        
    }

    ///Assignment
    function transferFrom(address from, address _to, uint amount) external checkBalance(from, amount){
        require(_to == msg.sender, "not spender");
        uint allowanceBalance = _allowance[from][_to];
        require(allowanceBalance >= amount, "no allowance for you");
        uint burnableToken = _burn(amount);
        uint transferrable = amount - burnableToken;
        _allowance[from][_to] -= amount;
        _balance[from] -= transferrable;
        _balance[_to] += transferrable;
    }
}
