----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/06/2017 05:42:27 AM
-- Design Name: 
-- Module Name: TestBench_BCDSquareRooterGeneric - Behavioral
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

entity TestBench_BCDSquareRooterGeneric is
--  Port ( );
end TestBench_BCDSquareRooterGeneric;

architecture Behavioral of TestBench_BCDSquareRooterGeneric is

component BCDSquareRooterGeneric is
    generic (N : in integer;
             Z : in integer);
    Port    (CLK : in STD_LOGIC;
             Enable   : in STD_LOGIC;
             A : in STD_LOGIC_VECTOR(4*n-1 downto 0);
             P : in STD_LOGIC_VECTOR(7 downto 0);
             R : out STD_LOGIC_VECTOR(4*n-1 downto 0);
             flag : buffer STD_LOGIC:='0';
             F : out STD_LOGIC_VECTOR(4*z-1 downto 0));
end component;

constant N : integer:=4;
constant Z : integer:=5;
signal CLK :  STD_LOGIC:='0';
signal enable : STD_LOGIC:='1';
signal A : STD_LOGIC_VECTOR(4*n-1 downto 0);
signal P  : STD_LOGIC_VECTOR(7 downto 0);
signal R : STD_LOGIC_VECTOR(4*n-1 downto 0);
signal Flag     :STD_LOGIC;
signal F : STD_LOGIC_VECTOR(4*z-1 downto 0);
begin

squareRooter: BCDSquareRooterGeneric generic map(N,Z) port map(CLK,enable,A,P,R,flag,F);

A <= "0001000000100100";
P <= "00000011";

CLK<= not CLK after  10ns; 

end Behavioral;