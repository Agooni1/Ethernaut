import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { Contract } from "ethers";

/**
 * Deploys a contract named "YourContract" using the deployer account and
 * constructor arguments set to the deployer address
 *
 * @param hre HardhatRuntimeEnvironment object.
 */
const deployYourContract: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  /*
    On localhost, the deployer account is the one that comes with Hardhat, which is already funded.

    When deploying to live networks (e.g `yarn deploy --network sepolia`), the deployer account
    should have sufficient balance to pay for the gas fees for contract creation.

    You can generate a random account with `yarn generate` or `yarn account:import` to import your
    existing PK which will fill DEPLOYER_PRIVATE_KEY_ENCRYPTED in the .env file (then used on hardhat.config.ts)
    You can run the `yarn account` command to check your balance in every network.
  */
  const { deployer } = await hre.getNamedAccounts();
  const { deploy } = hre.deployments;
  // const initsupplyDex = 100;
  // const initsupplyMe = 10;

  // const DexInstance = await deploy("Upgraderaddress3", {
  //   from: deployer,
  //   // Contract constructor arguments
  //   // args: ["0x2968B0d0514c15Fc39880846EF9A3F161BabC61f"],
  //   log: true,
  //   // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
  //   // automatically mining the contract deployment transaction. There is no effect on live networks.
  //   autoMine: true,
  // });


  // const GT3 = await deploy("GatekeeperThree", {
  //     from: deployer,
  //     // args: [deployer, "0x1fb24264DdaeB97f480771bE94E70e46d7CF95dd", "0xae0334ad2D77B3741bD9277db2E56351b4aA5971"],
  //     log: true,
  //     autoMine: true,
  //   });

  //   await deploy("SimpleTrick", {
  //     from: deployer,
  //     args: [GT3.address],
  //     log: true,
  //     autoMine: true,
  //   })

    await deploy("GT3Attack", {
      from: deployer,
      args: [deployer, "0xE8F871b919840A9c3ba82408C74eCcd59A77a1D2"],
      log: true,
      autoMine: true,
    })


  //   // Deploy token2
  //   const token2Deployment = await deploy("Token2", {
  //     contract: "SwappableTokenTwo",
  //     from: deployer,
  //     args: [DexInstance.address, "Token2", "TK2"],
  //     log: true,
  //     autoMine: true,
  //   });


    

  // Get the deployed contract to interact with it after deploying.
  // const yourContract = await hre.ethers.getContract<Contract>("CoinFlip", deployer);
  // console.log("👋 Initial greeting:", await yourContract.greeting());
};

export default deployYourContract;

// Tags are useful if you have multiple deploy files and only want to run one of them.
// e.g. yarn deploy --tags YourContract
// deployYourContract.tags = ["GatekeeperOne"];
deployYourContract.tags = ["Motor"];
