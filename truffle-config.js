
//1. Initialize `truffle-hdwallet-provider`
const HDWalletProvider = require("truffle-hdwallet-provider");

// Set your own mnemonic here
const mnemonic = "beauty measure demise media tribe mesh deputy kit confirm replace theory start";

// Module exports to make this configuration available to Truffle itself
module.exports = {
  // Object with configuration for each network
  networks: {
    // Configuration for mainnet
    mainnet: {
      provider: function () {
        // Setting the provider with the Infura Mainnet address and Token
        return new HDWalletProvider(mnemonic, "https://mainnet.infura.io/v3/1d37b9d398af4b81baca54ea5f164f17")
      },
      network_id: "1"
    },
    // Configuration for rinkeby network
    goerli: {
      // Special function to setup the provider
      provider: function () {
        // Setting the provider with the Infura Rinkeby address and Token
        return new HDWalletProvider(mnemonic, "https://goerli.infura.io/v3/1d37b9d398af4b81baca54ea5f164f17")
      },

      network_id: 5 //Fill in the `network_id` for the Rinkeby network.
    },
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*"
    }
  },
  
  compilers: {
    solc: {
      version: "0.8.13",      
    }
  },
};