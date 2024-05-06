----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2024 04:03:34 PM
-- Design Name: 
-- Module Name: Mux_4T1_2bits - Behavioral
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

entity Mux_4T1_2bits is
  Port ( SEL : in std_logic_vector (1 downto 0);
      i_AM : in std_logic_vector (7 downto 0);
      i_BM : in std_logic_vector (7 downto 0);
      i_CM : in std_logic_vector (7 downto 0);
      i_DM : in std_logic_vector (7 downto 0);
      o_Y : out std_logic_vector (7 downto 0)
);
end Mux_4T1_2bits;

architecture Behavioral of Mux_4T1_2bits is

begin
    o_Y <= i_AM when (SEL = "00") else
       i_BM when (SEL = "01") else
       i_CM when (SEL = "10") else
       i_DM when (SEL = "11") else
       "00000000";

end Behavioral;
