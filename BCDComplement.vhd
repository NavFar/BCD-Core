----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/04/2017 12:45:20 PM
-- Design Name: 
-- Module Name: BCDComplement - Behavioral
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

entity BCDComplement is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           C : out STD_LOGIC_VECTOR (3 downto 0));
end BCDComplement;

architecture Behavioral of BCDComplement is
begin

    with A select
        C<= 
            "0000" when "1001",
            "0001" when "1000",
            "0010" when "0111",
            "0011" when "0110",
            "0100" when "0101",
            "0101" when "0100",
            "0110" when "0011",
            "0111" when "0010",
            "1000" when "0001",
            "1001" when "0000",
            "0000" when others;


end Behavioral;
