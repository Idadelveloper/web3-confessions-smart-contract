const main = async() => {
    const confessContractFactory = await hre.ethers.getContractFactory('Confess');
    const confessContract = await confessContractFactory.deploy({
        value: hre.ethers.utils.parseEther('0.1'),
    });
    await confessContract.deployed();
    console.log('Contract addy:', confessContract.address);

    /*
     * Get Contract balance
     */
    let contractBalance = await hre.ethers.provider.getBalance(
        confessContract.address
    );
    console.log(
        'Contract balance:',
        hre.ethers.utils.formatEther(contractBalance)
    );

    /*
     * Send Confession
     */
    let confessTxn = await confessContract.confess('A message!');
    await confessTxn.wait();

    /*
     * Get Contract balance to see what happened!
     */
    contractBalance = await hre.ethers.provider.getBalance(confessContract.address);
    console.log(
        'Contract balance:',
        hre.ethers.utils.formatEther(contractBalance)
    );

    let allConfessions = await confessContract.getAllConfessions();
    console.log(allConfessions);
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