// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ERC20 {
    address owner;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) approves;

    event Transfer(address indexed from, address indexed to, uint256);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not owner");
        _;
    }

    modifier illegalValue(uint256 value) {
        require(value > 0, "Value must be greater than 0");
        _;
    }

    function mint(address to, uint256 value) external onlyOwner {
        require(to != address(0), "Mint to 0 address");
        require(value > 0, "Mint amount must be greater than 0");

        balances[to] += value;
    }

    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }

    function transfer(address to, uint256 value) external illegalValue(value) returns (bool) {
        require(balances[msg.sender] >= value, "Balance is not enough");

        balances[msg.sender] -= value;
        balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) external illegalValue(value) returns (bool) {
        approves[msg.sender][spender] += value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external illegalValue(value) returns (bool) {
        require(approves[from][msg.sender] >= value, "Approve amount is not enough");
        require(balances[from] >= value, "Balance is not enough");

        approves[from][msg.sender] -= value;
        balances[from] -= value;
        balances[to] += value;
        emit Transfer(from, to, value);
        return true;
    }
}