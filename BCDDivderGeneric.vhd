----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/04/2017 03:25:59 PM
-- Design Name: 
-- Module Name: BCDDivderGeneric - Behavioral
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

entity BCDDivderGeneric is
    generic(N : in integer;
            M : in integer);
    Port   (CLK      : in STD_LOGIC;
            Enable   : in STD_LOGIC;
            Dividend : in STD_LOGIC_VECTOR(4*n-1 downto 0);
            Divisor  : in STD_LOGIC_VECTOR(4*m-1 downto 0);
            flag     : buffer STD_LOGIC:='0';
            Remainder: out STD_LOGIC_VECTOR(4*m-1 downto 0);
            Quotient : out STD_LOGIC_VECTOR(4*n-1 downto 0));
end BCDDivderGeneric;

architecture Behavioral of BCDDivderGeneric is

--adder
component BCDAdderGeneric is
    generic(N : in integer);
    Port   (A : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            B : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            Cin : in STD_LOGIC;
            R : out STD_LOGIC_VECTOR(4*N-1 downto 0);
            Cout : out STD_LOGIC);
end component;

--subtractor
component BCDSubtractorGeneric is
    generic(N : in integer);
    Port   (A : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            B : in STD_LOGIC_VECTOR(4*N-1 downto 0);
            Bin : in STD_LOGIC;
            R : out STD_LOGIC_VECTOR(4*N-1 downto 0);
            Bout : out STD_LOGIC);
end component;

type state_t is(state0,state1,state2,state3,state4);
signal curState : state_t:=state0;

signal Dividend_buffer :  STD_LOGIC_VECTOR(4*n-1 downto 0);
signal Quotient_buffer :  STD_LOGIC_VECTOR(4*n-1 downto 0):=(others=>'0');
signal Divisor_buffer_CA  :  STD_LOGIC_VECTOR(4*n-1 downto 0):=(others=>'0');
signal Divisor_buffer_PA  :  STD_LOGIC_VECTOR(4*n-1 downto 0):=(others=>'0');
signal zero            :     STD_LOGIC_VECTOR(4*n - 4*m -1 downto 0 ):=(others=>'0');
signal CA_B            :  STD_LOGIC_VECTOR(4*n-1 downto 0):=(others=>'0'); 
signal CP_B            :  STD_LOGIC_VECTOR(4*n-1 downto 0):=(others=>'0');

signal CA_Flag         :  STD_LOGIC:='0';
signal CP_Flag         :  STD_LOGIC:='0'; 

signal CP_output       :  STD_LOGIC_VECTOR(4*n-1 downto 0):=(others=>'0');


signal one             :  STD_LOGIC_VECTOR(4*N-1 downto 0):=(0=>'1',others=>'0');
signal adderOutput     :  STD_LOGIC_VECTOR(4*N-1 downto 0):=(0=>'1',others=>'0');
signal index           :  integer:=0;

signal RSTFlag: STD_LOGIC:='0';
signal RSTFlagBuffer: STD_LOGIC:='1';
signal NewFlag: STD_LOGIC:='0';
signal NewFlagBuffer: STD_LOGIC:='0';
       
begin
Divisor_buffer_CA<=zero&Divisor;
AllComparator:     BCDSubtractorGeneric generic map(n) port map(Dividend_buffer,Divisor_buffer_CA,'0',open,CA_Flag);
PartialComparator: BCDSubtractorGeneric generic map(n) port map(Dividend_buffer,Divisor_buffer_PA,'0',CP_output,CP_Flag);
QuotientAdde:      BCDAdderGeneric      generic map(n) port map(Quotient_buffer,one,'0',adderOutput,open);

process(CLK)
begin
    if(rising_edge(CLK)and Enable='1') then
    
    if(RSTFlag/=RSTFlagBuffer) then
         index<=0;  
         Divisor_buffer_PA<=Divisor&zero;
         Dividend_buffer<=Dividend;
         Quotient_buffer<=(others=>'0');
         curState<=state1;
         RSTFlagBuffer<=RSTFlag;
         newFlagBuffer<=not newFlag;
     else
        case curState is
            when state0=>
                   
            when state1=>
                    if(CP_Flag='1') then
                        curState<=state2;
                    else
                        if(CA_Flag='1') then
                            index<=index+1;
                            Divisor_buffer_PA<=(others=>'0');
                            curState<=state3;
                        else
                            curState<=state4;
                        end if;
                    end if;
            when state2=>
                    Quotient_buffer<=adderOutput;
                    Dividend_buffer<=CP_output;
                    curState<=state1;
            when state3=>
                  Divisor_buffer_PA(4*n-1-4*index downto 4*n-4*index-4*m)<=Divisor;
                  curState<=state1;
                  Quotient_buffer(4*n-1 downto 4) <= Quotient_buffer(4*n-5 downto 0);
                  Quotient_buffer(3 downto 0) <= "0000";
            when state4=>
                  if(newFlag/=newFlagBuffer) then
                  remainder<=Dividend_buffer(4*m-1 downto 0);
                  Quotient<=Quotient_buffer;
                  flag<=not Flag;
                  newFlagBuffer<=newFlag;
                  end if;
            when others =>
            curState<=state0;
        end case;
        end if;
    end if;
end process;

process(Divisor,Dividend) 
begin
    if(RSTFlag=RSTFlagBuffer) then
    RSTFlag<= not RSTFlag;
    end if;
end process;
end Behavioral;
