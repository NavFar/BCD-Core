----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/05/2017 01:46:09 PM
-- Design Name: 
-- Module Name: BCDComplementGeneric - Behavioral
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

entity BCDComplementGeneric is
    generic (N  : in integer);
    Port    (A  : in STD_LOGIC_VECTOR(4*n-1 downto 0);
             AComp : out STD_LOGIC_VECTOR(4*n-1 downto 0));
end BCDComplementGeneric;

architecture Behavioral of BCDComplementGeneric is
 
 --adder
component BCDAdderGeneric is
    generic(N : in integer);
    Port   (A : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            B : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            Cin : in STD_LOGIC;
            R : out STD_LOGIC_VECTOR(4*N-1 downto 0);
            Cout : out STD_LOGIC);
end component;

 --complementor
component BCDComplement is
     Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
            C : out STD_LOGIC_VECTOR (3 downto 0));
 end component;
 
signal ASemiComp:STD_LOGIC_VECTOR(4*N-1 downto 0);
signal zero:STD_LOGIC_VECTOR(4*N-1 downto 0):=(others=>'0');


begin

complement:for i in 0 to n-1 generate
        compI:BCDComplement port map(A(4*i+3 downto 4*i),ASemiComp(4*i+3 downto 4*i));
end generate complement;

adder: BCDAdderGeneric generic map(N) port map(ASemiComp,zero,'1',AComp,open);

end Behavioral;
