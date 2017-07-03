----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/03/2017 07:16:28 PM
-- Design Name: 
-- Module Name: HalfAdder - Behavioral
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

entity HalfAdder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           R : out STD_LOGIC;
           Cout : out STD_LOGIC);
end HalfAdder;

architecture Structural of HalfAdder is
begin

R<= A xor B;
Cout<= A and B;


end Structural;
