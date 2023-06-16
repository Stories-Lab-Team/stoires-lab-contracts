// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/StoryTellerFRC721.sol";

contract StoryTellerFRC721Test is Test {
    StoryTellerFRC721 public storyTellerFRC721;
    address bob = address(0x12345);

    function setUp() public {
        storyTellerFRC721 = new StoryTellerFRC721();
    }

    function testmintStoryTellerNFT() public {
        string memory dummyTokenUri = "ipfs://metadata_url";
        uint256 tokenId = storyTellerFRC721.mintStoryTellerNFT(bob, dummyTokenUri);
        
        assertEq(dummyTokenUri, storyTellerFRC721.tokenURI(tokenId));
    }

}
