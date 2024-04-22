import { ethers, upgrades } from "hardhat";

async function main() {
  const BStamp = await ethers.getContractFactory("BSTAMP");
  const bStamp = await upgrades.deployProxy(BStamp);
  await bStamp.waitForDeployment();

  console.log("BStamp Address:", bStamp.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
