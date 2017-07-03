----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/03/2017 07:21:00 PM
-- Design Name: 
-- Module Name: BinaryMultiplier2Bits - Behavioral
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

entity BinaryMultiplier2Bits is
    Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
           B : in STD_LOGIC_VECTOR (1 downto 0);
           R : out STD_LOGIC_VECTOR (3 downto 0));
    end BinaryMultiplier2Bits;
architecture Structural of BinaryMultiplier2Bits is

begin

R(0)<=A(0) and B(0);
R(1)<=(A(1) and B(0) and not B(1))or(A(1) and not A(0) and B(0))or(A(0) and B(1) and not B(0))or(not A(1) and A(0) and B(1));
R(2)<=(A(1) and not A(0) and B(1))or(A(1) and B(1) and not B(0));
R(3)<=A(1) and A(0) and B(1) and B(0);

end Structural;
