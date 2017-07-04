----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/04/2017 10:35:10 AM
-- Design Name: 
-- Module Name: TestBench_Exponent - Behavioral
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

entity TestBench_Exponent is
--  Port ( );
end TestBench_Exponent;

architecture Behavioral of TestBench_Exponent is
component Exponent is
    generic (N : integer);
    Port ( CLK : in STD_LOGIC;
           enable : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (4*n-1 downto 0);
           P : in STD_LOGIC_VECTOR (7 downto 0);
           Flag:buffer STD_LOGIC:='0';
           R : out STD_LOGIC_VECTOR (4*n-1 downto 0));
end component;

constant N : integer:=9;
signal CLK :  STD_LOGIC:='0';
signal enable :  STD_LOGIC:='1';
signal A :  STD_LOGIC_VECTOR (4*n-1 downto 0);
signal P :  STD_LOGIC_VECTOR (7 downto 0);
signal Flag: STD_LOGIC:='0';
signal R :  STD_LOGIC_VECTOR (4*n-1 downto 0);
begin

exponent_ins : Exponent generic map(N) port map(CLK,enable,A,P,Flag,R);
--9^6
--8^6
--0^9
--15^3
--9500^1
A <= "000000000000000000000000000000001001"  after 0ns,"000000000000000000000000000000001000"  after 400ns,"000000000000000000000000000000000000"  after 800ns,"000000000000000000000000000000010101"  after 1200ns,"000000000000000000001001010100000000"  after 1600ns;
P <= "00000110" after 0ns                             ,"00000110" after 400ns                             ,"00001001" after 800ns                             , "00000011" after 1200ns                            ,"00000001" after 1600ns;


CLK<= not CLK after  10ns; 
end Behavioral;
