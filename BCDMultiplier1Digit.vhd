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

V(0)<=Mult0_Out(0);
V(1)<=Mult0_Out(1);
Full0_Cin<=Mult0_Out(2);
Full0_B  <=Mult1_Out(0);
Full0_A  <=Mult2_Out(0);
V(2)<=Full0_R;
Half0_A<=Full1_R;
Half0_B<=Full0_Cout;
V(3)<=Half0_R;
Full2_Cin<=Half0_C;
Full1_A<=Mult2_Out(1);
Full1_B<=Mult1_Out(1);
Full1_Cin<=Mult0_Out(3);
Full3_Cin<=Full1_Cout;
Full2_A<=Mult3_Out(0);
Full2_B<=Full3_R;
V(4)<=Full2_R;
Full5_Cin<=Full2_Cout;
Full3_A<=Mult2_Out(2);
Full3_B<=Mult1_Out(2);
Full4_Cin<=Full3_Cout;
Full4_A<=Mult2_Out(3);
Full4_B<=Mult1_Out(3);
Full5_B<=Full4_R;
Full6_Cin<=Full4_Cout;
Full5_A<=Mult3_Out(1);
Full6_B<=Full5_Cin;
V(5)<=Full5_R;
Full6_A<=Mult3_Out(2);
V(6)<=Full6_R;
Half1_B<=Full6_Cout;
Half1_A<=Mult3_Out(3);
V(7)<=Half1_R;



end Structural;
