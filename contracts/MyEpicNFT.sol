// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We need to import the helper functions from the contract that we copy/pasted.
import { Base64 } from "./libraries/Base64.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract MyEpicNFT is ERC721URIStorage {
  // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  string[] loveWords = ["liefde", "dashuri", "maite", "pyaar", "ljubav", "karantez", "amor", "gugma", "guiaya", "adageyudi", "chikondi", "amore", "ljubav", "milovat", "elsker", "liefde", "armastus", "pag-ibig", "rakkaus", "amour", "leafde", "amor", "liebe", "agape", "aloha", "pyar", "szerelem", "ast", "gra", "amore", "koi", "milestiba", "meile", "leift", "cinta", "imhabba", "meena", "milosc", "amor", "dragoste", "lyubov", "ghaoil", "ljubav", "milovat", "ljubezen", "amor", "pendo", "karlek", "anpu", "cariad", "uthando"];

  string[] languageWords = ["Afrikaans", "Albanian", "Basque", "Bhojpuri", "Bosnian", "Breton", "Catalan", "Cebuano", "Chamorro", "Cherokee", "Chichewa", "Corsican", "Croatian", "Czech", "Danish", "Dutch", "Estonian", "Filipino", "Finnish", "French", "Frisian", "Galician", "German", "Greek", "Hawaiian", "Hindi", "Hungarian", "Icelandic", "Irish", "Italian", "Japanese", "Latvian", "Lithuanian", "Luxembourgish", "Malay", "Maltese", "Pashto", "Polish", "Portuguese", "Romanian", "Russian", "ScotsGaelic", "Serbian", "Slovak", "Slovenian", "Spanish", "Swahili", "Swedish", "Tamil", "Welsh", "Zulu"];

  string baseSvg1 = "<svg xmlns='http://www.w3.org/2000/svg' height='300' width='300'><defs><linearGradient id='grad1' x1='0%' y1='0%' x2='0%' y2='100%'><stop offset='0%' style='stop-color:hsl(";

  string baseSvg2a = ",100%,75%);stop-opacity:1' /><stop offset='40%' style='stop-color:hsl(";

  string baseSvg2b = ",100%,75%);stop-opacity:1' /><stop offset='60%' style='stop-color:hsl(";

  string baseSvg3 = ",100%,75%);stop-opacity:1' /><stop offset='100%' style='stop-color:hsl(";

  string baseSvg4 = ",100%,75%);stop-opacity:1' /></linearGradient></defs><style>#text1 { fill: #000000; font-family: serif; font-size: 50px; } #text2 { fill: #000000; font-family: sans-serif; font-size: 20px; }</style><circle cx='50%' cy='50%' r='50%' fill='url(#grad1)' stroke='black' stroke-width='1' /><text x='50%' y='48%' id='text1' dominant-baseline='middle' text-anchor='middle'>";

  string baseSvg5 = "</text><text x='50%' y='61%' id='text2' dominant-baseline='middle' text-anchor='middle'>(";

  
  event NewEpicNFTMinted(address sender, uint256 tokenId);

  constructor() ERC721 ("lovelangNFT", "LOVELANG") {
    console.log("--> NFTs are bodacious! Fucking eh, bubba! END");
  }

  function random(uint256 tokenId) internal view returns (uint256) {
      uint stamp = block.timestamp;
      console.log("--> timestamp = ", stamp);
      return uint256(keccak256(abi.encodePacked(stamp, msg.sender, tokenId)));
  }

  function pickLoveLanguageWords(uint256 tokenId) public view returns (string[2] memory) {
    uint256 rand = random(tokenId);
    rand = rand % loveWords.length;
    return [loveWords[rand], languageWords[rand]];
  }

  function getColorDegrees(uint256 tokenId) internal view returns (string [3] memory) {
    uint256 randNum = random(tokenId);
    uint256 randDegree = randNum % 360;
    string memory degree1 = Strings.toString(randDegree);
    string memory degree2 = Strings.toString(randDegree + 120);
    string memory degree3 = Strings.toString(randDegree + 240);
    return [degree1, degree2, degree3];
  }

// A function our user will hit to get their NFT.
  function makeAnEpicNFT() public {
     // Get the current tokenId, this starts at 0.
    uint256 newItemId = _tokenIds.current();

    string[2] memory loveLanguage = pickLoveLanguageWords(newItemId);

    string[3] memory colorDegrees = getColorDegrees(newItemId);

    console.log("--> degree1 = ", colorDegrees[0]);
    console.log("--> degree2 = ", colorDegrees[1]);
    console.log("--> degree3 = ", colorDegrees[2]);

    string memory nameLoveLanguage = string(abi.encodePacked(loveLanguage[0], loveLanguage[1], "NFT"));
    console.log("--> nameLoveLanguage = ", nameLoveLanguage);

    // I concatenate it all together, and then close the <text> and <svg> tags.
    string memory semiFinalSvgA = string(abi.encodePacked(baseSvg1, colorDegrees[0], baseSvg2a, colorDegrees[1], baseSvg2b, colorDegrees[1]));
    string memory semiFinalSvgB = string(abi.encodePacked(baseSvg3, colorDegrees[2], baseSvg4, loveLanguage[0], baseSvg5, loveLanguage[1], ")</text></svg>"));
    string memory finalSvg = string(abi.encodePacked(semiFinalSvgA, semiFinalSvgB));

    console.log("\n--------------------");
    console.log(finalSvg);
    console.log("--------------------\n");

    // Get all the JSON metadata in place and base64 encode it.
    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "',
                    // We set the title of our NFT as the generated word.
                    nameLoveLanguage,
                    '", "description": "Love in many languages from around the world.", "image": "data:image/svg+xml;base64,',
                    // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                    Base64.encode(bytes(finalSvg)),
                    '"}'
                )
            )
        )
    );

    // Just like before, we prepend data:application/json;base64, to our data.
    string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
    );

    console.log("\n--------------------");
    console.log(finalTokenUri);
    console.log("--------------------\n");


     // Actually mint the NFT to the sender using msg.sender.
    _safeMint(msg.sender, newItemId);

    // Set the NFTs data.
    _setTokenURI(newItemId, finalTokenUri);

    // Increment the counter for when the next NFT is minted.
    _tokenIds.increment();

    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

	emit NewEpicNFTMinted(msg.sender, newItemId);
  }
}