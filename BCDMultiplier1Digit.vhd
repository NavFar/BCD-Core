----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/03/2017 07:24:30 PM
-- Design Name: 
-- Module Name: BCDMultiplier1Digit - Behavioral
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

entity BCDMultiplier1Digit is
     Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
          B : in STD_LOGIC_VECTOR (3 downto 0);
          V : out STD_LOGIC_VECTOR (7 downto 0));
end BCDMultiplier1Digit;

architecture Structural of BCDMultiplier1Digit is
--Half Adder
component HalfAdder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           R : out STD_LOGIC;
           Cout : out STD_LOGIC);
end component;
--Full Adder
component FullAdder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           R : out STD_LOGIC;
           Cout : out STD_LOGIC);
end component;
--Binary Multiplier
component BinaryMultiplier2Bits is
    Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
           B : in STD_LOGIC_VECTOR (1 downto 0);
           R : out STD_LOGIC_VECTOR (3 downto 0));
end component;
Signal Mult0_Out :STD_LOGIC_VECTOR ( 3 downto 0);
Signal Mult1_Out :STD_LOGIC_VECTOR ( 3 downto 0);
Signal Mult2_Out :STD_LOGIC_VECTOR ( 3 downto 0);
Signal Mult3_Out :STD_LOGIC_VECTOR ( 3 downto 0);
Signal Full0_Cout:STD_LOGIC;
Signal Full0_R   :STD_LOGIC;
Signal Full1_Cout:STD_LOGIC;
Signal Full1_R   :STD_LOGIC;
Signal Full2_Cout:STD_LOGIC;
Signal Full2_R   :STD_LOGIC;
Signal Full3_Cout:STD_LOGIC;
Signal Full3_R   :STD_LOGIC;
Signal Full4_Cout:STD_LOGIC;
Signal Full4_R   :STD_LOGIC;
Signal Full5_Cout:STD_LOGIC;
Signal Full5_R   :STD_LOGIC;
Signal Full6_Cout:STD_LOGIC;
Signal Full6_R   :STD_LOGIC;
Signal Full0_A   :STD_LOGIC;
Signal Full0_B   :STD_LOGIC;
Signal Full0_Cin :STD_LOGIC;
Signal Full1_A   :STD_LOGIC;
Signal Full1_B   :STD_LOGIC;
Signal Full1_Cin :STD_LOGIC;
Signal Full2_A   :STD_LOGIC;
Signal Full2_B   :STD_LOGIC;
Signal Full2_Cin :STD_LOGIC;
Signal Full3_A   :STD_LOGIC;
Signal Full3_B   :STD_LOGIC;
Signal Full3_Cin :STD_LOGIC;
Signal Full4_A   :STD_LOGIC;
Signal Full4_B   :STD_LOGIC;
Signal Full4_Cin :STD_LOGIC;
Signal Full5_A   :STD_LOGIC;
Signal Full5_B   :STD_LOGIC;
Signal Full5_Cin :STD_LOGIC;
Signal Full6_A   :STD_LOGIC;
Signal Full6_B   :STD_LOGIC;
Signal Full6_Cin :STD_LOGIC;
Signal Half0_R   :STD_LOGIC;
Signal Half0_C   :STD_LOGIC;
Signal Half1_R   :STD_LOGIC;
Signal Half1_C   :STD_LOGIC;
Signal Half0_A   :STD_LOGIC;
Signal Half0_B   :STD_LOGIC;
Signal Half1_A   :STD_LOGIC;
Signal Half1_B   :STD_LOGIC;
signal R  :STD_LOGIC_VECTOR (7 downto 0);
begin
Mult0: BinaryMultiplier2Bits port map(A(1 downto 0),B(1 downto 0),Mult0_Out);
Mult1: BinaryMultiplier2Bits port map(A(3 downto 2),B(1 downto 0),Mult1_Out);
Mult2: BinaryMultiplier2Bits port map(A(1 downto 0),B(3 downto 2),Mult2_Out);
Mult3: BinaryMultiplier2Bits port map(A(3 downto 2),B(3 downto 2),Mult3_Out);
FA0  : FullAdder  port map(Full0_A,Full0_B,Full0_Cin,Full0_R,Full0_Cout);
FA1  : FullAdder  port map(Full1_A,Full1_B,Full1_Cin,Full1_R,Full1_Cout);
FA2  : FullAdder  port map(Full2_A,Full2_B,Full2_Cin,Full2_R,Full2_Cout);
FA3  : FullAdder  port map(Full3_A,Full3_B,Full3_Cin,Full3_R,Full3_Cout);
FA4  : FullAdder  port map(Full4_A,Full4_B,Full4_Cin,Full4_R,Full4_Cout);
FA5  : FullAdder  port map(Full5_A,Full5_B,Full5_Cin,Full5_R,Full5_Cout);
FA6  : FullAdder  port map(Full6_A,Full6_B,Full6_Cin,Full6_R,Full6_Cout);
HA0  : HalfAdder  port map(Half0_A,Half0_B,Half0_R,Half0_C);
HA1  : HalfAdder  port map(Half1_A,Half1_B,Half1_R,Half1_C);

R(0)<=Mult0_Out(0);
R(1)<=Mult0_Out(1);
Full0_Cin<=Mult0_Out(2);
Full0_B  <=Mult1_Out(0);
Full0_A  <=Mult2_Out(0);
R(2)<=Full0_R;
Half0_A<=Full1_R;
Half0_B<=Full0_Cout;
R(3)<=Half0_R;
Full2_Cin<=Half0_C;
Full1_A<=Mult2_Out(1);
Full1_B<=Mult1_Out(1);
Full1_Cin<=Mult0_Out(3);
Full3_Cin<=Full1_Cout;
Full2_A<=Mult3_Out(0);
Full2_B<=Full3_R;
R(4)<=Full2_R;
Full5_Cin<=Full2_Cout;
Full3_A<=Mult2_Out(2);
Full3_B<=Mult1_Out(2);
Full4_Cin<=Full3_Cout;
Full4_A<=Mult2_Out(3);
Full4_B<=Mult1_Out(3);
Full5_B<=Full4_R;
Full6_Cin<=Full4_Cout;
Full5_A<=Mult3_Out(1);
Full6_B<=Full5_Cout;
R(5)<=Full5_R;
Full6_A<=Mult3_Out(2);
R(6)<=Full6_R;
Half1_B<=Full6_Cout;
Half1_A<=Mult3_Out(3);
R(7)<=Half1_R;


with R select
    V<=
    "00000000" when "00000000",
    "00000001" when "00000001",
    "00000010" when "00000010",
    "00000011" when "00000011",
    "00000100" when "00000100",
    "00000101" when "00000101",
    "00000110" when "00000110",
    "00000111" when "00000111",
    "00001000" when "00001000",
    "00001001" when "00001001",
    "00010000" when "00001010",
    "00010001" when "00001011",
    "00010010" when "00001100",
    "00010011" when "00001101",
    "00010100" when "00001110",
    "00010101" when "00001111",
    "00010110" when "00010000",
    "00010111" when "00010001",
    "00011000" when "00010010",
    "00011001" when "00010011",
    "00100000" when "00010100",
    "00100001" when "00010101",
    "00100010" when "00010110",
    "00100011" when "00010111",
    "00100100" when "00011000",
    "00100101" when "00011001",
    "00100110" when "00011010",
    "00100111" when "00011011",
    "00101000" when "00011100",
    "00101001" when "00011101",
    "00110000" when "00011110",
    "00110001" when "00011111",
    "00110010" when "00100000",
    "00110011" when "00100001",
    "00110100" when "00100010",
    "00110101" when "00100011",
    "00110110" when "00100100",
    "00110111" when "00100101",
    "00111000" when "00100110",
    "00111001" when "00100111",
    "01000000" when "00101000",
    "01000001" when "00101001",
    "01000010" when "00101010",
    "01000011" when "00101011",
    "01000100" when "00101100",
    "01000101" when "00101101",
    "01000110" when "00101110",
    "01000111" when "00101111",
    "01001000" when "00110000",
    "01001001" when "00110001",
    "01010000" when "00110010",
    "01010001" when "00110011",
    "01010010" when "00110100",
    "01010011" when "00110101",
    "01010100" when "00110110",
    "01010101" when "00110111",
    "01010110" when "00111000",
    "01010111" when "00111001",
    "01011000" when "00111010",
    "01011001" when "00111011",
    "01100000" when "00111100",
    "01100001" when "00111101",
    "01100010" when "00111110",
    "01100011" when "00111111",
    "01100100" when "01000000",
    "01100101" when "01000001",
    "01100110" when "01000010",
    "01100111" when "01000011",
    "01101000" when "01000100",
    "01101001" when "01000101",
    "01110000" when "01000110",
    "01110001" when "01000111",
    "01110010" when "01001000",
    "01110011" when "01001001",
    "01110100" when "01001010",
    "01110101" when "01001011",
    "01110110" when "01001100",
    "01110111" when "01001101",
    "01111000" when "01001110",
    "01111001" when "01001111",
    "10000000" when "01010000",
    "10000001" when "01010001",
    "10000010" when "01010010",
    "10000011" when "01010011",
    "10000100" when "01010100",
    "10000101" when "01010101",
    "10000110" when "01010110",
    "10000111" when "01010111",
    "10001000" when "01011000",
    "10001001" when "01011001",
    "10010000" when "01011010",
    "10010001" when "01011011",
    "10010010" when "01011100",
    "10010011" when "01011101",
    "10010100" when "01011110",
    "10010101" when "01011111",
    "10010110" when "01100000",
    "10010111" when "01100001",
    "10011000" when "01100010",
    "10011001" when "01100011",
    "00000000" when others;
    
    
    

end Structural;
