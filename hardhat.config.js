require("@nomiclabs/hardhat-waffle");
require('dotenv').config();


module.exports = {
  solidity: "0.8.0",
  networks: {
    rinkeby: {
      url: process.env.STAGING_ALCHEMY_API,
      accounts: [process.env.PRIVATE_KEY_RINKEBY],
    },
	mumbai: {
		url: process.env.MUMBAI_ALCHEMY_API,
		accounts: [process.env.PRIVATE_KEY_MUMBAI],
	},
	polygonmain: {
		url: process.env.POLYGON_M_ALCHEMY_API,
		accounts: [process.env.POLYGON_M_PRIVATE_KEY],
	},
  },
};


