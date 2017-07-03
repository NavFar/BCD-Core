----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/03/2017 07:48:18 PM
-- Design Name: 
-- Module Name: BCDFullAdder1Digit - Behavioral
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

entity BCDFullAdder1Digit is
Port (     A : in STD_LOGIC_VECTOR(3 DOWNTO 0);
           B : in STD_LOGIC_VECTOR(3 DOWNTO 0);
           CIN : IN STD_LOGIC;
           COUT :out std_logic;
           RESULT: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
end BCDFullAdder1Digit;

architecture Behavioral of BCDFullAdder1Digit is

component FullAdder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           R : out STD_LOGIC;
           Cout : out STD_LOGIC);
end component;
SIGNAL couts:std_logic_vector(3 downto 0);
signal temp:STD_LOGIC_VECTOR(3 DOWNTO 0);
signal temp2:STD_LOGIC_VECTOR(3 DOWNTO 0);
signal coutSig:std_logic;
begin

fullAdder0: FullAdder port map(A(0),B(0),cin,temp(0),couts(0));
fullAdder1: FullAdder port map(A(1),B(1),couts(0),temp(1),couts(1));                                                                
fullAdder2: FullAdder port map(A(2),B(2),couts(1),temp(2),couts(2));
fullAdder3: FullAdder port map(A(3),B(3),couts(2),temp(3),couts(3));

coutSig<=couts(3) or (temp(3) and temp(2)) or (temp(3) and temp(1));

fullAdder4: FullAdder port map(coutSig,temp(1),'0',temp2(0),temp2(1));
fullAdder5: FullAdder port map(coutSig,temp(2),temp2(1),temp2(2),temp2(3));

Result(0)<=temp(0);
Result(1)<=temp2(0);
Result(2)<=temp2(2);
Result(3)<=temp(3) xor temp2(3);
COUT<=COUTSIG;


end Behavioral;
