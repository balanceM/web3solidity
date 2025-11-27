// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;
// 0xaC2aFF58083e5Ed94823687BCa792269a07E88B1
contract BeggingContract {
    address public owner;
    mapping(address => uint256) public donatorTotal;
    // struct Donation {
    //     address donator;
    //     uint256 amount;
    //     uint256 timestamp;
    // }
    // Donation[] public donationRecords;
    event Donation(address donator, uint256 value);
    uint256 top3MinAmount; // 进入前3的最少金额
    uint256 top3MinIndex; // 进入前3的最少金额的对应地址索引
    address[3] public top3Donators; // 捐赠金额最多的前3个地址

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "you are not owner");
        _;
    }

    uint256 public constant TARGET_TIMESTAMP = 1735702861;
    modifier timeLimit() {
        require(block.timestamp > TARGET_TIMESTAMP, "donate start after 2025-01-01 01:01:01 UTC");
        _;
    }

    function donate() external payable timeLimit {
        require(msg.value > 0, "value must be greater than 0");

        // donationRecords.push(Donation({
        //     donator: msg.sender,
        //     amount: msg.value,
        //     timestamp: block.timestamp
        // }));
        emit Donation(msg.sender, msg.value);
        donatorTotal[msg.sender] += msg.value;

        uint256 curAmount;
        address curDonator;
        if(donatorTotal[msg.sender] > top3MinAmount) {
            bool CountGreater3 = true;
            for (uint256 i=0; i < 3; i++) {
                if (top3Donators[i] == address(0)) { // 捐赠者还没达到3个
                    CountGreater3 = false;

                    top3Donators[i] = msg.sender;
                    if(i != 2) break; // 后续还会有0地址时

                    // 最后一位是0地址时，设置当前捐赠者时
                    top3MinAmount = donatorTotal[top3Donators[0]];
                    for(uint256 j=1; j<3; j++) {
                        curDonator = top3Donators[j];
                        curAmount = donatorTotal[curDonator];
                        if (top3MinAmount > curAmount) {
                            top3MinAmount = curAmount;
                            top3MinIndex = j;
                        }
                    }
                }
            }

            if (CountGreater3) { // 捐赠者达到3个,执行
                top3Donators[top3MinIndex] = msg.sender;
                top3MinAmount = donatorTotal[msg.sender];
                for (uint256 i=0; i < 3; i++) {
                    if(i == top3MinIndex) continue;

                    curAmount = donatorTotal[top3Donators[i]];
                    if(top3MinAmount > curAmount) {
                        top3MinAmount = curAmount;
                        top3MinIndex = i;
                    }
                }
            }
        }
    }

    function withdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    function getDonation(address donator) external view returns(uint256) {
        require(donator != address(0), "donator is a 0 address");

        return donatorTotal[donator];
    }
}