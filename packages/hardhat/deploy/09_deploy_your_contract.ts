import { DeployFunction } from "hardhat-deploy/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { ethers } from "hardhat";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployer } = await hre.getNamedAccounts();
  const signer = await ethers.getSigner(deployer);

  // Constructor code that returns the 10-byte runtime code: 602a60005260206000f3
  const constructorBytecode = "0x69602a60005260206000f3600052600a6016f3";

  // Deploy using raw transaction
  const tx = await signer.sendTransaction({
    from: deployer,
    data: constructorBytecode,
  });

  const receipt = await tx.wait();
  console.log("Solver deployed to:", receipt?.contractAddress);
};

export default func;
func.tags = ["Solver"];
