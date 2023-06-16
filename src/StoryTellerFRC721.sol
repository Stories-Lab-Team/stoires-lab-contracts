// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "openzeppelin-contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "openzeppelin-contracts/utils/Counters.sol";

contract StoryTellerFRC721 is ERC721URIStorage{
    
    using Counters for Counters.Counter;
     Counters.Counter private _tokenIds;

    struct storyTellerFRC721NFT {
        address owner;
        string tokenURI;
        uint256 tokenId;
    }

    storyTellerFRC721NFT[] public nftCollection;
    mapping(address => storyTellerFRC721NFT[]) public nftCollectionByOwner;

    event NewStoryTellerFRC721NFTMinted(
      address indexed sender,
      uint256 indexed tokenId,
      string tokenURI
    );

    constructor() ERC721("StoryTeller NFTs", "BAC") {
      //console.log("Hello Fil-ders! Now creating Bacalhau FRC721 NFT contract!");
    }

    function mintStoryTellerNFT(address owner, string memory ipfsURI)
        public
        returns (uint256)
    {
        uint256 newItemId = _tokenIds.current();

        storyTellerFRC721NFT memory newNFT = storyTellerFRC721NFT({
            owner: msg.sender,
            tokenURI: ipfsURI,
            tokenId: newItemId
        });

        _mint(owner, newItemId);
        _setTokenURI(newItemId, ipfsURI);
        nftCollectionByOwner[owner].push(newNFT);

        _tokenIds.increment();

        nftCollection.push(newNFT);

        emit NewStoryTellerFRC721NFTMinted(
          msg.sender,
          newItemId,
          ipfsURI
        );

        return newItemId;
    }

    /**
     * @notice helper function to display NFTs for frontends
     */
    function getNFTCollection() public view returns (storyTellerFRC721NFT[] memory) {
        return nftCollection;
    }

    /**
     * @notice helper function to fetch NFT's by owner
     */
    function getNFTCollectionByOwner(address owner) public view returns (storyTellerFRC721NFT[] memory){
        return nftCollectionByOwner[owner];
    }

    function mintMultipleStoryTellerNFTs(address owner, string[] memory ipfsMetadata) public returns (uint256[] memory)
    {
        //console.log('minting bacalhau nfts');

        //get length of ipfsMetadata array
        uint256 length = ipfsMetadata.length;
        uint256[] memory tokenIdArray = new uint256[](length);

        //loop through calling mintBacalhauNFT for each
        uint j=0;
        for (j = 0; j < length; j ++) {  //for loop example
            tokenIdArray[j] = mintStoryTellerNFT(owner, ipfsMetadata[j]);     
        }

        return tokenIdArray;
    }


}
