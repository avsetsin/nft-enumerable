// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NFT} from "../src/NFT.sol";

contract NFTSetupTest is Test {
    NFT public nft;

    address owner = address(1);

    function setUp() public {
        nft = new NFT("NFT token", "NFT", owner);
    }

    function test_Name() public {
        assertEq(nft.name(), "NFT token");
    }

    function test_Symbol() public {
        assertEq(nft.symbol(), "NFT");
    }

    function test_Owner() public {
        assertEq(nft.owner(), owner);
    }

    function test_MinTokenId() public {
        assertEq(nft.MIN_TOKEN_ID(), 1);
    }

    function test_MaxTokenId() public {
        assertEq(nft.MAX_TOKEN_ID(), 100);
    }
}
