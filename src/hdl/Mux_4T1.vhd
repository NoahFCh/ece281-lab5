----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2024 08:42:43 PM
-- Design Name: 
-- Module Name: Mux_4T1 - Behavioral
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

entity Mux_4T1 is
  Port ( SEL : in std_logic_vector (3 downto 0);
        i_A : in std_logic_vector (7 downto 0);
        i_B : in std_logic_vector (7 downto 0);
        i_C : in std_logic_vector (7 downto 0);
        o_Y : out std_logic_vector (7 downto 0)
  );
end Mux_4T1;

architecture Behavioral of Mux_4T1 is

begin
    o_Y <= i_A when (SEL = "0001") else
           i_B when (SEL = "0100") else
           i_C when (SEL = "0010") else
           "0000";
    

end Behavioral;
