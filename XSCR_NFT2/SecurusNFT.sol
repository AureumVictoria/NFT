pragma solidity 0.8.4;

import "./Ownable.sol";
import "./ERC721Enumerable.sol";
import "./IERC20.sol";

    contract SecurusNFT is Ownable, ERC721Enumerable {

        using Strings for uint256;
        licence[] public licenses;
        uint public NftLicenceUpdateTicker = 0;
        address public receiverAddress;
        string public baseTokenURI;

        struct licence {
        address paymentCoin;
        uint256 price;
        uint256 idCounter;
    }
  
    /**
     * @dev Implements ERC721 contract and sets default values. 
     */
    constructor(string memory name, string memory symbol, string memory defaultBaseTokenURI) ERC721(name, symbol) {
        baseTokenURI = defaultBaseTokenURI; 
        receiverAddress = msg.sender;
    }
    
    /**
     * @dev Mapping of addresses that are authorized to add mint new tokens.
     */
    mapping (address => bool) public authorizedAddresses;

    /**
     * @dev Only authorized addresses can call a function with this modifier.
     */
    modifier onlyAuthorized() {
        require(authorizedAddresses[msg.sender] || owner() == msg.sender, "Not authorized");
        _;
    }
  
    /**
     * @dev add a licence [paymentCoin] and [price] for the Licence Index to buy licences .
     */
    function addLicence(address paymentCoin, uint256 price) external onlyOwner {
        licence memory l = licence(paymentCoin, price, 0);
        licenses.push(l);
    }
    
    /**
     * @dev remove a licence [paymentCoin] and [price] for the Licence Index to buy licences .
     */
    function removeLicence(uint256 index) external onlyOwner {
        delete licenses[index];
    }

    /**
     * @dev set new receiver address for license fees .
     * 
     * Requirements:
     * 
     * address `NewReceiverAddress` cannot be the zero address.
     */
    function setNewReceiverAddress(address NewReceiverAddress) public onlyOwner {
        receiverAddress = address (NewReceiverAddress);
    }

    /**
     * @dev Sets or revokes authorized address.
     * @param addr Address we are setting.
     * @param isAuthorized True is setting, false if we are revoking.
     */
    function setAuthorizedAddress(address addr, bool isAuthorized) external onlyOwner() {
        authorizedAddresses[addr] = isAuthorized;
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
     * @dev Updatey the URI base for all NFTs.
     * @param newBaseTokenURI New URI base.
     */
    function setBaseURI(
        string calldata newBaseTokenURI) external onlyOwner() {
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

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0
        ? string(abi.encodePacked(baseURI))
        : '';
    }
  
    /**
     * @dev NFT holder can renew his licence
     * This function is designed to permanently weed out inactive holders and regulate inflation and deflation  
     * He pays [l.price] with [paymentCoin] to [_receiverAddress] to renew the licence for 365 days.
     * 
     * Requirements:
     * 
     * msg.sender is token holder to renew the licence
     */
    function updateLicence(uint tokenId, uint256 licenceIndex) external {
        licence memory l = licenses[licenceIndex];
            require(isWhitelisted(msg.sender) != false || SetWhitelist != true, "Not Whitelisted");
            require(isBlacklisted(msg.sender) != true, "isBlacklisted");
            require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: licence Update caller is not owner nor approved");
            NftLicenceUpdateTicker += 1;
            licenses[licenceIndex].idCounter++;
            IERC20 paymentCoins = IERC20 (address(l.paymentCoin));
            paymentCoins.transferFrom(msg.sender, receiverAddress, l.price);
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

        uint timestamp = block.timestamp;
     
            if (timestamp < users[tokenId].endLicence) {
         return licenceAktiv = true;
        } 
            else  {
         return  licenceAktiv = false;   
        }
    }   
    
}