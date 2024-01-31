# LoveLang NFT Collection on Polygon Mumbai

### About This Project

My first NFT project. The smart contract was written in Solidity, with significant code I had never encountered, for minting ERC721 tokens. The frontend was written in React.

I chose to have as the theme of the NFTs the word love in 52 languages. The NFT is randomly generated from 2 arrays, one with the "love" and one with the corresponding language. The SVG image in the background of the NFT is also generated randomly, with each color gradient set to be 120 degrees from the previous color using HSL color coding. (see sample below)

After exploring deployment options, I modified the project so that instead of using the Rinkeby testnet, I deployed the smart contract to the Polygon Mumbai Testnet. Polygon is fantastic! Alchemy made the switch pretty painless. The hardest part was getting testnet tokens! 😉

### What I Learned

We worked with the following "tools":
- Solidity
- Hardhat
- Alchemy
- Metamask
- React
- Replit
- Opensea
- Rarible
- Polygon

I was familiar with Replit, somewhat familiar with React and Metamask, but Hardhat and Alchemy were new to me. Fantastic tools!

The Solidity used was focused on ERC721 Non-Fungible Tokens. At first it was difficult getting my head wrapped around the interaction between the Smart Contract and the React code, but it became apparent quickly that ethers.js was providing a wide variety of functionality that allowed for the interaction. I really need to study this library more, as it (or web3.js) is essential to getting JS and Solidity smart contracts to interact. 

I also learned about Opensea and Rarible, and the roles they play in the NFT craze.

### Sample NFTs

![Love Language NFTs](sample_images/sample_love_language_nfts.jpg)

### Buildspace

[Buildspace](https://buildspace.so) provided excellent instruction with a very deep dive into the entire entire process minting NFTs using Solidity, Ethereum, and hardhat, as well as developing, testing, and deploying a web3 app.  

I received a **Buildspace NFT** - [see it on Opensea](https://opensea.io/assets/matic/0x3cd266509d127d0eac42f4474f57d0526804b44e/4643) - for completing this project.
