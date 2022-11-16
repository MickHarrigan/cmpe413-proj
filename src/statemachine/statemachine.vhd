-- State machine for cache

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity statemachine is
    port(
        clk:            in std_logic;

        -- Current state (output)
        curr_state:     out std_logic_vector(4 downto 0);

        -- Next state (input)
        next_state:     in std_logic_vector(4 downto 0);

        -- Inputs
        cpu_rd_wrn:     in std_logic;
        cpu_start:      in std_logic;
        cpu_reset:      in std_logic;

        shiftreg_done:  in std_logic;

        hit_miss:       in std_logic;

        -- Outputs
        cpu_busy:       out std_logic;

        shiftreg_input: out std_logic;
        shiftreg_rst:   out std_logic;

        cb_ce:          out std_logic;
        cb_index1:      out std_logic;
        cb_index0:      out std_logic;
        cb_offset1:     out std_logic;
        cb_offset0:     out std_logic;

        cpu_data_oe:    out std_logic;
        mem_add_oe:     out std_logic;

        mem_enable:     out std_logic
    );
end statemachine;

architecture structural of statemachine is
    component dffer5
        port(
            d       : in std_logic_vector(4 downto 0);
            clk     : in std_logic;
            ce      : in std_logic;
            rst     : in std_logic;
            q       : out std_logic_vector(4 downto 0);
            qbar    : out std_logic_vector(4 downto 0)
        );
    end component;


    component buff5
        port(
            input   : in std_logic_vector(4 downto 0);
            output  : out std_logic_vector(4 downto 0)
        );
    end component;

    component tie_high
        port(
            output: out std_logic
        );
    end component;

    component tie_low
        port(
            output: out std_logic
        );
    end component;

    for dffer5_0: dffer5 use entity work.dffer5(structural);
    for buff5_0: buff5 use entity work.buff5(structural);
    for tie_high_0: tie_high use entity work.tie_high(structural);
    for tie_low_0: tie_low use entity work.tie_low(structural);
    
    signal curr_state_i: std_logic_vector(4 downto 0);
    signal one, zero: std_logic;

begin
    tie_high_0: tie_high port map(one);
    tie_low_0: tie_low port map(zero);

    dffer5_0: dffer5 port map(next_state, clk, one, zero, curr_state_i, open);

    buff5_0: buff5 port map(curr_state_i, curr_state);

end structural;
