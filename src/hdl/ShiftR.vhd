----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2024 06:41:51 PM
-- Design Name: 
-- Module Name: ShiftR - Behavioral
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

entity ShiftR is
    port(
        i_num         :    in  std_logic_vector(7 downto 0);
        i_shift       :    in  std_logic_vector(7 downto 0);
        o_numS        :    out std_logic_vector(7 downto 0);
        o_sign        :    out std_logic         
    );
end ShiftR;

architecture Behavioral of ShiftR is
    signal shift : unsigned(7 downto 0);
begin
shift <= shift_right(unsigned(i_num), to_integer(unsigned(i_shift(2 downto 0))));
o_sign <= '1' when shift(7) = '1' else '0';
o_numS <= std_logic_vector(shift);

end Behavioral;
