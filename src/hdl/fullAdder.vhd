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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fullAdder is
	port(
		-- Switches
		i_D		:	in  std_logic_vector(2 downto 0);
		o_M	    :	out	std_logic_vector(1 downto 0)
	);
end fullAdder;

architecture fullAdder_arch of fullAdder is 
	
  -- declare the component of your top-level design 
  component halfAdder is
        port (
            i_A : in std_logic;
            i_B : in std_logic;
            o_S : out std_logic;
            o_Cout : out std_logic
            );
        end component halfAdder;
  -- declare any signals you will need	
  signal w_S1 : std_logic := '0';
  signal w_Cout1 : std_logic := '0';
  signal w_Cout2 : std_logic := '0';
begin
	-- PORT MAPS --------------------
    halfAdder1_inst: halfAdder
    port map(
        i_A     => sw(0),
        i_B     => sw(1),
        o_S     => w_S1,
        o_Cout  => w_Cout1
     );
	---------------------------------
	halfAdder2_inst: halfAdder
	port map(
	    i_A    =>  w_S1,
	    i_B    =>  sw(2),
	    o_S    =>  led(0),
	    o_Cout =>  w_Cout2
	 );
	-- CONCURRENT STATEMENTS --------
	 led(1) <= w_Cout1 or w_Cout2;-- TODO
	---------------------------------
end fullAdder_arch;
