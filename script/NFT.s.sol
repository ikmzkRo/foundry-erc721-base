// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/baseERC721.sol";

contract NFTScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        NFT nftContract = new NFT("MyNFT", "NFT", "https://example.com/");

        vm.stopBroadcast();
    }
}