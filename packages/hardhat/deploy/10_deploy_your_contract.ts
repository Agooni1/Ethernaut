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

  // const DexInstance = await deploy("DexTwo", {
  //   from: deployer,
  //   // Contract constructor arguments
  //   args: ["0xdFAcd1aBC73C82Fd55edD35B933F7D9cd04E6470"],
  //   log: true,
  //   // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
  //   // automatically mining the contract deployment transaction. There is no effect on live networks.
  //   autoMine: true,
  // });


  //   // Deploy token1
  //   const token1Deployment = await deploy("Token1", {
  //     contract: "SwappableTokenTwo",
  //     from: deployer,
  //     args: [DexInstance.address, "Token1", "TK1"],
  //     log: true,
  //     autoMine: true,
  //   });


  //   // Deploy token2
  //   const token2Deployment = await deploy("Token2", {
  //     contract: "SwappableTokenTwo",
  //     from: deployer,
  //     args: [DexInstance.address, "Token2", "TK2"],
  //     log: true,
  //     autoMine: true,
  //   });

  const dexattacker = await deploy("DexTwoAttacker", {
    from: deployer,
    // Contract constructor arguments
    // args: ["0xdFAcd1aBC73C82Fd55edD35B933F7D9cd04E6470", DexInstance.address, token1Deployment.address, token2Deployment.address],
    args: [deployer, "0x6a79bB2A6ceC5035Fb6d0b68A4A9671AA1C31671", "0x409EEc0133B731cC5f039164b32B093F73A72587", "0xe71c20Ce828Fa3E23922CEe51062b0C2a9708902"],
    // args: ["0xdFAcd1aBC73C82Fd55edD35B933F7D9cd04E6470", "0x5FbDB2315678afecb367f032d93F642f64180aa3"],
    log: true,
    // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
    // automatically mining the contract deployment transaction. There is no effect on live networks.
    autoMine: true,
  });

  const fakeToken = await deploy("FakeToken", {
    contract: "FakeToken",
    from: deployer,
    args: [dexattacker.address],
    log: true,
    autoMine: true,
  });

    

  // Get the deployed contract to interact with it after deploying.
  // const yourContract = await hre.ethers.getContract<Contract>("CoinFlip", deployer);
  // console.log("👋 Initial greeting:", await yourContract.greeting());
};

export default deployYourContract;

// Tags are useful if you have multiple deploy files and only want to run one of them.
// e.g. yarn deploy --tags YourContract
// deployYourContract.tags = ["GatekeeperOne"];
deployYourContract.tags = ["Dex"];
