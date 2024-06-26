----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2024 01:56:06 PM
-- Design Name: 
-- Module Name: ALU_tb - Behavioral
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

entity ALU_tb is
end ALU_tb;

architecture Behavioral of ALU_tb is

component ALU is
    port(
        i_A: in  std_logic_vector(7 downto 0);
        i_B: in  std_logic_vector(7 downto 0);
        i_op: in std_logic_vector(2 downto 0);
        o_flags: out std_logic_vector(2 downto 0);
        o_result: out std_logic_vector(7 downto 0)
    );
 
end component ALU;

-- test I/O signals
	   --inputs
	   signal w_A, w_B : std_logic_vector (7 downto 0) := (others => '0');
	   signal w_op     : std_logic_vector (2 downto 0) := (others => '0');
	   
	   --outputs
	   signal w_result : std_logic_vector (7 downto 0) := (others => '0');
	   signal w_flags  : std_logic_vector (2 downto 0) := (others => '0');

begin

     ALU_inst : ALU
     port map(
         i_A => w_A,
         i_B => w_B,
         i_op => w_op,
         o_result => w_result,
         o_flags => w_flags
    );

    test_process : process
    begin
    
        w_A <= "00000001"; w_B <= "00000010"; w_op <= "000";
        wait for 10 ns;
        assert w_result = "00000011" and w_flags = "000" report "bad 1 + 2" severity failure;
        
        w_A <= "10000001"; w_B <= "10000010"; w_op <= "000";
        wait for 10 ns;
        assert w_result = "00000011" and w_flags = "001" report "bad add carryout test" severity failure;
        
        w_A <= "00000000"; w_B <= "00000000"; w_op <= "000";
        wait for 10 ns;
        assert w_result = "00000000" and w_flags = "010" report "bad add zero test" severity failure;
        
        w_A <= "11101100"; w_B <= "00010100"; w_op <= "000";
        wait for 10 ns;
        assert w_result = "00000000" and w_flags = "001" report "bad complex add test" severity failure;
                
        w_A <= "11101100"; w_B <= "00010100"; w_op <= "000";
        wait for 10 ns;
        assert w_result = "00000000" and w_flags = "001" report "bad complex add test" severity failure;
        
        w_A <= "11101100"; w_B <= "00000100"; w_op <= "000";
        wait for 10 ns;
        assert w_result = "11110000" and w_flags = "100" report "bad negative add test" severity failure;
        
        w_A <= "00000100"; w_B <= "00000001"; w_op <= "100";
        wait for 10 ns;
        assert w_result = "00000011" and w_flags = "001" report "bad 4 - 1 test" severity failure;
        
        w_A <= "11111100"; w_B <= "00000001"; w_op <= "100";
        wait for 10 ns;
        assert w_result = "11111011" and w_flags = "101" report "bad -4 - 1 test" severity failure;
               
        w_A <= "00000100"; w_B <= "00000100"; w_op <= "100";
        wait for 10 ns;
        assert w_result = "00000000" and w_flags = "011" report "bad subtract zero test" severity failure;
        
        w_A <= "00000001"; w_B <= "00000001"; w_op <= "001";
        wait for 10 ns;
        assert w_result = "00000010" and w_flags = "000" report "bad shift of 1 left" severity failure;
        
        w_A <= "00100100"; w_B <= "00000010"; w_op <= "001";
        wait for 10 ns;
        assert w_result = "10010000" and w_flags = "100" report "bad shift of 2 left" severity failure;
        
        w_A <= "00100100"; w_B <= "00000011"; w_op <= "001";
        wait for 10 ns;
        assert w_result = "00100000" and w_flags = "000" report "bad shift of 2 left" severity failure;
                
        w_A <= "00000010"; w_B <= "00000001"; w_op <= "101";
        wait for 10 ns;
        assert w_result = "00000001" and w_flags = "000" report "bad shift of 1 right" severity failure;
        
        w_A <= "00100010"; w_B <= "00000011"; w_op <= "101";
        wait for 10 ns;
        assert w_result = "00000100" and w_flags = "000" report "bad shift of 3 right" severity failure;
        
        -- Test AND and OR
        w_A <= "10000011"; w_B <= "10000001"; w_op <= "010";
        wait for 10 ns;
        assert w_result = "10000001" and w_flags = "100" report "bad and" severity failure;
        
        w_A <= "10111011"; w_B <= "10001001"; w_op <= "110";
        wait for 10 ns;
        assert w_result = "10001001" and w_flags = "100" report "bad and complex different opp" severity failure;
        
        w_A <= "10000011"; w_B <= "00000001"; w_op <= "011";
        wait for 10 ns;
        assert w_result = "10000011" and w_flags = "100" report "bad or" severity failure;
        
        w_A <= "11010101"; w_B <= "00110110"; w_op <= "111";
        wait for 10 ns;
        assert w_result = "11110111" and w_flags = "100" report "bad or different opp complex" severity failure;
        
    wait;
    end process;
end Behavioral;
