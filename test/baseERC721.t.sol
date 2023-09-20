// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "openzeppelin/utils/Strings.sol";
import "../src/baseERC721.sol";

contract NFTTest is Test {
    NFT public nftContract;
    // テストの前提条件をセットアップ関数: setUp <=> beforeEach
    function setUp() public {
        // はじめに、../src/baseERC721.solのNFTコントラクトをデプロイします
        nftContract = new NFT("NFT", "NFT", "https://example.com/");
    }

    function test_MintTo() public {
        address user1 = address(1);
        address user2 = address(2);

        nftContract.mintTo(user1);
        nftContract.mintTo(user2);

        // /**
        //  * @dev See {IERC721Enumerable-tokenOfOwnerByIndex}.
        //  */
        // function tokenOfOwnerByIndex(address owner, uint256 index) public view virtual override returns (uint256) {
        //     require(index < ERC721.balanceOf(owner), "ERC721Enumerable: owner index out of bounds");
        //     return _ownedTokens[owner][index];
        // }

        uint256 tokenIndex1 = nftContract.tokenOfOwnerByIndex(user1, 0);
        uint256 tokenIndex2 = nftContract.tokenOfOwnerByIndex(user2, 0);

        assertEq(tokenIndex1, 0);
        assertEq(tokenIndex2, 1);
    }

    // 何故か通過してしまう
    function testFail_MintTo() public {
        address user0 = address(0);
        nftContract.mintTo(user0);
        // assertEq("ERC721: mint to the zero address");
    }

    function testTokenURI(uint256 index) public {
        string memory result = nftContract.tokenURI(index);
        string memory expected = string(
            abi.encodePacked(
                "https://example.com/",
                Strings.toString(index),
                ".json"
            )
        );
        assertEq(result, expected);
    }
}