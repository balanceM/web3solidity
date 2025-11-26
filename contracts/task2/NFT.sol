// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721, ERC721URIStorage, Ownable {
    uint256 public tokenIdCounter;

    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) Ownable(msg.sender) {
        tokenIdCounter = 0;
    }

    function mintNFT(address recipient, string memory tokenURI_) external onlyOwner returns (uint256) {
        require(recipient != address(0), "Mint to the 0 address");

        uint256 newTokenId = tokenIdCounter;
        _safeMint(recipient, newTokenId); // 安全铸造，设置NFT归属账户
        _setTokenURI(newTokenId, tokenURI_); // NFT关联元数据链接

        tokenIdCounter++;
        return newTokenId;
    }
    
    // 重写必要函数（解决 ERC721 与 ERC721URIStorage 继承冲突）
    function tokenURI(uint256 tokenId) 
        public 
        view 
        override(ERC721, ERC721URIStorage) 
        returns (string memory) 
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) 
        public 
        view 
        override(ERC721, ERC721URIStorage)
        returns (bool) 
    {
        return super.supportsInterface(interfaceId);
    }
}