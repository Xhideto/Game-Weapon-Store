# Game-Weapon-Store

## Description

The `Game Weapon Store` smart contract introduces a unique weapon game store where users can mint, burn, and transfer tokens, as well as redeem them for various in-game weapons. The store features five distinct weapons, each with its own price and limited quantity. Users can purchase these weapons by burning the required amount of tokens, ensuring a dynamic and engaging experience.

## Prerequisites

- Any JS IDE that has Node.js installed
- Metamask wallet that connected to avalanche Fuji network
- SnowTrace Testnet

## Getting Started

### Installing

1. This code can be used by cloning this repository.
   
  ```git clone <repository-url(copy it under drop-down green code button on the repo)>```

2. In your preferred JS IDE open terminal and type:

- terminal: ```npm i```

### Executing program

1. Back to the terminal, type `npx hardhat run scripts/deploy.js --network fuji
` to get your address for SnowTrace Testnet
2. Open https://testnet.snowtrace.io/ to paste your address in the search bar and click it that will be your history transaction.
3. Now open your contract to `Remix` to deploy.
4. At deploy and run transactions, in the Environment select Inject to connect your metamask as the address for the transactions.
5. At At_Address, enter your snowtrace address and click it.
6. Now you are ready to interact with it, just click the drop down interaction.

### Contract interaction

- `Mint function` you(the owner) can add tokens to your Metamask wallet.
- `Burn function` can deduct your tokens at any amount.
- `Transfer function` can send tokens to another address.
- `Redeem function` can redeem weapons from the store it will burn your token and deduct its quantity.
- `Check Balance` can check balance of the token.
- `getWeapon function` can get the weapon details(name, price, & quantity).

## Help

- Make sure the Metamask wallet connected to avalanche fuji network.

## Author

Jairell Louis J. Ignacio
https://github.com/Xhideto

## License

This project is licensed under the MIT
