----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2024 10:59:43 AM
-- Design Name: 
-- Module Name: sevenSegDecoder - Behavioral
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

entity sevenSegDecoder is
    Port ( i_D : in STD_LOGIC_VECTOR (3 downto 0);
           o_S : out STD_LOGIC_VECTOR (6 downto 0);
           i_sel : in std_logic_vector (3 downto 0));
end sevenSegDecoder;

architecture sevenSegDecoder_arch of sevenSegDecoder is

--signals
    signal c_Sa : std_logic := '1';
    signal c_Sb : std_logic := '1';
    signal c_Sc : std_logic := '1';
    signal c_Sd : std_logic := '1';
    signal c_Se : std_logic := '1';
    signal c_Sf : std_logic := '1';
    signal c_Sg : std_logic := '1';
    signal sign : std_logic_vector(6 downto 0) := (others => '0');
    
begin
    --port maps
    
    --concurrent statments
   -- o_S(0) <= c_Sa;
   -- o_S(1) <= c_Sb;
   -- o_S(2) <= c_Sc;
   -- o_S(3) <= c_Sd;
   -- o_S(4) <= c_Se;
   -- o_S(5) <= c_Sf;
   -- o_S(6) <= c_Sg;
    
 with i_sel select
           o_S(0) <= sign(0) when "0111",
                c_Sa when others;
 
 with i_sel select
           o_S(1) <= sign(1) when "0111",
               c_Sb when others;
 
 with i_sel select
          o_S(2) <= sign(2) when "0111",
               c_Sc when others;
               
 with i_sel select
          o_S(3) <= sign(3) when "0111",
               c_Sd when others;
 
 with i_sel select
          o_S(4) <= sign(4) when "0111",
          c_Se when others;   
 
 with i_sel select
          o_S(5) <= sign(5) when "0111",
          c_Sf when others;   
          
 with i_sel select
          o_S(6) <= sign(6) when "0111",
          c_Sg when others;         

with i_D select
           sign <= "0111111" when "0001",
           "1000000" when others; 
    
    c_Sa <= ( not i_D(3) and not i_D(2) and not i_D(1) and i_D(0) )
         or ( i_D(3) and not i_D(2) and i_D(1) and i_D(0) )
         or ( i_D(2) and not i_D(1) and not i_D(0) )
         or ( i_D(3) and i_D(2) and not i_D(1) );
    
    c_Sb <= ( not i_D(3) and i_D(2) and not i_D(1) and i_D(0) )
         or ( i_D(3) and i_D(2) and not i_D(0) )
         or ( i_D(3) and i_D(1) and i_D(0) )
         or ( i_D(2) and i_D(1) and not i_D(0) );
    
    c_Sc <= '1' when ( (i_D = x"2") or
                       (i_D = x"C") or
                       (i_D = x"E") or
                       (i_D = x"F") ) else '0';
    
    c_Sd <= '1' when ( (i_D = x"1") or
                       (i_D = x"4") or
                       (i_D = x"7") or
                       (i_D = x"9") or
                       (i_D = x"A") or
                       (i_D = x"F") ) else '0';
                       
    c_Se <= '1' when ( (i_D = x"1") or
                       (i_D = x"3") or
                       (i_D = x"4") or
                       (i_D = x"5") or
                       (i_D = x"7") or
                       (i_D = x"9") ) else '0';
                       
    c_Sf <= '1' when ( (i_D = x"1") or
                       (i_D = x"2") or
                       (i_D = x"3") or
                       (i_D = x"7") or
                       (i_D = x"C") or
                       (i_D = x"D") ) else '0';
                       
    c_Sg <= '1' when ( (i_D = x"0") or
                       (i_D = x"1") or
                       (i_D = x"7") ) else '0';
                 

end sevenSegDecoder_arch;
