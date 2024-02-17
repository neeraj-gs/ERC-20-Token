// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function totalSupply() external view returns(uint256);
    function balanceOf(address account) external view returns(uint256);
    function transfer(address recipient,uint256 amount) external returns(bool);
    function allowance(address owner,address spender) external view returns(uint256);
    function approve(address spender,uint256 amount) external returns(bool);
    function transferFrom(address sender,address recipient,uint256 amount) external returns(bool);

    event Transfer(address indexed from,address indexed to,uint256 value);
    event Approval(address indexed owner,address indexed spender,uint256 value);
}

abstract contract Block is IERC20{
    string public name="Neeraj"; //token name
    string public symbol="NGS"; //token symbol
    uint public decimal=0;
    address public founder; //address who is deploying the token
    mapping (address => uint) public balance; //balance of each address

    uint public totalSupply; //getter function is cretead for public varaibles

    mapping(address => mapping(address => uint)) allowed;

    constructor(){
        totalSupply = 1000;
        founder=msg.sender;
        balance[founder] = totalSupply; //adding all supply to owner or founder
    }

    function balanceOf(address account) external view returns(uint256){
        return balance[account]; //balance of tokens of an account
    }

    function transfer(address recipient,uint256 amount) external returns(bool){
        require(amount>0,"Amount Has to be Greater Than 0");
        require(balance[msg.sender]>amount,"Insufficnet Funds or No Balance");
        balance[msg.sender]-=amount;
        balance[recipient]+=amount;

        emit Transfer(msg.sender,recipient,amount);
        return true;
    }

    function allowance(address owner,address spender) external view returns(uint256){
        //function to give authority to use my tokens
        return allowed[owner][spender]; //Number of tokens the owner has allowed to the spender
        //Tokens authority is gien to the spender
    }

    function approve(address spender,uint256 amount) external returns(bool){
        //give the approval of for hte allowance
        require(amount>0,"Amount Has to be Greater than 0");
        require(balance[msg.sender]>amount,"Insufficient Funds");
        allowed[msg.sender][spender] = amount; //here we give or allow spender to take our authority
        return true;
    }




}