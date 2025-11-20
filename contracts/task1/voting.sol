// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    mapping(address => uint256) private votesReceived;
    address[] voters;

    function vote(address candidate) public {
        votesReceived[candidate]++;
        if(votesReceived[msg.sender] == 1) {
            voters.push(msg.sender);
        }
    }

    function getVotes(address candidate) public view returns (uint256) {
        return votesReceived[candidate];
    }

    function resetVotes() public {
        for(uint256 i = 0; i < voters.length; i++) {
            delete votesReceived[voters[i]];
        }
    }

    // 反转字符串
    function reverseString(string memory s) public pure returns (string memory) {
        bytes memory sBytes = bytes(s);
        for(uint256 i = 0; i < sBytes.length / 2; i++) {
            bytes1 temp = sBytes[i];
            sBytes[i] = sBytes[sBytes.length - 1 -i];
            sBytes[sBytes.length - 1 -i] = temp;
        }
        return s;
    }
}