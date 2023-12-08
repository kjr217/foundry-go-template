package main

import (
	"fmt"
	"math/big"
	"os"

	hexutil "github.com/ethereum/go-ethereum/common/hexutil"
)

func main() {

	// access an argument from the os.Args, starting from index 1 and convert to the 
	// appropriate datatype, repeat for all of your variables
	number := new(big.Int)
    number, ok := number.SetString(os.Args[1], 10)
    if !ok {
        fmt.Println("SetString: error")
        return
    }
	inc := new(big.Int)
    inc, ok = inc.SetString(os.Args[2], 10)
    if !ok {
        fmt.Println("SetString: error")
        return
    }

	// run the function being compared
	ans := increment(number, inc)

	// create a 32 bytes, zero filled version of the answer to dispatch
	buf := make([]byte, 32)
	a := hexutil.Encode(ans.FillBytes(buf))
	// this print is important as it is what the ffi picks up for comparison with solidity, it should be a hex string, 32 bytes
	fmt.Println(a)
}

func increment(number *big.Int, inc *big.Int) (ans big.Int) {
	ans.Add(number, inc)
	return
}