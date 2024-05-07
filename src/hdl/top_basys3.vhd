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
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity top_basys3 is
    port(
	       clk : in std_logic;
	       btnU : in std_logic;
	       btnC : in std_logic;
	       sw : in std_logic_vector(15 downto 0);
	       an : out std_logic_vector(3 downto 0);
	       led : out std_logic_vector(15 downto 0);
	       seg : out std_logic_vector(6 downto 0)
	       );
end top_basys3;

architecture top_basys3_arch of top_basys3 is 
  
	-- declare components and signals
	signal w_div : std_logic := '0';
	signal w_regA, w_regB, w_alu, w_mux : std_logic_vector(7 downto 0) := (others => '0');
	signal w_cycle, w_tdm, w_D0, w_D1, w_D2, w_sel, w_D3 : std_logic_vector(3 downto 0) := (others => '0');
	signal w_flags : std_logic_vector (2 downto 0) := (others => '0');
	
	component clock_divider is
	generic ( constant k_DIV : natural := 2	); -- How many clk cycles until slow clock toggles
                                                   -- Effectively, you divide the clk double this 
                                                   -- number (e.g., k_DIV := 2 --> clock divider of 4)
        port (     i_clk    : in std_logic;
                i_reset  : in std_logic;           -- asynchronous
                o_clk    : out std_logic           -- divided (slow) clock
        );
	end component clock_divider;
	
	component twoscomp_decimal is
        port (
            i_binary: in std_logic_vector(7 downto 0);
            o_negative: out std_logic;
            o_hundreds: out std_logic_vector(3 downto 0);
            o_tens: out std_logic_vector(3 downto 0);
            o_ones: out std_logic_vector(3 downto 0)
        );
    end component twoscomp_decimal;
    
    component TDM4 is
        generic ( constant k_WIDTH : natural  := 4); -- bits in input and output
        Port ( i_clk        : in  STD_LOGIC;
               i_reset        : in  STD_LOGIC; -- asynchronous
               i_D3         : in  STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
               i_D2         : in  STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
               i_D1         : in  STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
               i_D0         : in  STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
               o_data        : out STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
               o_sel        : out STD_LOGIC_VECTOR (3 downto 0)    -- selected data line (one-cold)
        );
    end component TDM4;
    
    component sevenSegDecoder is
        Port ( i_D : in STD_LOGIC_VECTOR (3 downto 0);
               o_S : out STD_LOGIC_VECTOR (6 downto 0);
               i_sel : in std_logic_vector (3 downto 0));
    end component sevenSegDecoder;

   component controller_fsm is
    Port(
        i_reset:   in std_logic;
        i_adv:   in std_logic;
        o_cycle: out std_logic_vector (3 downto 0)
    );
    end component controller_fsm;
    
    component ALU is
        port(
            i_A: in  std_logic_vector(7 downto 0);
            i_B: in  std_logic_vector(7 downto 0);
            i_op: in std_logic_vector(2 downto 0);
            o_flags: out std_logic_vector(2 downto 0);
            o_result: out std_logic_vector(7 downto 0)
        );
    end component ALU;
    
    component regA is
        Port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        o_Q : out std_logic_vector(7 downto 0);
        i_Q_next : in std_logic_vector(7 downto 0));
    end component regA;
    
    component regB is
            Port (
            i_clk : in std_logic;
            i_reset : in std_logic;
            o_Q : out std_logic_vector(7 downto 0);
            i_Q_next : in std_logic_vector(7 downto 0));
    end component regB;
    
    component Mux_4T1 is
      Port ( SEL : in std_logic_vector (3 downto 0);
            i_A : in std_logic_vector (7 downto 0);
            i_B : in std_logic_vector (7 downto 0);
            i_C : in std_logic_vector (7 downto 0);
            o_Y : out std_logic_vector (7 downto 0)
      );
    end component Mux_4T1;
begin
	-- PORT MAPS ----------------------------------------
clkdiv_inst : clock_divider 
    generic map ( k_DIV => 100000 ) -- 1 Hz clock from 100 MHz
                   port map (                          
                       i_clk   => clk,
                       i_reset => btnU,
                       o_clk   => w_div
                   ); 
	
twoscomp_decimal_inst : twoscomp_decimal
    port map(
        i_binary => w_mux,
        o_negative => w_D3(0),
        o_hundreds => w_D2,
        o_tens => w_D1,
        o_ones => w_D0
    );
    
TDM4_inst : TDM4
    port map(
        i_clk => w_div,
        i_reset => btnU,
        i_D3 => w_D3,
        i_D2 => w_D2,
        i_D1 => w_D1,
        i_D0 => w_D0,
        o_sel => w_sel,
        o_data => w_tdm
    );
    
sevenSegDecoder_inst : sevenSegDecoder
    port map(
        i_D => w_tdm,
        o_S => seg,
        i_sel => w_sel
        
    );
    
controller_fsm_inst : controller_fsm
    port map(
        i_reset => btnU,
        i_adv => btnC,
        o_cycle => w_cycle
    );
    
ALU_inst : ALU
    port map(
        i_A => w_regA,
        i_B => w_regB,
        i_op => sw(15 downto 13),
        o_flags => w_flags,
        o_result => w_alu
    );
    
regA_inst : regA
    port map(
        i_clk => w_cycle(0),
        i_Q_next => sw(7 downto 0),
        o_Q => w_regA,
        i_reset => btnU
    );
    
regB_inst : regB
        port map(
            i_clk => w_cycle(1),
            i_Q_next => sw(7 downto 0),
            o_Q => w_regB,
            i_reset => btnU
        );
        
Mux_4T1_inst : Mux_4T1
    port map(
        SEL => w_cycle,
        i_A => w_regA,
        i_B => w_alu,
        i_C => w_regB,
        o_Y => w_mux
    );
	-- CONCURRENT STATEMENTS ----------------------------
    an <= w_sel; 
    with w_cycle select
           led(15 downto 13) <=  w_flags when "0100" ,
                       "000" when others;
	led(12 downto 4) <= (others => '0');
	led(3 downto 0) <= w_cycle;
	
	
end top_basys3_arch;
