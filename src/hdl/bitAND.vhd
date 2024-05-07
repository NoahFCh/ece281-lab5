----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2024 05:58:01 PM
-- Design Name: 
-- Module Name: bitOR - Behavioral
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
 
entity bitAND is
  Port ( 
        i_Aa : in std_logic_vector (7 downto 0);
        i_Ba : in std_logic_vector (7 downto 0);
        o_result : out std_logic_vector (7 downto 0);
        o_neg : out std_logic
  );
end bitAND;
 
architecture Behavioral of bitAND is
 
begin
-- CONCURRENT STATEMENTS --------
o_result(0) <= i_Aa(0) and i_Ba(0);
o_result(1) <= i_Aa(1) and i_Ba(1);
o_result(2) <= i_Aa(2) and i_Ba(2);
o_result(3) <= i_Aa(3) and i_Ba(3);
o_result(4) <= i_Aa(4) and i_Ba(4);
o_result(5) <= i_Aa(5) and i_Ba(5);
o_result(6) <= i_Aa(6) and i_Ba(6);
o_result(7) <= i_Aa(7) and i_Ba(7);
 
o_neg <= '1' when (i_Aa(7) = '1' and i_Ba(7) = '1') else '0';
 
end Behavioral;