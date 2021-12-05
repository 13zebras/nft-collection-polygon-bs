// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract TRANSMyEpicNFT is ERC721URIStorage {
  // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  // We need to pass the name of our NFTs token and it's symbol.
  constructor() ERC721 ("transnowNFT", "TRANSRN") {
    console.log("--> NFTs are bodacious! Fucking eh, bubba! END");
  }
// A function our user will hit to get their NFT.
  function makeAnEpicNFT() public {
     // Get the current tokenId, this starts at 0.
    uint256 newItemId = _tokenIds.current();

     // Actually mint the NFT to the sender using msg.sender.
    _safeMint(msg.sender, newItemId);

    // Set the NFTs data.
    _setTokenURI(newItemId, "data:application/json;base64,ewogICJuYW1lIjogIlRyYW5zUmlnaHRzTm93IiwKICAiZGVzY3JpcHRpb24iOiAiQW4gTkZUIHN1cHBvcnRpbmcgVHJhbnMgUmlndGhzIGFuZCBhbGwgTEdCVFErIHJpZ2h0cyEiLAogICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJR2hsYVdkb2REMGlNelV3SWlCM2FXUjBhRDBpTXpVd0lqNEtJQ0E4WkdWbWN6NEtJQ0FnSUR4c2FXNWxZWEpIY21Ga2FXVnVkQ0JwWkQwaVozSmhaREVpSUhneFBTSXdKU0lnZVRFOUlqQWxJaUI0TWowaU1DVWlJSGt5UFNJeE1EQWxJajRLSUNBZ0lDQWdQSE4wYjNBZ2IyWm1jMlYwUFNJd0pTSWdjM1I1YkdVOUluTjBiM0F0WTI5c2IzSTZjbWRpS0RJMU5Td3hOVEFzTVRnd0tUdHpkRzl3TFc5d1lXTnBkSGs2TVNJZ0x6NEtJQ0FnSUNBZ1BITjBiM0FnYjJabWMyVjBQU0l4TlNVaUlITjBlV3hsUFNKemRHOXdMV052Ykc5eU9uSm5ZaWd5TlRVc01UWXdMREl3TUNrN2MzUnZjQzF2Y0dGamFYUjVPakVpSUM4K0NpQWdJQ0FnSUR4emRHOXdJRzltWm5ObGREMGlORElsSWlCemRIbHNaVDBpYzNSdmNDMWpiMnh2Y2pweVoySW9NalUxTERJMU5Td3lOVFVwTzNOMGIzQXRiM0JoWTJsMGVUb3hJaUF2UGdvZ0lDQWdJQ0E4YzNSdmNDQnZabVp6WlhROUlqVTRKU0lnYzNSNWJHVTlJbk4wYjNBdFkyOXNiM0k2Y21kaUtESTFOU3d5TlRVc01qVTFLVHR6ZEc5d0xXOXdZV05wZEhrNk1TSWdMejRLSUNBZ0lDQWdQSE4wYjNBZ2IyWm1jMlYwUFNJNE5TVWlJSE4wZVd4bFBTSnpkRzl3TFdOdmJHOXlPbkpuWWlneE5UQXNNakF3TERJMU5TazdjM1J2Y0MxdmNHRmphWFI1T2pFaUlDOCtDaUFnSUNBZ0lEeHpkRzl3SUc5bVpuTmxkRDBpTVRBd0pTSWdjM1I1YkdVOUluTjBiM0F0WTI5c2IzSTZjbWRpS0RFMU1Dd3lNREFzTWpVMUtUdHpkRzl3TFc5d1lXTnBkSGs2TVNJZ0x6NEtJQ0FnSUR3dmJHbHVaV0Z5UjNKaFpHbGxiblErQ2lBZ1BDOWtaV1p6UGdvZ0lEeHpkSGxzWlQ0dWRHVjRkREVnZXlCbWFXeHNPaUFqTURBd01EQXdPeUJtYjI1MExXWmhiV2xzZVRvZ2JXOXViM053WVdObE95Qm1iMjUwTFhOcGVtVTZJRE13Y0hnN0lIMDhMM04wZVd4bFBnb2dJRHh5WldOMElHaGxhV2RvZEQwaU1UQXdKU0lnZDJsa2RHZzlJakV3TUNVaUlHWnBiR3c5SW5WeWJDZ2paM0poWkRFcElpQnpkSEp2YTJVOUltSnNZV05ySWlCemRISnZhMlV0ZDJsa2RHZzlJamdpSUM4K0NpQWdQSFJsZUhRZ2VEMGlOVEFsSWlCNVBTSTFNQ1VpSUdOc1lYTnpQU0owWlhoME1TSWdaRzl0YVc1aGJuUXRZbUZ6Wld4cGJtVTlJbTFwWkdSc1pTSWdkR1Y0ZEMxaGJtTm9iM0k5SW0xcFpHUnNaU0krVkhKaGJuTlNhV2RvZEhOT2IzYzhMM1JsZUhRK0Nqd3ZjM1puUGc9PSIKfQ==");

    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

    // Increment the counter for when the next NFT is minted.
    _tokenIds.increment();
  }
}