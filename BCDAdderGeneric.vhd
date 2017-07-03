----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/03/2017 07:54:06 PM
-- Design Name: 
-- Module Name: BCDAdderGeneric - Behavioral
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

entity BCDAdderGeneric is
    generic(N : in integer);
    Port   (A : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            B : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            Cin : in STD_LOGIC;
            R : out STD_LOGIC_VECTOR(4*N-1 downto 0);
            Cout : out STD_LOGIC);
end BCDAdderGeneric;

architecture Behavioral of BCDAdderGeneric is

component BCDFullAdder1Digit is
Port (     A : in STD_LOGIC_VECTOR(3 DOWNTO 0);
           B : in STD_LOGIC_VECTOR(3 DOWNTO 0);
           CIN : IN STD_LOGIC;
           COUT :out std_logic;
           RESULT: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
end component;


Signal couts : STD_LOGIC_VECTOR(N-1 downto 0);

begin
BCDFullAdder0: BCDFullAdder1Digit port map(A(3 downto 0),B(3 downto 0),cin,couts(0),R(3 downto 0));

rippleAdder:for i in 1 to n-1 generate
                BCDFullAdderI: BCDFullAdder1Digit port map(A(4*i+3 downto 4*i),B(4*i+3 downto 4*i),couts(i-1),couts(i),R(4*i+3 downto 4*i));

            end  generate rippleAdder;
cout<=couts(N-1);
end Behavioral;
