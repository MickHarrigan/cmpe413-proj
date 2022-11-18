-- State machine for cache

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity statemachine is
    port(
        clk             : in std_logic;

        -- Inputs
        cpu_rd_wrn      : in std_logic;
        cpu_start       : in std_logic;
        cpu_reset       : in std_logic;

        shiftreg_done   : in std_logic;

        hit_miss        : in std_logic;

        -- Signals that may be passed through, not used in logic
        cpu_add1        : in std_logic;
        cpu_add0        : in std_logic;

        -- Outputs
        cpu_busy        : out std_logic;

        shiftreg_input  : out std_logic;
        shiftreg_rst    : out std_logic;

        cpu_data_oe     : out std_logic;
        mem_add_oe      : out std_logic;

        mem_enable      : out std_logic;

        cb_ce           : out std_logic;
        cb_ce_adj       : out std_logic;
        cb_ce_inv       : out std_logic;
        
        cb_rd_wr        : out std_logic;
        cb_offset1      : out std_logic;
        cb_offset0      : out std_logic;

        tb_ce           : out std_logic;
        tb_rd_wr        : out std_logic;

        valid_ce        : out std_logic;
        valid_ce_all    : out std_logic;
        valid_rd_wr     : out std_logic;
        valid_d_wr      : out std_logic
    );
end statemachine;

architecture structural of statemachine is
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

    component inverter
        port(
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

    component and2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );
    end component;

    component or2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );
    end component;

    component or4
        port(
            input1: in std_logic;
            input2: in std_logic;
            input3: in std_logic;
            input4: in std_logic;
            output: out std_logic
        );
    end component;

    component xor2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );
    end component;

    component bus_creator5
        port(
            input4  : in std_logic;
            input3  : in std_logic;
            input2  : in std_logic;
            input1  : in std_logic;
            input0  : in std_logic;
            output  : out std_logic_vector(4 downto 0)
        );
    end component;

    component comparator5
        port(
            input1  : in std_logic_vector(4 downto 0);
            input2  : in std_logic_vector(4 downto 0);
            output  : out std_logic
        );
    end component;

    component mux2
        port(
            input0  : in std_logic;
            input1  : in std_logic;
            s       : in std_logic;
            output  : out std_logic
        );
    end component;

    component buff
        port(
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

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


    for tie_high_0: tie_high use entity work.tie_high(structural);
    for tie_low_0: tie_low use entity work.tie_low(structural);

    for inverter_0: inverter use entity work.inverter(structural);
    for and2_0, and2_1: and2 use entity work.and2(structural);
    for or2_0: or2 use entity work.or2(structural);
    for xor2_0: xor2 use entity work.xor2(structural);

    for buff_0, buff_1, buff_2, buff_3, buff_4, buff_5, buff_6, buff_7, 
        buff_8, buff_9, buff_10, buff_11
        : buff use entity work.buff(structural);

    for bus_creator5_00, bus_creator5_01, bus_creator5_08, bus_creator5_09, 
        bus_creator5_12, bus_creator5_13, bus_creator5_14, bus_creator5_15, 
        bus_creator5_20, bus_creator5_21, bus_creator5_22, bus_creator5_24, 
        bus_creator5_25, bus_creator5_26, bus_creator5_27, bus_creator5_28, 
        bus_creator5_29, bus_creator5_30, bus_creator5_31
        : bus_creator5 use entity work.bus_creator5(structural);

    for comparator5_00, comparator5_01, comparator5_08, comparator5_09, 
        comparator5_12, comparator5_13, comparator5_14, comparator5_15, 
        comparator5_20, comparator5_21, comparator5_22, comparator5_24, 
        comparator5_25, comparator5_26, comparator5_27, comparator5_28, 
        comparator5_29, comparator5_30, comparator5_31
        : comparator5 use entity work.comparator5(structural); 

    for dffer5_state: dffer5 use entity work.dffer5(structural);

    
    -- Analog 1 and 0
    signal b1, b0: std_logic;

    -- Current state and next state
    signal state, nextstate: std_logic_vector(4 downto 0);

    -- Intermediate signals
    signal s4xor3, s4and3, s4n, is_state_12_24_20: std_logic;

    signal s00, s01: std_logic;

    -- TODO delete
    signal state00, state01, state08, state09, state12, state13, state14,
        state15, state20, state21, state22, state24, state25, state26, 
        state27, state28, state29, state30, state31
        : std_logic_vector(4 downto 0);

    signal is_state00, is_state01, is_state08, is_state09, is_state12, 
        is_state13, is_state14, is_state15, is_state20, is_state21, 
        is_state22, is_state24, is_state25, is_state26, is_state27, 
        is_state28, is_state29, is_state30, is_state31
        : std_logic;

    signal cpu_rd_wrn_n, cpu_start_n, cpu_reset_n, shiftreg_done_n, hit_miss_n
        : std_logic;

    signal next00, next01, next08, next09, next12, 
        next13, next14, next15, next20, next21, 
        next22, next24, next25, next26, next27, 
        next28, next29, next30, next31
        : std_logic;

begin
    tie_high_0: tie_high port map(b1);
    tie_low_0: tie_low port map(b0);

    -- TODO delete
    -- Generate state codes
    bus_creator5_00: bus_creator5 port map(b0, b0, b0, b0, b0, state00);
    bus_creator5_01: bus_creator5 port map(b0, b0, b0, b0, b1, state01);
    bus_creator5_08: bus_creator5 port map(b0, b1, b0, b0, b0, state08);
    bus_creator5_09: bus_creator5 port map(b0, b1, b0, b0, b1, state09);
    bus_creator5_12: bus_creator5 port map(b0, b1, b1, b0, b0, state12);
    bus_creator5_13: bus_creator5 port map(b0, b1, b1, b0, b1, state13);
    bus_creator5_14: bus_creator5 port map(b0, b1, b1, b1, b0, state14);
    bus_creator5_15: bus_creator5 port map(b0, b1, b1, b1, b1, state15);
    bus_creator5_20: bus_creator5 port map(b1, b0, b1, b0, b0, state20);
    bus_creator5_21: bus_creator5 port map(b1, b0, b1, b0, b1, state21);
    bus_creator5_22: bus_creator5 port map(b1, b0, b1, b1, b0, state22);
    bus_creator5_24: bus_creator5 port map(b1, b1, b0, b0, b0, state24);
    bus_creator5_25: bus_creator5 port map(b1, b1, b0, b0, b1, state25);
    bus_creator5_26: bus_creator5 port map(b1, b1, b0, b1, b0, state26);
    bus_creator5_27: bus_creator5 port map(b1, b1, b0, b1, b1, state27);
    bus_creator5_28: bus_creator5 port map(b1, b1, b1, b0, b0, state28);
    bus_creator5_29: bus_creator5 port map(b1, b1, b1, b0, b1, state29);
    bus_creator5_30: bus_creator5 port map(b1, b1, b1, b1, b0, state30);
    bus_creator5_31: bus_creator5 port map(b1, b1, b1, b1, b1, state31);
    
    -- TODO replace with decoder5to32, with opens in gaps
    -- Compare current state with each state code
    comparator5_00: comparator5 port map(state, state00, is_state00);
    comparator5_01: comparator5 port map(state, state01, is_state01);
    comparator5_08: comparator5 port map(state, state08, is_state08);
    comparator5_09: comparator5 port map(state, state09, is_state09);
    comparator5_12: comparator5 port map(state, state12, is_state12);
    comparator5_13: comparator5 port map(state, state13, is_state13);
    comparator5_14: comparator5 port map(state, state14, is_state14);
    comparator5_15: comparator5 port map(state, state15, is_state15);
    comparator5_20: comparator5 port map(state, state20, is_state20);
    comparator5_21: comparator5 port map(state, state21, is_state21);
    comparator5_22: comparator5 port map(state, state22, is_state22);
    comparator5_24: comparator5 port map(state, state24, is_state24);
    comparator5_25: comparator5 port map(state, state25, is_state25);
    comparator5_26: comparator5 port map(state, state26, is_state26);
    comparator5_27: comparator5 port map(state, state27, is_state27);
    comparator5_28: comparator5 port map(state, state28, is_state28);
    comparator5_29: comparator5 port map(state, state29, is_state29);
    comparator5_30: comparator5 port map(state, state30, is_state30);
    comparator5_31: comparator5 port map(state, state31, is_state31);

    -- TODO add encoder32to5
    -- inputs: next00 - next31, with opens in gaps
    -- output: nextstate


    -- ---------- Transition to next state ----------
    dffer5_state: dffer5 port map(nextstate, clk, b1, b0, state, open);


    -- ---------- Output logic ----------
    -- cpu_busy
    xor2_0: xor2 port map(state(4), state(3), s4xor3);
    and2_0: and2 port map(s4xor3, state(2), s00);
    and2_1: and2 port map(state(4), state(3), s4and3);
    or2_0: or2 port map(s00, s4and3, cpu_busy);

    -- shiftreg_input
    buff_0: buff port map(is_state13, shiftreg_input);

    -- shiftreg_rst
    buff_1: buff port map(is_state01, shiftreg_rst);

    -- cpu_data_oe
    or2_1: or2 port map(is_state08, is_state09, cpu_data_oe);

    -- mem_add_oe
    buff_2: buff port map(is_state13, mem_add_oe);

    -- mem_enable
    buff_3: buff port map(is_state13, mem_enable);

    -- cb_ce
    or4_0: or4 port map(is_state12, is_state08, is_state15, is_state09, s01);
    or4_1: or4 port map(s01, is_state21, s4and3, b0, cb_ce);

    -- cb_ce_adj
    buff_4: buff port map(s4and3, cb_ce_adj);

    -- cb_ce_inv
    buff_5: buff port map(state(0), cb_ce_inv);

    -- cb_rd_wr
    inverter_0: inverter port map(state(4), s4n);
    and2_2: and2 port map(s4n, state(3), cb_rd_wr);

    -- cb_offset
    mux2_0: mux2 port map(cpu_add1, state(2), state(4), cb_offset1);
    mux2_1: mux2 port map(cpu_add0, state(1), state(4), cb_offset0);

    -- tb_ce
    or4_2: or4 port map(is_state12, is_state24, is_state20, b0, is_state_12_24_20);
    buff_6: buff port map(is_state_12_24_20, tb_ce);

    -- tb_rd_wr
    buff_7: buff port map(s4n, tb_rd_wr);

    -- valid_ce
    buff_8: buff port map(is_state_12_24_20, valid_ce);

    -- valid_ce_all
    buff_9: buff port map(is_state01, valid_ce_all);

    -- valid_rd_wr
    buff_10: buff port map(s4xor3, valid_rd_wr);

    -- valid_d_wr
    buff_11: buff port map(state(4), valid_d_wr);


    -- ---------- Next state logic ----------
    inverter_1: inverter port map(cpu_rd_wrn, cpu_rd_wrn_n);
    inverter_2: inverter port map(cpu_start, cpu_start_n);
    inverter_3: inverter port map(cpu_reset, cpu_reset_n);
    inverter_4: inverter port map(shiftreg_done, shiftreg_done_n);
    inverter_5: inverter port map(hit_miss, hit_miss_n);

    -- idle
    
    




    -- idle

    





end structural;
