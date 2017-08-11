#  BCD Core 
**This project is my Design automation course final project**
## Environment
Project is completely (Both simulated and implemented ):
	> Xilinx Vivado HLS.
## Project Structure
Almost every module moduleName has a testBench TestBench_moduleName 
## Project Modules
|FileName      |TestBench|Description|
| ------------------- |:-------------------:| --------------------------------------:|
|HalfAdder.vhd |No TestBench|Implemented Structural|
|FullAdder.vhd |No TestBench|Implemented Structural|
|BinaryMultiplier2Bits.vhd|No TestBench|2 bit binary multiplier based on Full and Half Adder|
|BCD2BinaryConvertor2Digit.vhd|NO TestBench|Converts 2 BCD to Binary|
|VectorComparatorGeneric.vhd|No TestBench|Compare to N digits vector|
|BCDFullAdder1Digit.vhd|No Test Bench|One digit full adder|
|BCDMultiplier1Digit.vhd|TestBench_BCDMultiplier1Digit.vhd|BCD Multiplier|
|BCDAdderGeneric.vhd|TestBench_BCDAdderGeneric.vhd|Generic Ripple adder|
|BCDComplement.vhd|No TestBench|BCD Complement for 1 BCD|
|BCDComplementGeneric.vhd|No TestBench|BCD Complement for n BCD uses BCD Complement|
|BCDSubtractorGeneric.vhd|TestBench_BCDSubtractorGeneric.vhd|Uses adder and complementor to subtract BCDS (not optimum but well defined)|
|BCDMultiplierSemiGeneric.vhd|TestBench_BCDMultiplierSemiGeneric.vhd|Multiply 1 BCD to n BCD |
|BCDMultiplierGeneric.vhd|TestBench_BCDMultiplierGeneric.vhd|Multiply n BCD to n BCD|
|BCDDivderGeneric.vhd|TestBench_BCDDivderGeneric.vhd|BCD divider (doesn't convert to binary instead use BCD rules)|
|BCDExponentGeneric.vhd|TestBench_BCDExponentGeneric.vhd|Calculater n BCD in power of 2 BCD (need log(n) clocks)|
|BCDSquareRooterGeneric.vhd|TestBench_BCDSquareRooterGeneric.vhd|Calculate root of n BCD (root is 2 BCD) can output m BCD as fractional part|
|BCDNormPGeneric.vhd|TestBench_BCDNormPGeneric.vhd|Calculate P norm (p is 2 BCD) of a 5 dimensionals Vector that every dimensional is  n BCD|
## Square Root Formula
![Image of Yaktocat](https://octodex.github.com/images/yaktocat.png)
## Warning
Norm P can't calculate result fractional part Accurate
##Autor
@NavFar

