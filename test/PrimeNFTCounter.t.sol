// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NFT} from "../src/NFT.sol";
import {PrimeNFTCounter} from "../src/PrimeNFTCounter.sol";

contract PrimeNFTCounterTest is Test {
    NFT public nft;
    PrimeNFTCounter public counter;

    address owner = address(1);

    function setUp() public {
        nft = new NFT("NFT token", "NFT", owner);
        counter = new PrimeNFTCounter(address(nft));
    }

    function test_NFTContract() public {
        assertEq(address(counter.NFT_CONTRACT()), address(nft));
    }

    function test_PrimesTokenIdsCount() public {
        mintCollection([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]);
        assertEq(counter.getPrimesTokenIdsCount(owner), 9);
    }

    function test_PrimesTokenIdsCountAllPrimes() public {
        mintCollection([2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71]);
        assertEq(counter.getPrimesTokenIdsCount(owner), 20);
    }

    function test_PrimesTokenIdsCountEmpty() public {
        assertEq(counter.getPrimesTokenIdsCount(owner), 0);
    }

    // Helpers

    function mintCollection(uint8[20] memory tokenIds) internal {
        vm.startPrank(owner);
        for (uint256 i = 0; i < 20; ++i) {
            nft.safeMint(tokenIds[i]);
        }
        vm.stopPrank();
    }
}
