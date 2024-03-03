// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable2Step} from "@openzeppelin/contracts/access/Ownable2Step.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title NFT
 * @dev This contract represents a non-fungible token (NFT) that is enumerable and has two-step ownership transfer
 */
contract NFT is ERC721Enumerable, Ownable2Step {
    uint256 public immutable MIN_TOKEN_ID = 1;
    uint256 public immutable MAX_TOKEN_ID = 100;

    error InvalidTokenId(uint256 tokenId, uint256 min, uint256 max);

    constructor(string memory name, string memory symbol, address owner) ERC721(name, symbol) Ownable(owner) {}

    /**
     * @dev Safely mints a new token with the given `tokenId`
     *
     * Requirements:
     * - The `tokenId` must be within the range of `MIN_TOKEN_ID` and `MAX_TOKEN_ID`
     *
     * Emits a {Transfer} event from the zero address to the caller's address
     *
     * @param tokenId The ID of the token to be minted
     */
    function safeMint(uint256 tokenId) external onlyOwner {
        if (tokenId < MIN_TOKEN_ID || tokenId > MAX_TOKEN_ID) {
            revert InvalidTokenId(tokenId, MIN_TOKEN_ID, MAX_TOKEN_ID);
        }

        _safeMint(msg.sender, tokenId);
    }
}
