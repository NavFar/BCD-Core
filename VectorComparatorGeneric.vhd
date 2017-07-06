----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/06/2017 01:02:52 AM
-- Design Name: 
-- Module Name: VectorComparatorGeneric - Behavioral
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

entity VectorComparatorGeneric is
    Generic(N : in integer);
    Port ( A : in STD_LOGIC_VECTOR (N-1 downto 0);
           B : in STD_LOGIC_VECTOR (N-1 downto 0);
           Equal : out STD_LOGIC);
end VectorComparatorGeneric;

architecture Behavioral of VectorComparatorGeneric is

signal allXors : STD_LOGIC_VECTOR(n-1 downto 0);
signal allOrs  : STD_LOGIC_VECTOR(n-1 downto 0);
begin

xorLoop:for I in 0 to n-1 generate
        allXors(i)<=A(i) xor B(i);
end generate xorLoop;

allOrs(0)<=AllXors(0);

orLoop :for I in 1 to n-1 generate
        allOrs (i)<=allOrs(i-1) OR allXors(i);
end generate orLoop;
Equal<=not allOrs(n-1);
end Behavioral;
