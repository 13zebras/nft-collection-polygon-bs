import React, { useEffect, useState } from 'react';
import './styles/App.css';
import twitterLogo from './assets/twitter-logo.svg';
import { ethers } from 'ethers';
import myEpicNft from './utils/MyEpicNFT.json';

// Constants
const TWITTER_HANDLE = 'TomStine_dev';
const TWITTER_LINK = `https://twitter.com/${TWITTER_HANDLE}`;
const RARIBLE_LINK = 'https://rinkeby.rarible.com';
const OPENSEA_LINK = 'https://testnets.opensea.io';
const ETHERSCAN='https://rinkeby.etherscan.io';
const POLYGONSCAN='https://mumbai.polygonscan.com';
const TOTAL_MINT_COUNT = 50;

const CONTRACT_ADDRESS = "0x8dcf86585ec04c2fe5857107c20fa0c3c8a089a6";

//For reference to coding urls:
//https://testnets.opensea.io/collection/lovelangnft-otmdc9fxem
//https://testnets.opensea.io/assets/mumbai/0x8dcf86585ec04c2fe5857107c20fa0c3c8a089a6/0
//https://mumbai.polygonscan.com/tx/0x7ecc4e3d4cb9ce4a76e3368236d045a893a47022f691b520c7b4c172f59e32af

const App = () => {
  
  /** State variable we use to store our user's public wallet.*/

  const [currentAccount, setCurrentAccount] = useState("");

  // State for openSea URL
  // const [openSeaResult, setOpenSeaResult] = useState("");
    

  const checkIfWalletIsConnected = async () => {
    
    const { ethereum } = window;

    if (!ethereum) {
      console.log("Make sure you have metamask!");
      return;
    } else {
      console.log("We have the ethereum object", ethereum);
    }

    const accounts = await ethereum.request({ method: 'eth_accounts' });

    
    if (accounts.length !== 0) {
        const account = accounts[0];
        console.log("Found an authorized account:", account);
        setCurrentAccount(account)
        /*if wallet already connected*/
        setupEventListener()

      } else {
        console.log("No authorized account found")
      }
  }

  const connectWallet = async () => {
    try {
      const { ethereum } = window;

      if (!ethereum) {
        alert("Get MetaMask!");
        return;
      }

      const accounts = await ethereum.request({ method: "eth_requestAccounts" });

      console.log("Connected", accounts[0]);
      setCurrentAccount(accounts[0]); 

      setupEventListener()

    } catch (error) {
      console.log(error)
    }
  }

  // Setup our listener.
  const setupEventListener = async () => {
    // Most of this looks the same as our function askContractToMintNft
    try {
      const { ethereum } = window;

      if (ethereum) {
        // Same stuff again
        const provider = new ethers.providers.Web3Provider(ethereum);
        const signer = provider.getSigner();
        const connectedContract = new ethers.Contract(CONTRACT_ADDRESS, myEpicNft.abi, signer);

        
        connectedContract.on("NewEpicNFTMinted", (from, tokenId) => {
          console.log(from, tokenId.toNumber())
          alert(`We've minted your NFT and sent it to your wallet. It may be blank right now. It can take up to 10 min to show up on OpenSea. Here's the link to your NFT on Opensea: ${OPENSEA_LINK}/assets/mumbai/${CONTRACT_ADDRESS}/${tokenId.toNumber()}`)
        });

        console.log("Setup event listener!")

      } else {
        console.log("Ethereum object doesn't exist!");
      }
    } catch (error) {
      console.log(error)
    }
  }

  const askContractToMintNft = async () => {
      
      try {
        const { ethereum } = window;

        if (ethereum) {
          const provider = new ethers.providers.Web3Provider(ethereum);
          const signer = provider.getSigner();
          const connectedContract = new ethers.Contract(CONTRACT_ADDRESS, myEpicNft.abi, signer);

          console.log("Gotta pay for gas...")
          let nftTxn = await connectedContract.makeAnEpicNFT();

          console.log("Mining...puh-leze wait.")
          await nftTxn.wait();
          
          console.log(`Mined! See transaction: ${POLYGONSCAN}/tx/${nftTxn.hash}`);

        } else {
          console.log("Ethereum object doesn't exist!");
        }
      } catch (error) {
        console.log(error)
      }
    }
  
  // This runs our function when the page loads.
  
  useEffect( () => {
    checkIfWalletIsConnected();
  }, [])

  // Render Methods
 
  const renderNotConnectedContainer = () => (
    <button onClick={connectWallet} className="cta-button connect-wallet-button">
      Connect Wallet to Start
    </button>
  );

  const renderMintUI = () => (
    <div className="mint">
      
      <h3 className="gradient-text-reverse">After connecting your wallet:</h3>
      <div className="instructions">
        <ol>
          <li>This NFT is deployed on Polygon Mumbai Testnet.</li>
          <li>If you don't own any MATIC Test Tokens, go to <a href="https://faucet.polygon.technology/" target="_blank">Polygon Faucet</a> to add some to your metamask wallet. MATIC Test Tokens are F-R-E-E!</li>
          <li>When you have the MATIC Test Tokens in your wallet, click the <strong> "Mint NFT"</strong> button below.</li>
        </ol>
      </div>
      <button onClick={askContractToMintNft} className="cta-button mint-button">
        Mint NFT
      </button>
    </div>

  )

  const linkToRarible = () => {
    location = `${RARIBLE_LINK}/collection/${CONTRACT_ADDRESS}`;
  }

  const linkToOpensea = () => {
    location = `${OPENSEA_LINK}/collection/lovelangnft-otmdc9fxem`;
  }

  return (
    <div className="App">
      <div className="container">
        <div className="header-container">
          <p className="header gradient-text">Love & Languages NFT Collection</p>
          <div className="sub-text">
            <p>Each unique. </p>
            <p>Each beautiful.</p>
            <p>Each full of love.</p>
          </div>
          {currentAccount === "" ? renderNotConnectedContainer() : renderMintUI()}
          <div className="opensea">
            <button onClick={linkToOpensea} className="cta-button-small opensea-button">View NFT Collection on OpenSea</button>
          </div>
        </div>
        
        <div className="footer-container">
          <img alt="Twitter Logo" className="twitter-logo" src={twitterLogo} />
          <a
            className="footer-text"
            href={TWITTER_LINK}
            target="_blank"
            rel="noreferrer"
          >{`built by @${TWITTER_HANDLE}`}</a>
        </div>
      </div>
    </div>
  );
};

export default App;