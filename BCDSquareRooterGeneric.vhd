----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/05/2017 05:08:32 PM
-- Design Name: 
-- Module Name: BCDSquareRooterGeneric - Behavioral
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

entity BCDSquareRooterGeneric is
    generic (N : in integer;
             Z : in integer);
    Port    (CLK : in STD_LOGIC;
             Enable   : in STD_LOGIC;
             A : in STD_LOGIC_VECTOR(4*n-1 downto 0);
             P : in STD_LOGIC_VECTOR(7 downto 0);
             R : out STD_LOGIC_VECTOR(4*n-1 downto 0);
             F : out STD_LOGIC_VECTOR(4*z-1 downto 0));
end BCDSquareRooterGeneric;

architecture Behavioral of BCDSquareRooterGeneric is
--Adder
component BCDAdderGeneric is
    generic(N : in integer);
    Port   (A : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            B : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            Cin : in STD_LOGIC;
            R : out STD_LOGIC_VECTOR(4*N-1 downto 0);
            Cout : out STD_LOGIC);
end component;
--Exponent
component Exponent is
    generic (N : integer);
    Port ( CLK : in STD_LOGIC;
           enable : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (4*n-1 downto 0);
           P : in STD_LOGIC_VECTOR (7 downto 0);
           Flag:buffer STD_LOGIC:='0';
           R : out STD_LOGIC_VECTOR (4*n-1 downto 0));
end component;
--Divider
component BCDDivderGeneric is
    generic(N : in integer;
            M : in integer);
    Port   (CLK      : in STD_LOGIC;
            Enable   : in STD_LOGIC;
            Dividend : in STD_LOGIC_VECTOR(4*n-1 downto 0);
            Divisor  : in STD_LOGIC_VECTOR(4*m-1 downto 0);
            flag     : buffer STD_LOGIC:='0';
            Remainder: out STD_LOGIC_VECTOR(4*m-1 downto 0);
            Quotient : out STD_LOGIC_VECTOR(4*n-1 downto 0));
end component;
--Complement
component BCDComplementGeneric is
    generic (N  : in integer);
    Port    (A  : in STD_LOGIC_VECTOR(4*n-1 downto 0);
             AComp : out STD_LOGIC_VECTOR(4*n-1 downto 0));
end component;


type state_t is(state0,state1,state2,state3,state4);
signal curState : state_t:=state0;
signal aAdder:std_logic_vector(4*n-1+4*z-1 downto 0);
signal bAdder:std_logic_vector(4*n-1+4*z-1 downto 0);
signal outAdder:std_logic_vector(4*n-1+4*z-1 downto 0);
signal coutAdder:std_logic;

signal aDivider1:std_logic_vector(4*n-1+4*z-1 downto 0);
signal bDivider1:std_logic_vector(4*n-1+4*z-1 downto 0):=(others => '0');
signal qDivider1:std_logic_vector(4*n-1+4*z-1 downto 0);
signal flagDivider1:std_logic;

signal aExponent:std_logic_vector(4*n-1+4*z-1 downto 0);
signal pExponent:std_logic_vector(4*n-1+4*z-1 downto 0);
signal outExponent:std_logic_vector(4*n-1+4*z-1 downto 0);
signal flagExponent:std_logic;

signal x:std_logic_vector(4*n-1+4*z-1 downto 0):=(0=>'1',others=>'0');
begin
divider1:BCDDivderGeneric generic map (n+z,n) port map (CLK,Enable,aDivider1,bDivider1,flagDivider1,open,qDivider1);
                       
process(CLK)
begin
 if(rising_edge(CLK)and Enable='1') then
    case curState is
             when state0=>
                    x <= (0=>'1',others => '0');
                    aDivider1 <= A;
                    bDivider1(7 downto 0) <= P;
             when state1=>
                     
             when state2=>
                     
             when state3=>
                   
             when state4=>
                   
             when others =>
                curState<=state0;
         end case;
 end if;
 end process;

end Behavioral;
