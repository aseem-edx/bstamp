import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@openzeppelin/hardhat-upgrades";
import "dotenv/config";

const { NETWORK_URL, ACCOUNT_PRIVATE } = process.env;

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    rpc: {
      accounts: [ACCOUNT_PRIVATE!],
      url: NETWORK_URL,
      gasPrice: 21000,
    },
  },
};

export default config;
