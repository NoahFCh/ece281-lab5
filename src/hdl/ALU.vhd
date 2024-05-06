--+----------------------------------------------------------------------------
--|
--| NAMING CONVENSIONS :
--|
--|    xb_<port name>           = off-chip bidirectional port ( _pads file )
--|    xi_<port name>           = off-chip input port         ( _pads file )
--|    xo_<port name>           = off-chip output port        ( _pads file )
--|    b_<port name>            = on-chip bidirectional port
--|    i_<port name>            = on-chip input port
--|    o_<port name>            = on-chip output port
--|    c_<signal name>          = combinatorial signal
--|    f_<signal name>          = synchronous signal
--|    ff_<signal name>         = pipeline stage (ff_, fff_, etc.)
--|    <signal name>_n          = active low signal
--|    w_<signal name>          = top level wiring signal
--|    g_<generic name>         = generic
--|    k_<constant name>        = constant
--|    v_<variable name>        = variable
--|    sm_<state machine type>  = state machine type definition
--|    s_<signal name>          = state name
--|
--+----------------------------------------------------------------------------
--|
--| ALU OPCODES:
--|
--|     ADD     000
--|
--|
--|
--|
--+----------------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity ALU is
    port(
        i_A: in  std_logic_vector(7 downto 0);
        i_B: in  std_logic_vector(7 downto 0);
        i_op: in std_logic_vector(2 downto 0);
        o_flags: out std_logic_vector(2 downto 0);
        o_result: out std_logic_vector(7 downto 0)
    );
    
end ALU;

architecture behavioral of ALU is 
  
	-- declare components and signals

component Mux_4T1_2bits is
  Port ( SEL : in std_logic_vector (1 downto 0);
      i_AM : in std_logic_vector (7 downto 0);
      i_BM : in std_logic_vector (7 downto 0);
      i_CM : in std_logic_vector (7 downto 0);
      i_DM : in std_logic_vector (7 downto 0);
      o_Y : out std_logic_vector (7 downto 0)
);
end component Mux_4T1_2bits;

component Mux_2T1 is
  Port ( SEL : in std_logic;
    i_AM : in std_logic_vector (7 downto 0);
    i_BM : in std_logic_vector (7 downto 0);
    o_Y : out std_logic_vector (7 downto 0)
);
end component Mux_2T1;

component fullAdder is
	port(
		-- Switches
		i_N1		:	in  std_logic_vector(7 downto 0);
		i_N2        :   in  std_logic_vector(7 downto 0);
		o_sum	    :	out	std_logic_vector(7 downto 0);
		o_Cout      :   out std_logic;
		o_zero      :   out std_logic
	);
end component fullAdder;

component subtrator is
	port(
    i_N1         :    in  std_logic_vector(7 downto 0);
    i_N2         :    in  std_logic_vector(7 downto 0);
    o_difference :    out std_logic_vector(7 downto 0);
    o_Cout       :    out std_logic;  
    o_zero       :    out std_logic   
    );
end component subtrator;

signal w_sumA : std_logic_vector (7 downto 0) := (others => '0');
signal w_sumS : std_logic_vector (7 downto 0) := (others => '0');
signal w_m0 : std_logic_vector (7 downto 0) := (others => '0');
signal w_m1 : std_logic_vector (7 downto 0) := (others => '0');
signal w_m2 : std_logic_vector (7 downto 0) := (others => '0');
signal w_m3 : std_logic_vector (7 downto 0) := (others => '0');
begin
	-- PORT MAPS ----------------------------------------
	
fullAdder_inst : fullAdder
    port map (
        i_N1 => i_A,
        i_N2 => i_B,
        o_sum => w_sumA,
        o_Cout => o_flags(0),
        o_zero => o_flags(1)
 );
    
subtrator_inst : subtrator
    port map (
        i_N1 => i_A,
        i_N2 => i_B,
       o_difference => w_sumS,
       o_Cout => o_flags(0),
       o_zero => o_flags(1)
    );
    
 Mux_2T1_inst : Mux_2T1
       port map(
           SEL => i_op(2),
           i_AM => w_sumA,
           i_BM => w_sumS,
           o_Y => w_m0
       );
Mux_4T1_2bits_inst : Mux_4T1_2bits
    port map (
        SEL(0) => i_op(0),
        SEL(1) => i_op(1),
        i_AM   => w_m0,
        i_BM   => w_m1,
        i_CM   => w_m2,
        i_DM   => w_m3
    ); 	
  
	-- CONCURRENT STATEMENTS ----------------------------

	
end behavioral;
