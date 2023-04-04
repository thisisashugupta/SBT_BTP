/** @type import('hardhat/config').HardhatUserConfig */

require("dotenv").config();

require("@nomiclabs/hardhat-ethers");

const { API_URL, PRIVATE_KEY } = process.env;

module.exports = {
  solidity: "0.8.18",
  networks: {
    hardhat: {},
    goerli: {
      url: API_URL, // How I am gonna talk to ethereum blockchain
      accounts: [`0x${PRIVATE_KEY}`], // who I am
    },
  },

  // API KEY of alchemy
  // wallet password
};
