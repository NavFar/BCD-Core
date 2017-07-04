----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/04/2017 01:01:15 PM
-- Design Name: 
-- Module Name: TestBench_SubtractorGeneric - Behavioral
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

entity TestBench_SubtractorGeneric is
--  Port ( );
end TestBench_SubtractorGeneric;

architecture Behavioral of TestBench_SubtractorGeneric is

component BCDSubtractorGeneric is
    generic(N : in integer);
    Port   (A : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            B : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            Bin : in STD_LOGIC;
            R : out STD_LOGIC_VECTOR(4*N-1 downto 0);
            Bout : out STD_LOGIC);
end  component ;

constant N :integer:=9;
signal A : STD_LOGIC_VECTOR(4*N-1 downto 0);
signal B : STD_LOGIC_VECTOR(4*N-1 downto 0);
signal R : STD_LOGIC_VECTOR(4*N-1 downto 0);
signal bout:STD_LOGIC;

begin

bcdAdder: BCDSubtractorGeneric generic map(N) port map(A,B,'1',R,bout);

--123456789-456789123
--753412841-994127825
--148963752-114877932
--778898921-775448935
--945778613-479532149

A <= "000100100011010001010110011110001001" after 0 ns , "011101010011010000010010100001000001" after 10 ns , "000101001000100101100011011101010010" after 20 ns , "011101111000100010011000100100100001" after 30 ns, "100101000101011101111000011000010011" after 40 ns;
B <= "010001010110011110001001000100100011" after 0 ns , "100110010100000100100111100000100101" after 10 ns , "000100010100100001110111100100110010" after 20 ns , "011101110101010001001000100100110101" after 30 ns, "010001111001010100110010000101001001" after 40 ns;


end Behavioral;
