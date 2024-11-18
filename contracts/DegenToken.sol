// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    struct Weapon {
        string id;
        string name;
        uint256 price;
        uint256 quantity;
    }

    Weapon[5] public weapons;

    // Mapping for weapon inventories
    mapping(address => string[]) playerInventories;

    // Constructor to initialize the token and weapon store
    constructor(address initialOwner) ERC20("Degen", "DGN") Ownable(initialOwner) {
        weapons[0] = Weapon("0", "Buster Sword", 70, 3);
        weapons[1] = Weapon("1", "Dragon Slayer", 100, 2);
        weapons[2] = Weapon("2", "Blades of Chaos", 50, 6);
        weapons[3] = Weapon("3", "Keyblade", 45, 10);
        weapons[4] = Weapon("4", "Gundam Suit", 990, 1);
    }

    // Mint tokens
    function mint(address to, uint256 amount) external onlyOwner {
        require(to != address(0), "Cannot mint to zero address");
        _mint(to, amount);
    }

    // Burn tokens
    function burnTokens(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    // Transfer tokens to another address
    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }

    event WeaponRedeemed(address indexed player, string weaponId);

    function redeem(uint256 weaponId) external {
        require(weaponId < weapons.length, "Weapon does not exist"); 
        Weapon storage weapon = weapons[weaponId]; 
        require(weapon.quantity > 0, "Weapon out of stock"); 
        require(balanceOf(msg.sender) >= weapon.price, "Insufficient tokens");

        // Deduct the weapon's price in tokens 
        _burn(msg.sender, weapon.price); 
        weapon.quantity -= 1;

        // Weapon will add to player's inventory after redeeming it
        playerInventories[msg.sender].push(weapon.id);

        emit WeaponRedeemed(msg.sender, weapon.id);
    }

    // Player's inventory
    function getInventory() public view returns (string[] memory) {
        return playerInventories[msg.sender];
    }

    // View details of weapon
    function getWeapon(uint256 weaponId) public view returns (string memory name, uint256 price, uint256 quantity) {
        require(weaponId < weapons.length, "Invalid weapon ID");
        Weapon storage weapon = weapons[weaponId];
        return (weapon.name, weapon.price, weapon.quantity);
    }

    // Check the balance
    function checkBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }
}
