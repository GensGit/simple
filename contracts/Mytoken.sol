// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;  

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Counters.sol";               
import "@openzeppelin/contracts/interfaces/IERC2981.sol";

contract Mytoken is ERC721, IERC2981, ReentrancyGuard, Ownable {
    using Counters for Counters.Counter;

    constructor(string memory customBaseURI_) ERC721("Mytoken", "MYT") {
        customBaseURI = customBaseURI_;
    }

    mapping(address => uint256) private mintCountMap;

    mapping(address => uint256) private allowedMintCountMap;

    uint256 public constant MINT_LIMIT_PER_WALLET = 5;

    function allowedMintCount(address minter) public view returns (uint256) {
        return MINT_LIMIT_PER_WALLET - mintCountMap[minter];
    }

    function updateMintCount(address minter, uint256 count) private {
        mintCountMap[minter] += count;
    }

    uint256 public constant MAX_SUPPLY = 1500;

    uint256 public constant MAX_MULTIMINT = 5;

    uint256 public constant PRICE = 25000000000000000;  // 0.025

    Counters.Counter private supplyCounter;

    function mint(uint256 count) public payable nonReentrant {
        require(saleIsActive, "Sale not active");

    if (allowedMintCount(msg.sender) >= count) {
        updateMintCount(msg.sender, count);
    } 
    
    else {
        revert("Minting limit exceeded");
    }

    require(totalSupply() + count - 1 < MAX_SUPPLY, "Max Supply Reached");

    require(count <= MAX_MULTIMINT, "Max mint is 10");

    require(
        msg.value >= PRICE * count, "Too little ETH, 0.025 ETH per NFT"
    );

    for (uint256 i = 0; i < count; i++) {
        _mint(msg.sender, totalSupply());
        supplyCounter.increment();
        }
    }

    bool private revealed = false;
    string private revealURI = "https://gateway.pinata.cloud/ipfs/QmU6qNJvcKzaGW5woWRNsBYZDaiLaamcLyHomEoPnKXyBx/unrevealed.json";

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId),"ERC721Metadata: URI query for nonexistent token");
        if (revealed == true) {          
            return string(abi.encodePacked(customBaseURI, "/", Strings.toString(tokenId+1),".json"));
        }
        else {
            return revealURI;
        }
    }

    function reveal() public onlyOwner {
        revealed = true;
    }

    function totalSupply() public view returns (uint256) {
        return supplyCounter.current();
    }

    bool public saleIsActive = true;

    function setSaleIsActive(bool saleIsActive_) external onlyOwner {
        saleIsActive = saleIsActive_;
    }

    string private customBaseURI;

    function setBaseURI(string memory customBaseURI_) external onlyOwner {
        customBaseURI = customBaseURI_;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return customBaseURI;
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function royaltyInfo(uint256, uint256 salePrice) external view override returns (address receiver, uint256 royaltyAmount) {
        return (address(this), (salePrice * 690) / 10000);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, IERC165) returns (bool){
        return (interfaceId == type(IERC2981).interfaceId || super.supportsInterface(interfaceId));
    }
}