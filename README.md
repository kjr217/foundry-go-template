# Foundry <> Go Differential Fuzz Testing reference implementation

This template provides a reference implementation for creating foundry tests that compare solidity code to an implementation of the same code in Golang. It does this by taking advantage of [foundry ffi](https://book.getfoundry.sh/forge/differential-ffi-testing?highlight=ffi#primer-the-ffi-cheatcode) and foundry's inbuilt fuzz tooling. Being able to compare golang code against solidity code for correctness and differential analysis helps improve the security of solidity development and helps understand the limits of the EVM when it comes to developing models to be used on the EVM.

[TODO] - speed up the implementation, have a few ideas that am playing around with privately like running a big array instead of individual fuzzes, keeping the go side up inbetween ffi to avoid the file having to restart every time, if you have any ideas hmu.

Note: this template assumes some familiarity with foundry, golang and forge, if you are not familiar refer to the amazing foundry docs

Example implementations:

- Ciao margining by Rysk - used for comparing on-chain margining functions written in solidity against an off-chain margining function written in go, the functions should always maintain equivalency

## Installation Instructions

1. Make sure you have foundry installed, if you do not then follow the instructions [here](https://book.getfoundry.sh/getting-started/installation)

2. Make sure you have go installed, if you do not then follow the instructions [here](https://go.dev/doc/install).

## Operation Instructions

To run the example test ```Counter.t.sol``` do ```forge test --ffi```. This test fuzzes the function ```incrementByInput(i)``` in ```Counter.sol``` and compares the output against a golang implementation of the same function which can be seen in ```go-scripts/Counter.go```. The test suite ```Counter.t.sol``` uses [foundry ffi](https://book.getfoundry.sh/forge/differential-ffi-testing?highlight=ffi#primer-the-ffi-cheatcode) to run the go script alongside the foundry test. The example of its use can be seen in: ```testIncrementByInputFFIFuzz``` and ```ffiGo``` This allows for comparison between a golang reference implementation of a function and a solidity function.

### How to run tests

```forge test --ffi```

When running the tests you must include the ```--ffi``` in order to run the go-foundry differential fuzz tests.

### How to add more variables to the test

In the reference ```Counter.go``` script follow the instructions in the main function to add more variables.

In the ```ffiGo``` function add in more elements to the ```inputs``` array making sure to include the variable, also increase the array length of inputs to match the new array length. Instructions are provided in ```ffiGo```.

### How to change the targeted python script
Change ```inputs[2]``` in the ```ffiGo``` function to represent the correct file path to the targeted script.
