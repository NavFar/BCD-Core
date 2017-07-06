library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TestBench_BCDDivider is
--  Port ( );
end TestBench_BCDDivider;

architecture Behavioral of TestBench_BCDDivider is
component BCDDivderGeneric is
    generic(N : in integer;
            M : in integer);
    Port   (CLK      : in STD_LOGIC;
            Enable   : in STD_LOGIC;
            Dividend : in STD_LOGIC_VECTOR(4*n-1 downto 0);
            Divisor  : in STD_LOGIC_VECTOR(4*m-1 downto 0);
            flag     : buffer STD_LOGIC:='0';
            Remainder  : out STD_LOGIC_VECTOR(4*m-1 downto 0);
            Quotient : out STD_LOGIC_VECTOR(4*n-1 downto 0));
end component;

constant N : integer:=9;
constant M : integer:=4;
signal CLK :  STD_LOGIC:='0';
signal enable : STD_LOGIC:='1';
signal Dividend : STD_LOGIC_VECTOR(4*n-1 downto 0);
signal Divisor  : STD_LOGIC_VECTOR(4*m-1 downto 0);
signal Remainder : STD_LOGIC_VECTOR(4*m-1 downto 0);
signal Quotient : STD_LOGIC_VECTOR(4*n-1 downto 0);
signal Flag     :STD_LOGIC;
begin

divider_ins: BCDDivderGeneric generic map(N,M) port map(CLK,enable,Dividend,Divisor,Flag,Remainder,Quotient);
--957412386/5736                                                 
--Dividend <= "100101010111010000010010001110000110" 
--Divisor <=  "0101011100110110";

--958764321/8564                    
Dividend <= "100101011000011101100100001100100001";
Divisor <=    "1000010101100100";
                 

CLK<= not CLK after  10ns; 
end Behavioral;

