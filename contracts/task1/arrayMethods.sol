// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract ArrayMethods {
    // 将两个有序数组合并为一个有序数组
    function mergeSortedArray(int[] memory arr1, int[] memory arr2) public pure returns (int[] memory) {
        uint len1 = arr1.length;
        uint len2 = arr2.length;
        uint totalSize = len1 + len2;
        int[] memory res = new int[](totalSize);
        
        uint i = 0;
        uint j = 0;
        uint k = 0;
        while (i < len1 && j < len2) {
            if (arr1[i] <= arr2[j]) {
                res[k] = arr1[i];
                i++;
            } else {
                res[k] = arr2[j];
                j++;
            }
            k++;
        }

        while (i < len1) {
            res[k] = arr1[i];
            i++;
            k++;
        }
        while (j < len2) {
            res[k] = arr2[j];
            j++;
            k++;
        }

        return res;
    }

    // 二分查找
    function binarySearch(int[] memory arr, int dest) public pure returns (uint) {
        uint len = arr.length;
        if (len == 0) return type(uint).max;
        // 
        uint startI = 0;
        uint endI = len - 1;
        uint index = 0;
        while (startI <= endI) {
            index = (startI + endI) / 2;
            if (dest == arr[index]) {
                return index;
            } else if (dest > arr[index]) {
                startI = index+1;
            } else if (dest < arr[index]) {
                endI = index-1;
            }
        }
        return type(uint).max;
    }
}