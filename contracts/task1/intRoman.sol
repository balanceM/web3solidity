// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract IntRoman {
    // 整数转罗马数字
    function intToRoman(uint num) public pure returns (string memory) {
        require(num > 0 && num < 4000, "Should be between 1 and 3999.");

        uint[13] memory intArr = [uint(1000), 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        string[13] memory strArr = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];

        bytes memory resBytes = new bytes(15); // 罗马数字不超过15个字符
        uint index = 0;
        for(uint i = 0; i < 13; i++) {
            while(num >= intArr[i]) {
                num -= intArr[i];
                bytes memory current = bytes(strArr[i]);
                for (uint j = 0; j < current.length; j++) {
                    resBytes[index] = current[j];
                    index++;
                }
            }
        }
        bytes memory result = new bytes(index);
        for (uint k = 0; k < index; k++) {
            result[k] = resBytes[k];
        }
        return string(result);
    }

    // 罗马数字转整数
    function romanToInt(string memory str) public pure returns (uint) {
        bytes memory strBytes = bytes(str);
        uint strLen = strBytes.length;
        uint prev = 0;
        uint res = 0;
        for(uint i = 0; i < strLen; i++){
            uint current = _getRomanValue(strBytes[strLen-1-i]);
            if(current < prev) {
                res -= current;
            } else {
                res += current;
            }
            prev = current;
        }
        return res;
    }

    function _getRomanValue(bytes1 char) private pure returns (uint) {
        if (char == 'I') {
            return 1;
        }
        if (char == 'V') {
            return 5;
        }
        if (char == 'X') {
            return 10;
        }
        if (char == 'L') {
            return 50;
        }
        if (char == 'C') {
            return 100;
        }
        if (char == "D") {
            return 500;
        }
        if (char == "M") {
            return 1000;
        }
        return 0;
    }
}