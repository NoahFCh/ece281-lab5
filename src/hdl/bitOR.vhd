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
 
entity bitOR is
Port ( 
        i_Ao : in std_logic_vector (7 downto 0);
        i_Bo : in std_logic_vector (7 downto 0);
        o_result : out std_logic_vector (7 downto 0);
        o_neg : out std_logic
  );
end bitOR;
 
architecture Behavioral of bitOR is
 
begin
-- CONCURRENT STATEMENTS --------
o_result(0) <= i_Ao(0) or i_Bo(0);
o_result(1) <= i_Ao(1) or i_Bo(1);
o_result(2) <= i_Ao(2) or i_Bo(2);
o_result(3) <= i_Ao(3) or i_Bo(3);
o_result(4) <= i_Ao(4) or i_Bo(4);
o_result(5) <= i_Ao(5) or i_Bo(5);
o_result(6) <= i_Ao(6) or i_Bo(6);
o_result(7) <= i_Ao(7) or i_Bo(7);
 
o_neg <= '1' when (i_Ao(7) = '1' or i_Bo(7) = '1') else '0';
 
 
end Behavioral;