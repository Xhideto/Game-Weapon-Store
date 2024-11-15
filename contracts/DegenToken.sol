// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    struct Weapon {
        string name;
        uint256 price;
        uint256 quantity;
    }

    // List of Game weapons in the store
    Weapon[5] public weapons;

    constructor(address initialOwner) ERC20("Degen", "DGN") Ownable(initialOwner) {
        // 5 weapons
        weapons[0] = Weapon("Buster Sword", 700, 3);
        weapons[1] = Weapon("Dragon Slayer", 1000, 2);
        weapons[2] = Weapon("Blades of Chaos", 5000, 6);
        weapons[3] = Weapon("Keyblade", 450, 10);
        weapons[4] = Weapon("Gundam Suit", 9999, 1);
    }

    // Minting new tokens
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Burn tokens
    function burnTokens(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Transfer tokens to another address
    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    // Redeem tokens for a weapon in the store
    function redeem(uint256 weaponId) public {
        require(weaponId < weapons.length, "Weapon does not exist");
        Weapon storage weapon = weapons[weaponId];
        require(weapon.quantity > 0, "Weapon out of stock");
        require(balanceOf(msg.sender) >= weapon.price, "Insufficient tokens");

        // Deduct the weapon's price in tokens 
        // Reduce weapon quantity
        _burn(msg.sender, weapon.price);
        weapon.quantity -= 1;
    }

    // Check the balance
    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    // View weapon details
    function getWeapon(uint256 weaponId) public view returns (string memory name, uint256 price, uint256 quantity) {
        require(weaponId < weapons.length, "Weapon does not exist");
        Weapon storage weapon = weapons[weaponId];
        return (weapon.name, weapon.price, weapon.quantity);
    }
}
