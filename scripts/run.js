const main = async() => {
    const confessContractFactory = await hre.ethers.getContractFactory('Confess');
    const confessContract = await confessContractFactory.deploy();
    await confessContract.deployed();
    console.log("Contract deployed to:", confessContract.address);
};

const runMain = async() => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();