-- Generate control signal outputs based on current state

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity output_gen is
    port(
        -- State (input)
        state           : in std_logic_vector(4 downto 0);

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
end output_gen;

architecture structural of output_gen is
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


    for tie_high_0: tie_high use entity work.tie_high(structural);
    for tie_low_0: tie_low use entity work.tie_low(structural);

    for inverter_0: inverter use entity work.inverter(structural);
    for and2_0, and2_1: and2 use entity work.and2(structural);
    for or2_0: or2 use entity work.or2(structural);
    for xor2_0: xor2 use entity work.xor2(structural);

    for buff_0, buff_1, buff_2, buff_3, buff_4, buff_5, buff_6, buff_7, 
        buff_8, buff_9, buff_10, buff_11
        : buff use entity work.buff(structural);

    for bus_creator5_0, bus_creator5_1, bus_creator5_2, bus_creator5_3,
        bus_creator5_4, bus_creator5_5, bus_creator5_6, bus_creator5_7,
        bus_creator5_8
        : bus_creator5 use entity work.bus_creator5(structural);

    for comparator5_0, comparator5_1, comparator5_2, comparator5_3, 
        comparator5_4, comparator5_5, comparator5_6, comparator5_7, 
        comparator5_8
        : comparator5 use entity work.comparator5(structural); 

    
    signal b1, b0: std_logic;

    signal s4xor3, s4and3, s4n, is_state_12_24_20: std_logic;

    signal s00, s01: std_logic;

    signal state01, state08, state09, state12, state13, state15, state20, 
        state21, state24
        : std_logic_vector(4 downto 0);

    signal is_state01, is_state08, is_state09, is_state12, is_state13, 
        is_state15, is_state20, is_state21, is_state24
        : std_logic;

begin
    tie_high_0: tie_high port map(b1);
    tie_low_0: tie_low port map(b0);

    -- Specific state codes
    bus_creator5_0: bus_creator5 port map(b0, b0, b0, b0, b1, state01);
    bus_creator5_1: bus_creator5 port map(b0, b1, b0, b0, b0, state08);
    bus_creator5_2: bus_creator5 port map(b0, b1, b0, b0, b1, state09);
    bus_creator5_3: bus_creator5 port map(b0, b1, b1, b0, b0, state12);
    bus_creator5_4: bus_creator5 port map(b0, b1, b1, b0, b1, state13);
    bus_creator5_5: bus_creator5 port map(b0, b1, b1, b1, b1, state15);
    bus_creator5_6: bus_creator5 port map(b1, b0, b1, b0, b0, state20);
    bus_creator5_7: bus_creator5 port map(b1, b0, b1, b0, b1, state21);
    bus_creator5_8: bus_creator5 port map(b1, b1, b0, b0, b0, state24);

    -- Check for these states
    comparator5_0: comparator5 port map(state, state01, is_state01);
    comparator5_1: comparator5 port map(state, state08, is_state08);
    comparator5_2: comparator5 port map(state, state09, is_state09);
    comparator5_3: comparator5 port map(state, state12, is_state12);
    comparator5_4: comparator5 port map(state, state13, is_state13);
    comparator5_5: comparator5 port map(state, state15, is_state15);
    comparator5_6: comparator5 port map(state, state20, is_state20);
    comparator5_7: comparator5 port map(state, state21, is_state21);
    comparator5_8: comparator5 port map(state, state24, is_state24);
    

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

end structural;
