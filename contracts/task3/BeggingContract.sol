// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;
// 0xaC2aFF58083e5Ed94823687BCa792269a07E88B1
contract BeggingContract {
    address public owner;
    mapping(address => uint256) public donatorTotal;

    struct Donation {
        address donator;
        uint256 amount;
        uint256 timestamp;
    }
    Donation[] public donationRecords;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "you are not owner");
        _;
    }

    function donate() external payable {
        require(msg.value > 0, "value must be greater than 0");

        donationRecords.push(Donation({
            donator: msg.sender,
            amount: msg.value,
            timestamp: block.timestamp
        }));
        donatorTotal[msg.sender] += msg.value;
    }

    function withdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    function getDonation(address donator) external view returns(uint256) {
        require(donator != address(0), "donator is a 0 address");

        return donatorTotal[donator];
    }
}