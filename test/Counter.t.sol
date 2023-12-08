// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";
import {Strings} from "../src/Strings.sol";

contract CounterTest is Test {
    using Strings for uint256;
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }
    function testIncrementByInputFFIFuzz(uint256 inc) public {
        // run go script with same state that the solidity function will run
        uint256 goAns = ffiGo(counter.number(), inc);
        counter.incrementByInput(inc);
        assertEq(counter.number(), goAns);
        // to compare a difference (var1, var2, expected difference)
        assertApproxEqAbs(counter.number(), goAns, 0);
    }

    function ffiGo(uint256 number, uint256 inc) private returns (uint256) {
        // compile a string input that represents the console script to run the go script
        // increment the number in brackets when adding more input params
        // input 2 should be the location of the go script
        string[] memory inputs = new string[](5);
        inputs[0] = "go";
        inputs[1] = "run";
        inputs[2] = "go-scripts/Counter.go";
        inputs[3] = uint256(number).toString();
        inputs[4] = uint256(inc).toString();
        // use foundry ffi to run the go script
        bytes memory res = vm.ffi(inputs);
        // decode the result
        uint256 ans = abi.decode(res, (uint256));
        return ans;
    }
}
