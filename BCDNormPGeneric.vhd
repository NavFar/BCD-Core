----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/07/2017 10:29:32 AM
-- Design Name: 
-- Module Name: BCDNormPGeneric - Behavioral
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

entity BCDNormPGeneric is
    generic (N : in integer;
         Z : in integer);
    Port    (CLK : in STD_LOGIC;
             Enable   : in STD_LOGIC;
             flag : buffer STD_LOGIC:='0';
             A1 : in STD_LOGIC_VECTOR(4*n-1 downto 0);
             A2 : in STD_LOGIC_VECTOR(4*n-1 downto 0);
             A3 : in STD_LOGIC_VECTOR(4*n-1 downto 0);
             A4 : in STD_LOGIC_VECTOR(4*n-1 downto 0);
             A5 : in STD_LOGIC_VECTOR(4*n-1 downto 0);
             P : in STD_LOGIC_VECTOR(7 downto 0);
             R : out STD_LOGIC_VECTOR(4*n-1 downto 0);
             F : out STD_LOGIC_VECTOR(4*z-1 downto 0));
end BCDNormPGeneric;

architecture Behavioral of BCDNormPGeneric is

--adder
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

--squarerooter
component BCDSquareRooterGeneric is
    generic (N : in integer;
             Z : in integer);
    Port    (CLK : in STD_LOGIC;
             Enable   : in STD_LOGIC;
             A : in STD_LOGIC_VECTOR(4*n-1 downto 0);
             P : in STD_LOGIC_VECTOR(7 downto 0);
             R : out STD_LOGIC_VECTOR(4*n-1 downto 0);
             flag : buffer STD_LOGIC:='0';
             F : out STD_LOGIC_VECTOR(4*z-1 downto 0));
end component;

type state_t is(state0,state1,state2,state3,state4,state5);
signal curState : state_t:=state1;
signal RSTFlag: STD_LOGIC:='0';
signal RSTFlagBuffer: STD_LOGIC:='1';

--Exponent signals


signal Exponent1Enable:STD_LOGIC;
signal Exponent2Enable:STD_LOGIC;
signal Exponent3Enable:STD_LOGIC;
signal Exponent4Enable:STD_LOGIC;
signal Exponent5Enable:STD_LOGIC;
signal Exponent1R:STD_LOGIC_VECTOR (4*n-1 downto 0);
signal Exponent2R:STD_LOGIC_VECTOR (4*n-1 downto 0);
signal Exponent3R:STD_LOGIC_VECTOR (4*n-1 downto 0);
signal Exponent4R:STD_LOGIC_VECTOR (4*n-1 downto 0);
signal Exponent5R:STD_LOGIC_VECTOR (4*n-1 downto 0);
signal Exponent1Flag:STD_LOGIC;
signal Exponent2Flag:STD_LOGIC;
signal Exponent3Flag:STD_LOGIC;
signal Exponent4Flag:STD_LOGIC;
signal Exponent5Flag:STD_LOGIC;
signal Exponent1FlagBuffer:STD_LOGIC;
signal Exponent2FlagBuffer:STD_LOGIC;
signal Exponent3FlagBuffer:STD_LOGIC;
signal Exponent4FlagBuffer:STD_LOGIC;
signal Exponent5FlagBuffer:STD_LOGIC;


--Adder signals
signal Adder1A:STD_LOGIC_VECTOR(4*n-1 downto 0);
signal Adder2A:STD_LOGIC_VECTOR(4*n-1 downto 0);
signal Adder1B:STD_LOGIC_VECTOR(4*n-1 downto 0);
signal Adder2B:STD_LOGIC_VECTOR(4*n-1 downto 0);
signal Adder1R:STD_LOGIC_VECTOR(4*n-1 downto 0);
signal Adder2R:STD_LOGIC_VECTOR(4*n-1 downto 0);
signal Adder1Cin : STD_LOGIC:='0';
signal Adder2Cin : STD_LOGIC:='0';
signal Adder1Cout : STD_LOGIC:='0';
signal Adder2Cout : STD_LOGIC:='0';
--signal Adder2Cout_temp : STD_LOGIC:='0';

--SquareRooter signals
signal sqrtA : STD_LOGIC_VECTOR(4*n-1 downto 0);
signal sqrtR : STD_LOGIC_VECTOR(4*n-1 downto 0);
signal sqrtF : STD_LOGIC_VECTOR(4*z-1 downto 0);
signal sqrtFlagBuffer : STD_LOGIC:='0';
signal sqrtFlag : STD_LOGIC:='0';
signal sqrtEnable : STD_LOGIC:='0';
signal NewFlag: STD_LOGIC:='0';
signal NewFlagBuffer: STD_LOGIC:='0';

signal temp : std_logic := '0';
begin
exponent1: BCDExponentGeneric generic map(n) port map(CLK,Exponent1Enable,A1,P,Exponent1Flag,Exponent1R);
exponent2: BCDExponentGeneric generic map(n) port map(CLK,Exponent2Enable,A2,P,Exponent2Flag,Exponent2R);
exponent3: BCDExponentGeneric generic map(n) port map(CLK,Exponent3Enable,A3,P,Exponent3Flag,Exponent3R);
exponent4: BCDExponentGeneric generic map(n) port map(CLK,Exponent4Enable,A4,P,Exponent4Flag,Exponent4R);
exponent5: BCDExponentGeneric generic map(n) port map(CLK,Exponent5Enable,A5,P,Exponent5Flag,Exponent5R);

Adder1: BCDAdderGeneric generic map(n) port map(Adder1A,Adder1B,'0',Adder1R,open);
Adder2: BCDAdderGeneric generic map(n) port map(Adder2A,Adder2B,'0',Adder2R,open);

SquareRooter: BCDSquareRooterGeneric generic map (n,z) port map (CLK,sqrtEnable,sqrtA,P,sqrtR,sqrtFlag,sqrtF);
    process(CLK)
    begin
        if(rising_edge(CLK)and Enable='1') then
        
            if(RSTFlag/=RSTFlagBuffer) then
                --curState<=state0;
                RSTFlagBuffer<=RSTFlag;
                newFlagBuffer<=not newFlag;
                temp <= '1';
                
                Exponent1Enable <= '1' ;
                Exponent2Enable <= '1' ;
                Exponent3Enable <= '1' ;
                Exponent4Enable <= '1' ;
                Exponent5Enable <= '1' ;
                
                Exponent1FlagBuffer <= Exponent1Flag;      
                Exponent2FlagBuffer <= Exponent2Flag;      
                Exponent3FlagBuffer <= Exponent3Flag;      
                Exponent4FlagBuffer <= Exponent4Flag;      
                Exponent5FlagBuffer <= Exponent5Flag;
                curState <= state1;
                
                sqrtFlagBuffer <= sqrtFlag;
            else
                
                case curState is
                    --when state0=>
                        
                        --curState<=state1;  
                    when state1=>
                        -- results of exponent 1,2,3,4 are ready
                        if((Exponent1FlagBuffer/=Exponent1Flag) and (Exponent2FlagBuffer/=Exponent2Flag) and (Exponent3FlagBuffer/=Exponent3Flag) and (Exponent4FlagBuffer/=Exponent4Flag)) then
                            
                            Exponent1Enable <= '0' ;
                            Exponent2Enable <= '0' ;
                            Exponent3Enable <= '0' ;
                            Exponent4Enable <= '0' ;
                            
                            --Adder1R = A1+A2
                            Adder1A <= Exponent1R;
                            Adder1B <= Exponent2R;
                            
                            --Adder2R = A3 + A4
                            Adder2A <= Exponent3R;
                            Adder2B <= Exponent4R;
                            
                            curState<=state2;
                        end if;
                    when state2=>
                            --Adder1R = A12+A34
                            Adder1A <= Adder1R;
                            Adder1B <= Adder2R;
                            
                            curState<=state3;
                    when state3=>
                        if((Exponent5FlagBuffer/=Exponent5Flag)) then
                            Exponent5Enable <= '0' ;
                            
                            --Adder2R = A5+A1234
                            Adder2A <= Adder1R;
                            Adder2B <= Exponent5R;
                            curState <= state4;
                                         
                        end if;
                    when state4=>
                        sqrtEnable <= '1';
                        sqrtA <= Adder2R;
                        R <= sqrtR;
                        F <= sqrtF;
                        curState <= state5;
                    when state5=>
                        if(sqrtFlagBuffer /= sqrtFlag) then
                            if(newFlag/=newFlagBuffer) then
                                sqrtEnable <= '0';
                                flag<=not flag;
                                R <= sqrtR;
                                F <= sqrtF;
                                newFlagBuffer<=newFlag;
                            end if;
                        --else
                          --  curState <= state1;
                        end if;                
                    when others =>
                        curState<=state0;
                end case;
                
            end if;
        end if;
    end process;


process(A1,A2,A3,A4,A5,P) 
begin
    if(RSTFlag=RSTFlagBuffer) then
        RSTFlag<= not RSTFlag;
    end if;
end process;


end Behavioral;