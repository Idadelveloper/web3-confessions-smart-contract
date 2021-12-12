const main = async() => {
    const confessContractFactory = await hre.ethers.getContractFactory('Confess');
    const confessContract = await confessContractFactory.deploy({
        value: hre.ethers.utils.parseEther('0.001'),
    });

    await confessContract.deployed();

    console.log('Confess address: ', confessContract.address);
};

const runMain = async() => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.error(error);
        process.exit(1);
    }
};

runMain();