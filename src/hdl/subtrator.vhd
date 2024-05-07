----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2024 05:22:23 PM
-- Design Name: 
-- Module Name: subtrator - Behavioral
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


library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity subtrator is
	port(
    i_N1         :    in  std_logic_vector(7 downto 0);
    i_N2         :    in  std_logic_vector(7 downto 0);
    o_difference :    out    std_logic_vector(7 downto 0);
    o_Cout       :    out std_logic;
    o_zero       :    out std_logic;
    o_neg        :   out std_logic
    );
end subtrator;

architecture Behavioral of subtrator is
    signal diff : unsigned(7 downto 0);
begin
	-- PORT MAPS --------------------

-- CONCURRENT STATEMENTS --------
    diff <= unsigned(i_N1) - unsigned(i_N2);
    o_difference <= std_logic_vector(diff);
    o_Cout <= '1';
    o_zero <= '1' when diff = "00000000" else '0';
    o_neg <= '1' when diff(7) = '1' else '0';
---------------------------------

end Behavioral;
