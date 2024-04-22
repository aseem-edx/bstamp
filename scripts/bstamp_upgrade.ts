import { ethers, upgrades } from "hardhat";

const { BSTAMP_ADDRESS } = process.env;

async function main() {
  const BStamp = await ethers.getContractFactory("BSTAMP");
  const bStamp = await upgrades.upgradeProxy(BSTAMP_ADDRESS!, BStamp);
  console.log("BStamp Updated");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
