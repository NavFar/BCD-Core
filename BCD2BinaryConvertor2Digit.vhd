----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/04/2017 12:26:56 AM
-- Design Name: 
-- Module Name: BCD2BinaryConvertor2Digit - Behavioral
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
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BCD2BinaryConvertor2Digit is
    Port ( BCD : in STD_LOGIC_VECTOR (7 downto 0);
           Binary : out STD_LOGIC_VECTOR (7 downto 0));
end BCD2BinaryConvertor2Digit;

architecture Behavioral of BCD2BinaryConvertor2Digit is

begin
        Binary<=((BCD(3 downto 0) * "01") + (BCD(7 downto 4) * "1010"));


end Behavioral;
