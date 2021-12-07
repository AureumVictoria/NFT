// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./Ownable.sol";
import "./ERC721Enumerable.sol";
import "./IERC20.sol";

    contract SecurusNFT is Ownable, ERC721Enumerable {

        using Strings for uint256;
        uint public NftLicenceUpdateTicker = 0;
        address public receiverAddress;
        string public baseTokenURI;
        string public endTokenURI;

    /**
     * @dev Implements ERC721 contract and sets default values. 
     */
    constructor(string memory name, string memory symbol, string memory defaultBaseTokenURI, string memory defaultEndTokenURI) ERC721(name, symbol) {
        baseTokenURI = defaultBaseTokenURI; 
        endTokenURI = defaultEndTokenURI; 
        receiverAddress = msg.sender;
    }

    /**
     * @dev Creates a new NFT.
     * @param to Receiver of the newly created token. 
     * @param tokenId Unique if of the NFT.
     */
    function mint(address to, uint256 tokenId) external onlyAuthorized() {
        _safeMint(to, tokenId); 
    }
    
    /**
     * @dev update the URI base for all NFTs.
     * @param newEndTokenURI New URI base.
     */
    function setEndURI(
        string calldata newEndTokenURI) external onlyAuthorized() {
        endTokenURI = newEndTokenURI;
    }
  
    /**
     * @dev Overrides _endURI function so we define the URI base we will be using.
     */
    function _endURI() internal view virtual override returns (string memory) {
        return endTokenURI;
    }

    /**
     * @dev update the URI base for all NFTs.
     * @param newBaseTokenURI New URI base.
     */
    function setBaseURI(
        string calldata newBaseTokenURI) external onlyAuthorized() {
        baseTokenURI = newBaseTokenURI;
    }
  
    /**
     * @dev Overrides _baseURI function so we define the URI base we will be using.
     */
    function _baseURI() internal view virtual override returns (string memory) {
        return baseTokenURI;
    }

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        if (block.timestamp < users[tokenId].endLicence) {
        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0
        ? string(abi.encodePacked(baseURI))
        : '';
        } else {
        string memory baseURI = _endURI();
        return bytes(baseURI).length > 0
        ? string(abi.encodePacked(baseURI))
        : '';
      } 
    }
  
    /**
     * @dev NFT holder can renew his licence
     * this function is designed to permanently weed out inactive holders and regulate inflation and deflation  
     * renew the licence for 365 days.
     * 
     * Requirements:
     * 
     * msg.sender is token holder to renew the licence
     */
    function updateLicence(uint tokenId) external onlyAuthorized() {
            NftLicenceUpdateTicker += 1;
            uint balance = block.timestamp;
            uint endLicence = balance + BLOCK_PER_YEAR;  
            users[tokenId] = User(tokenId, balance, endLicence);  
    }

    /**
     * @dev Outputs the current block timestamp 
     */
    function timestamp() external view returns (uint256) {
        return block.timestamp;
    }

    /**
     * @dev Outputs the start licence block timestamp 
     */
    function startLicenceBlock(uint256 tokenId) external view returns (uint256) {
        return users[tokenId].balance;
    }
    
    /**
     * @dev Outputs the end licence block timestamp 
     */
    function endLicenceBlock(uint256 tokenId) external view returns (uint256) {
        return users[tokenId].endLicence;
    }
    
    /**
     * @dev Outputs the remaining time of the licence in days
     */
    function checkLicenceDays(uint tokenId) public view returns (uint){
        uint licenceTimeBlocks;
        uint licenceTimeDays;
          
        licenceTimeBlocks = users[tokenId].endLicence - users[tokenId].balance;
        licenceTimeDays = licenceTimeBlocks / BLOCK_PER_DAY;
        
        return licenceTimeDays;
    }
    
    /**
     * @dev Outputs licence is aktiv [true or false]
     */
    function checkLicenceAktiv(uint tokenId) public view returns (bool){
        bool licenceAktiv;

            if (block.timestamp < users[tokenId].endLicence) {
         return licenceAktiv = true;
        } 
            else  {
         return  licenceAktiv = false;   
        }
    }   
    
}