let RobotGame = artifacts.require("./robotgame/App.sol");
module.exports = function(deployer) {
  deployer.deploy(RobotGame);
};