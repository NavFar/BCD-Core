----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/03/2017 08:35:14 PM
-- Design Name: 
-- Module Name: BCDMultiplierSemiGeneric - Behavioral
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

entity BCDMultiplierSemiGeneric is
    generic(N :in integer);
    Port   (A :in STD_LOGIC_VECTOR(4*N-1 DOWNTO 0);
            B :in STD_LOGIC_VECTOR(3 DOWNTO 0);
            R :out STD_LOGIC_VECTOR(4*N+3 DOWNTO 0));
end BCDMultiplierSemiGeneric;

architecture Behavioral of BCDMultiplierSemiGeneric is

--Adder
component BCDAdderGeneric is
    generic(N : in integer);
    Port   (A : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            B : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            Cin : in STD_LOGIC;
            R : out STD_LOGIC_VECTOR(4*N-1 downto 0);
            Cout : out STD_LOGIC);
end component;

--Multiplier
component BCDMultiplier1Digit is
     Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
            B : in STD_LOGIC_VECTOR (3 downto 0);
            V : out STD_LOGIC_VECTOR (7 downto 0));
end component;

subtype MultResultRow_t is STD_LOGIC_VECTOR(4*N+3 DOWNTO 0) ;
type MultResult_t is array(N-1 downto 0) of MultResultRow_t;

signal MultResult : MultResult_t:=(others=>(others=>'0'));
signal AddResult  : MultResult_t:=(others=>(others=>'0'));
signal zero       : STD_LOGIC_VECTOR(4*N+3 DOWNTO 0):=(others=>'0') ;
signal couts      : std_logic_vector(N-1 downto 0):=(others=>'0');
begin

Multiplier0:BCDMultiplier1Digit port map(A(3 downto 0),B(3 downto 0),MultResult(0)(7 downto 0));

MultiplierLoop:for I in 1 to n-1 generate
        MultiplierI:BCDMultiplier1Digit port map(A(4*i+3 downto 4*i),B(3 downto 0),MultResult(i)(4*i+7 downto 4*i));  
end generate MultiplierLoop;

Adder0: BCDAdderGeneric generic map(n+1) port map(zero,MultResult(0),'0',addResult(0),couts(0));

AdderLoop: for I in 1 to n-1 generate
        AdderI:BCDAdderGeneric generic map(n+1) port map(addResult(i-1),MultResult(i),couts(i-1),addResult(i),couts(i));
end generate  AdderLoop;
R<=AddResult(N-1);
end Behavioral;
