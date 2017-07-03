----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/03/2017 07:30:48 PM
-- Design Name: 
-- Module Name: TestBench_BCDMultiplier1Digit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TestBench_BCDMultiplier1Digit is
--  Port ( );
end TestBench_BCDMultiplier1Digit;

architecture Behavioral of TestBench_BCDMultiplier1Digit is
component BCDMultiplier1Digit is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           V : out STD_LOGIC_VECTOR (7 downto 0));
end component;
Signal A :STD_LOGIC_VECTOR(3 downto 0);
Signal B :STD_LOGIC_VECTOR(3 downto 0);
Signal Result :  STD_LOGIC_VECTOR (7 downto 0);
begin
BCDMult: BCDMultiplier1Digit port map(A,B,Result);

A <= "0010" after 0 ns , "1001" after 10 ns , "0011" after 20 ns , "0101" after 30 ns, "0001" after 40 ns, "0110" after 50 ns, "0010" after 60 ns,"1001" after 70 ns ,"1000" after 80 ns,"0001" after 90 ns;
B <= "0011" after 0 ns , "0101" after 10 ns , "0001" after 20 ns , "0000" after 30 ns, "0010" after 40 ns, "1001" after 50 ns, "0111" after 60 ns,"0001" after 70 ns ,"0100" after 80 ns,"1001" after 90 ns;

end Behavioral;