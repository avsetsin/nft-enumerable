// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

/**
 * @title PrimeNFTCounter
 * @dev A contract for counting the number of prime NFT token IDs owned by an address
 */
contract PrimeNFTCounter {
    ERC721Enumerable public immutable NFT_CONTRACT;

    /**
     * @dev Initializes the contract with the address of the NFT contract
     * @param nft The address of the ERC721Enumerable NFT contract
     */
    constructor(address nft) {
        NFT_CONTRACT = ERC721Enumerable(nft);
    }

    /**
     * @dev Returns the number of prime NFT token IDs owned by the specified address
     * @param owner The address to check for prime NFT token IDs
     * @return counter The number of prime NFT token IDs owned by the address
     */
    function getPrimesTokenIdsCount(address owner) public view returns (uint256 counter) {
        uint256 balance = NFT_CONTRACT.balanceOf(owner);
        uint256 tokenId;

        for (uint256 i = 0; i < balance;) {
            tokenId = NFT_CONTRACT.tokenOfOwnerByIndex(owner, i);

            unchecked {
                if (_isPrime(tokenId)) ++counter;
                ++i;
            }
        }
    }

    /**
     * @dev Checks if a given number is prime
     * @param num The number to check for primality
     * @return result True if the number is prime, false otherwise
     */
    function _isPrime(uint256 num) internal pure returns (bool result) {
        result = true;

        if (num < 2) return false;
        if (num == 2) return true;
        if (num % 2 == 0) return false;

        assembly {
            for { let i := 3 } lt(mul(i, i), num) { i := add(i, 2) } {
                if iszero(mod(num, i)) {
                    result := 0
                    break
                }
            }
        }
    }
}
