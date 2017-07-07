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
             flag : buffer STD_LOGIC:='0';
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
component BCDExponentGeneric is
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
--Comparartor
component VectorComparatorGeneric is
    Generic(N : in integer);
    Port ( A : in STD_LOGIC_VECTOR (N-1 downto 0);
           B : in STD_LOGIC_VECTOR (N-1 downto 0);
           Equal : out STD_LOGIC);
end component;

--Subtractor
component BCDSubtractorGeneric is
    generic(N : in integer);
    Port   (A : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            B : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            Bin : in STD_LOGIC;
            R : out STD_LOGIC_VECTOR(4*N-1 downto 0);
            Bout : out STD_LOGIC);
end  component ;

type state_t is(state0,state1,state2,state3,state4,state5,state6);
signal curState : state_t:=state0;
signal RSTFlag: STD_LOGIC:='0';
signal RSTFlagBuffer: STD_LOGIC:='1';
signal NewFlag: STD_LOGIC:='0';
signal NewFlagBuffer: STD_LOGIC:='0';

--adder Signals
 signal AdderA : STD_LOGIC_VECTOR(4*(n+z)-1 downto 0);
 signal AdderB : STD_LOGIC_VECTOR(4*(n+z)-1 downto 0);
 signal AdderR : STD_LOGIC_VECTOR(4*(n+z)-1 downto 0);
 
 --subtractor Signals
 signal one : STD_LOGIC_VECTOR(7 downto 0):="00000001";
 signal PMinus:STD_LOGIC_VECTOR(7 downto 0);
 --comparator Signals
 signal Equal : STD_LOGIC:='0';
 
 -- exponent signals
 signal exponentA :STD_LOGIC_VECTOR(4*n-1 downto 0);
 signal exponentEnable : STD_LOGIC:='0';
 signal exponentFlag : STD_LOGIC;
 signal exponentR :STD_LOGIC_VECTOR(4*n-1 downto 0);
 
 --divider1 signals
 signal divider1Dividend :STD_LOGIC_VECTOR(4*(z+n)-1 downto 0);
 signal divider1Enable : STD_LOGIC:='0';
 signal divider1Flag : STD_LOGIC;
 signal divider1Quotient :STD_LOGIC_VECTOR(4*(z+n)-1 downto 0);
--divider2 signals
  signal divider2Dividend :STD_LOGIC_VECTOR(4*(z+n)-1 downto 0);
  signal divider2Divisor :STD_LOGIC_VECTOR(4*(n)-1 downto 0);
  signal divider2Enable : STD_LOGIC:='0';
  signal divider2Flag : STD_LOGIC;
  signal divider2Quotient :STD_LOGIC_VECTOR(4*(z+n)-1 downto 0);
 --complement signals
  signal divider1QuotientComplement:STD_LOGIC_VECTOR(4*(z+n)-1 downto 0);
 --process Signals
  signal X :STD_LOGIC_VECTOR(4*(n+Z)-1 downto 0);
  signal divider1FlagBuffer : STD_LOGIC;
  signal divider2FlagBuffer : STD_LOGIC;
  signal exponentFlagBuffer : STD_LOGIC;
  signal ADividedToP :STD_LOGIC_VECTOR(4*(z+n)-1 downto 0);
begin
Adder: BCDAdderGeneric generic map(n+Z) port map(AdderA,AdderB,'0',AdderR,open);
subtractor: BCDSubtractorGeneric generic map(2) port map(p,one,'0',Pminus,open);         
comparartor: VectorComparatorGeneric generic map(4*n) port map(AdderR(4*(n+z)-1 downto 4*z),X(4*(n+z)-1 downto 4*z),Equal);
exponent: BCDExponentGeneric generic map(n) port map(CLK,exponentEnable,exponentA,pminus,exponentFlag,exponentR);               
divider1: BCDDivderGeneric   generic map(n+z,2) port map(CLK,divider1Enable,divider1Dividend,p,divider1Flag,open,divider1Quotient);
divider2: BCDDivderGeneric   generic map(n+z,n) port map(CLK,divider2Enable,divider2Dividend,divider2Divisor,divider2Flag,open,divider2Quotient);
complement: BCDComplementGeneric generic map(n+z) port map(divider1Quotient,divider1QuotientComplement);
process(CLK)
begin
 if(rising_edge(CLK)and Enable='1') then
    if(RSTFlag/=RSTFlagBuffer) then
     x<=(4*z=>'1',others=>'0');
      -- divider2 controll
     divider2Dividend(4*(z+n)-1 downto 4*z)<=A;
     divider2Dividend(4*z downto 0)<=(others=>'0');
     divider2Divisor(7 downto 0)<=p;
     divider2Divisor(4*n-1 downto 8)<=(others=>'0');
     divider2FlagBuffer<=divider2Flag;
     divider2Enable<='1';
     curState<=state6;
     newFlagBuffer<=not newFlag;
     RSTFlagBuffer<=RSTFlag;
     else
    case curState is
             when state0=>
               
             when state6=>
                 if(divider2FlagBuffer/=divider2Flag) then
                    divider2Enable<='0';
                    divider2Dividend(0)<= not divider2Dividend(0);
                    ADividedToP<=divider2Quotient;
                    curState<=state1;
                 end if;
             when state1=>
               
                   -- exponent controll
                  exponentA<=x(4*(z+n)-1 downto 4*z);
                  exponentFlagBuffer<=exponentFlag;
                  exponentEnable<='1';
                  -- divider1 controll
                  divider1Dividend<=x;
                  divider1FlagBuffer<=divider1Flag;
                  divider1Enable<='1';
                  curState<=state2;
                     
             when state2=>
                  if((divider1FlagBuffer/=divider1Flag)and (exponentFlagBuffer/=exponentFlag)) then
                      
                    --adder controll
                     AdderA<=x;
                     AdderB<=divider1QuotientComplement;
                    --divider2 controll
                     divider2Dividend<=ADividedToP;
                     divider2Divisor<=exponentR;
                     divider2FlagBuffer<=divider2Flag;
                     divider2Enable<='1';
                     curState<=state3;
                  end if;
                  if((exponentFlagBuffer/=exponentFlag)) then
                    exponentEnable<='0';
                    exponentA(0)<= not exponentA(0);
                  end if;
                  if((divider1FlagBuffer/=divider1Flag)) then
                    divider1Enable<='0';
                  end if;                                       
             when state3=>
                   if((divider2FlagBuffer/=divider2Flag)) then
                      divider2Enable<='0';
                      divider2Dividend(0)<=not divider2Dividend(0);
                      AdderA<=AdderR;
                      AdderB<=divider2Quotient;
                      curState<=state4;
                   end if;
             when state4=>
                   if(Equal='1') then
                   if(newFlag/=newFlagBuffer) then
                    flag<=not flag;
                    R<=AdderR(4*(n+z)-1 downto 4*z);
                    F<=AdderR(4*z-1 downto 0);
                    newFlagBuffer<=newFlag;

                   end if;
                    curState<=state5;
                   else
                    X<=AdderR;
                    curState<=state1;
                   end if;
                    
             when others =>
                curState<=state0;
         end case;
      end if;
 end if;
 end process;
process(A,P) 
begin
      if(RSTFlag=RSTFlagBuffer) then
        RSTFlag<= not RSTFlag;
      end if;
end process;
end Behavioral;