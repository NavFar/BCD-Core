----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/07/2017 10:32:11 AM
-- Design Name: 
-- Module Name: TestBench_BCDNormPGeneric - Behavioral
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

entity TestBench_BCDNormPGeneric is
--  Port ( );
end TestBench_BCDNormPGeneric;

architecture Behavioral of TestBench_BCDNormPGeneric is

component BCDNormPGeneric is
    generic (N : in integer;
             Z : in integer);
    Port    (CLK : in STD_LOGIC;
             Enable   : in STD_LOGIC;
             flag : buffer STD_LOGIC:='0';
             A1 : in STD_LOGIC_VECTOR(4*n-1 downto 0);
             A2 : in STD_LOGIC_VECTOR(4*n-1 downto 0);
             A3 : in STD_LOGIC_VECTOR(4*n-1 downto 0);
             A4 : in STD_LOGIC_VECTOR(4*n-1 downto 0);
             A5 : in STD_LOGIC_VECTOR(4*n-1 downto 0);
             P : in STD_LOGIC_VECTOR(7 downto 0);
             R : out STD_LOGIC_VECTOR(4*n-1 downto 0);
             F : out STD_LOGIC_VECTOR(4*z-1 downto 0));
end component;

constant N : integer:=4;
constant Z : integer:=5;
signal CLK :  STD_LOGIC:='0';
signal enable : STD_LOGIC:='1';
signal Flag     :STD_LOGIC:='0';
signal A1 : STD_LOGIC_VECTOR(4*n-1 downto 0);
signal A2 : STD_LOGIC_VECTOR(4*n-1 downto 0);
signal A3 : STD_LOGIC_VECTOR(4*n-1 downto 0);
signal A4 : STD_LOGIC_VECTOR(4*n-1 downto 0);
signal A5 : STD_LOGIC_VECTOR(4*n-1 downto 0);
signal P  : STD_LOGIC_VECTOR(7 downto 0);
signal R : STD_LOGIC_VECTOR(4*n-1 downto 0);
signal F : STD_LOGIC_VECTOR(4*z-1 downto 0);
begin

NormP: BCDNormPGeneric generic map(N,Z) port map(CLK,enable,Flag,A1,A2,A3,A4,A5,P,R,F);

A1 <= "0000000000000001";
A2 <= "0000000000000010";
A3 <= "0000000000000011";
A4 <= "0000000000000100";
A5 <= "0000000000000101";
P <= "00000010";

CLK<= not CLK after  10ns; 

end Behavioral;