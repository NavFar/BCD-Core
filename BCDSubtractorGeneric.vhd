----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/04/2017 12:53:23 PM
-- Design Name: 
-- Module Name: BCDSubtractorGeneric - Behavioral
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

entity BCDSubtractorGeneric is
    generic(N : in integer);
    Port   (A : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            B : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            Bin : in STD_LOGIC;
            R : out STD_LOGIC_VECTOR(4*N-1 downto 0);
            Bout : out STD_LOGIC);
end BCDSubtractorGeneric;

architecture Behavioral of BCDSubtractorGeneric is

component BCDComplementGeneric is
    generic (N  : in integer);
    Port    (A  : in STD_LOGIC_VECTOR(4*n-1 downto 0);
             AComp : out STD_LOGIC_VECTOR(4*n-1 downto 0));
end component;


component BCDAdderGeneric is
    generic(N : in integer);
    Port   (A : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            B : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            Cin : in STD_LOGIC;
            R : out STD_LOGIC_VECTOR(4*N-1 downto 0);
            Cout : out STD_LOGIC);
end component;
signal BComp:STD_LOGIC_VECTOR(4*N-1 downto 0);


begin

complemet:BCDComplementGeneric generic map(N) port map(B,BComp);
adder: BCDAdderGeneric generic map(N) port map(A,Bcomp,'0',R,Bout);
end Behavioral;
