----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/04/2017 12:58:56 AM
-- Design Name: 
-- Module Name: Exponent - Behavioral
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

entity Exponent is
    generic (N : integer);
    Port ( CLK : in STD_LOGIC;
           enable : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (4*n-1 downto 0);
           P : in STD_LOGIC_VECTOR (7 downto 0);
           Flag:buffer STD_LOGIC:='0';
           R : out STD_LOGIC_VECTOR (4*n-1 downto 0));
end Exponent;

architecture Behavioral of Exponent is



--bcd to binary convert
component BCD2BinaryConvertor2Digit is
    Port ( BCD : in STD_LOGIC_VECTOR (7 downto 0);
           Binary : out STD_LOGIC_VECTOR (7 downto 0));
end component;

--multiplier 
component BCDMultiplierGeneric is
   generic(N :in integer);
   Port   (A :in STD_LOGIC_VECTOR(4*N-1 DOWNTO 0);
           B :in STD_LOGIC_VECTOR(4*N-1 DOWNTO 0);
           R :out STD_LOGIC_VECTOR(8*N-1 DOWNTO 0));
end component;
signal Binary : STD_LOGIC_VECTOR (7 downto 0);

type state_t is(state0,state1,state2,state3,state4,state5,state6);
signal curState : state_t:=state0;
signal RSTFlag: STD_LOGIC:='0';
signal RSTFlagBuffer: STD_LOGIC:='1';
signal NewFlag: STD_LOGIC:='0';
signal NewFlagBuffer: STD_LOGIC:='0';
signal bitLocator: integer:=0;
signal multiplierFirstOperand : STD_LOGIC_VECTOR (4*n-1 downto 0):=(others=>'0');
signal multiplierSecondOperand : STD_LOGIC_VECTOR (4*n-1 downto 0):=(others=>'0');
signal multiplierResult : STD_LOGIC_VECTOR (8*n-1 downto 0):=(others=>'0');
signal zero  : STD_LOGIC_VECTOR (4*n-2 downto 0):=(others=>'0');


signal savedValue  : STD_LOGIC_VECTOR (4*n-1 downto 0):=(others=>'0');
signal currentExponent  : STD_LOGIC_VECTOR (4*n-1 downto 0):=(others=>'0');
constant Limit : integer :=7;
begin

BCD2Bin:BCD2BinaryConvertor2Digit port map(P,Binary);
multiplier: BCDMultiplierGeneric generic map(n) port map(multiplierFirstOperand,multiplierSecondOperand,multiplierResult);
process(CLK)
    
begin
    if(rising_edge(CLK) and enable='1') then
        if(RSTFlag/=RSTFlagBuffer) then
                    bitlocator<=0;
                    savedValue<=zero&'1';
                    currentExponent<=A;
                    newFlagBuffer<=not newFlag;
                    curState<=state1;
                    RSTFlagBuffer<=RSTFlag;

        else
    case curState is
        when state0=>
            
        when state1=>
            if(binary(bitlocator)='1') then
                multiplierFirstOperand<=currentExponent;
                multiplierSecondOperand<=savedValue;
                curState<=state2;
            else
               multiplierFirstOperand<=currentExponent;
               multiplierSecondOperand<=currentExponent;
               curState<=state3;
            end if;
        when state2=>
               savedValue<=multiplierResult(4*n-1 downto 0);
               multiplierFirstOperand<=currentExponent;
               multiplierSecondOperand<=currentExponent;
               curState<=state3;
        when state3=>
               if(bitlocator<Limit) then
                    curState<=state1;
                    bitlocator<=bitlocator+1;
                    
               else
                    curState<=state4;
               end if;
               currentExponent<=multiplierResult(4*n-1 downto 0);
        when state4=>
            if(newFlag/=newFlagBuffer) then
            Flag<=not Flag;  
            R<=savedValue;
            newFlagBuffer<=newFlag;
            end if;
        when others=>
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
