----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2024 03:37:47 PM
-- Design Name: 
-- Module Name: regA - Behavioral
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

entity regA is
    Port (
    i_clk : in std_logic;
    i_reset : in std_logic;
    o_Q : out std_logic_vector(7 downto 0);
    i_Q_next : in std_logic_vector(7 downto 0));
end regA;

architecture regA_architecture of regA is

begin
-- port maps

--concurrent statements

--- state memory w/ asynchronous reset ---
register_proc : process (i_clk, i_reset)
begin
    if i_reset = '1' then
        o_Q <= "00000000";        -- reset state is 0
    elsif (i_clk = '1') then
        o_Q <= i_Q_next;    -- next state becomes current state
    end if;
end process register_proc;


end regA_architecture;
