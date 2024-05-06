----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2024 03:38:24 PM
-- Design Name: 
-- Module Name: controller_fsm - Behavioral
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

entity controller_fsm is
 Port(
         i_reset: in std_logic;
         i_adv:   in std_logic;
         o_cycle: out std_logic_vector (3 downto 0)
     );
end controller_fsm;

architecture controller_fsm_architecture of controller_fsm is

-- CONSTANTS ------------------------------------------------------------------
 
    signal f_Q : std_logic_vector (1 downto 0) := "00";
    signal f_Q_next : std_logic_vector (1 downto 0) := "00";
begin

-- CONCURRENT STATEMENTS --------------------------------------------------------	
	-- Next state logic
	f_Q_next(0) <= (not f_Q(1) and not f_Q(0) and i_adv)
	            or (f_Q(1) and not f_Q(0) and i_adv);
	
	f_Q_next(1) <= (not f_Q(1) and f_Q(0) and i_adv)
	            or (f_Q(1) and not f_Q(0) and i_adv);
	
	-- Output logic
	o_cycle(0) <= not f_Q(1) and not f_Q(0);
	
	o_cycle(1) <= not f_Q(1) and f_Q(0);
	
	o_cycle(2) <= f_Q(1) and not f_Q(0);
	
	o_cycle(3) <= f_Q(1) and f_Q(0);
	
	
	
	-- PROCESSES --------------------------------------------------------------------
        register_proc : process (i_adv, i_reset)
        begin
        if i_reset = '1' then
           f_Q <= "00";               -- reset state is off
        elsif (rising_edge(i_adv)) then
           f_Q <= f_Q_next;            -- next state becomes current state
        end if;
        end process register_proc;
end controller_fsm_architecture;
