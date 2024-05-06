----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2024 04:04:41 PM
-- Design Name: 
-- Module Name: Mux_2T1 - Behavioral
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

entity Mux_2T1 is
  Port ( SEL : in std_logic;
    i_AM : in std_logic_vector (7 downto 0);
    i_BM : in std_logic_vector (7 downto 0);
    o_Y : out std_logic_vector (7 downto 0)
);
end Mux_2T1;

architecture Behavioral of Mux_2T1 is

begin
    o_Y <= i_AM when (SEL = '0') else
   i_BM when (SEL = '1') else
   "00000000";

end Behavioral;
