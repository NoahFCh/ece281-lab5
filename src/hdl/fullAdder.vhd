----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2024 03:38:54 PM
-- Design Name: 
-- Module Name: fullAdder - Behavioral
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



entity fullAdder is
	port(
		-- Switches
		i_N1		:	in  std_logic_vector(7 downto 0);
		i_N2        :   in  std_logic_vector(7 downto 0);
		o_sum	    :	out	std_logic_vector(7 downto 0);
		o_Cout      :   out std_logic;
		o_zero      :   out std_logic
	);
end fullAdder;


architecture fullAdder_arch of fullAdder is 
    signal w_N1 : std_logic_vector (8 downto 0) := (others => '0');
    signal w_N2 : std_logic_vector (8 downto 0) := (others => '0');
    signal sum :  unsigned(8 downto 0) := (others => '0');
    
begin
	-- PORT MAPS --------------------
	
	
	-- CONCURRENT STATEMENTS --------
	
	w_N1(0) <= i_N1(0);
	w_N1(1) <= i_N1(1);
	w_N1(2) <= i_N1(2);
	w_N1(3) <= i_N1(3);
	w_N1(4) <= i_N1(4);
	w_N1(5) <= i_N1(5);
	w_N1(6) <= i_N1(6);
	w_N1(7) <= i_N1(7);
	
	w_N2(0) <= i_N2(0);
	w_N2(1) <= i_N2(1);
	w_N2(2) <= i_N2(2);
	w_N2(3) <= i_N2(3);
	w_N2(4) <= i_N2(4);
	w_N2(5) <= i_N2(5);
	w_N2(6) <= i_N2(6);
	w_N2(7) <= i_N2(7);
	
	sum <= unsigned(w_N1) + unsigned(w_N2);
	
	o_Cout <= '1' when sum(8) = '1' else '0';
	o_zero <= '1' when sum = "00000000" else '0';
	o_sum(0) <= std_logic(sum(0));
	o_sum(1) <= std_logic(sum(1));
	o_sum(2) <= std_logic(sum(2));
	o_sum(3) <= std_logic(sum(3));
	o_sum(4) <= std_logic(sum(4));
	o_sum(5) <= std_logic(sum(5));
	o_sum(6) <= std_logic(sum(6));
	o_sum(7) <= std_logic(sum(7));
	---------------------------------
end fullAdder_arch;
