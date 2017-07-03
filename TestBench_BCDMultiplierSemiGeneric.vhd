----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/03/2017 09:13:19 PM
-- Design Name: 
-- Module Name: TestBench_BCDMultiplierSemiGeneric - Behavioral
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

entity TestBench_BCDMultiplierSemiGeneric is
--  Port ( );
end TestBench_BCDMultiplierSemiGeneric;

architecture Behavioral of TestBench_BCDMultiplierSemiGeneric is

component BCDMultiplierSemiGeneric is
    generic(N :in integer);
    Port   (A :in STD_LOGIC_VECTOR(4*N-1 DOWNTO 0);
            B :in STD_LOGIC_VECTOR(3 DOWNTO 0);
            R :out STD_LOGIC_VECTOR(4*N+3 DOWNTO 0));
end component;


constant N :integer:=9;
signal A : STD_LOGIC_VECTOR(4*N-1 downto 0);
signal B : STD_LOGIC_VECTOR(3 downto 0);
signal R : STD_LOGIC_VECTOR(4*N+3 downto 0);


begin
BCDMultiplierSemiGeneric_ins: BCDMultiplierSemiGeneric generic map(N) port map(A,B,R);

--123456789*0
--753412841*9
--148963752*1
--778898921*7
--945778613*5

A <= "000100100011010001010110011110001001" after 0 ns , "011101010011010000010010100001000001" after 10 ns , "000101001000100101100011011101010010" after 20 ns , "011101111000100010011000100100100001" after 30 ns, "100101000101011101111000011000010011" after 40 ns;
B <= "0000" after 0 ns                                 , "1001" after 10 ns                                 , "0001" after 20 ns                                 , "0111" after 30 ns                                , "0101" after 40 ns;


end Behavioral;
