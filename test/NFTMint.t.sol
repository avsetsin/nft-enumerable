// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NFT} from "../src/NFT.sol";

contract NFTMintTest is Test {
    NFT public nft;

    address owner = address(1);
    uint256 minTokenId;
    uint256 maxTokenId;

    function setUp() public {
        nft = new NFT("NFT", "NFT", owner);
        minTokenId = nft.MIN_TOKEN_ID();
        maxTokenId = nft.MAX_TOKEN_ID();
    }

    function test_Mint() public {
        vm.prank(owner);
        nft.safeMint(1);
        assertEq(nft.ownerOf(1), owner);
    }

    function test_MintMinId() public {
        vm.prank(owner);
        nft.safeMint(minTokenId);
        assertEq(nft.ownerOf(minTokenId), owner);
    }

    function test_MintMaxId() public {
        vm.prank(owner);
        nft.safeMint(maxTokenId);
        assertEq(nft.ownerOf(maxTokenId), owner);
    }

    function test_MintGtMax() public {
        vm.prank(owner);
        vm.expectRevert(abi.encodeWithSelector(NFT.InvalidTokenId.selector, maxTokenId + 1, minTokenId, maxTokenId));
        nft.safeMint(maxTokenId + 1);
    }

    function test_MintLtMin() public {
        vm.prank(owner);
        vm.expectRevert(abi.encodeWithSelector(NFT.InvalidTokenId.selector, minTokenId - 1, minTokenId, maxTokenId));
        nft.safeMint(minTokenId - 1);
    }
}
