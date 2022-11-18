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

    component and3
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            input3  : in std_logic;
            output  : out std_logic
        );
    end component;

    component and4
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            input3  : in std_logic;
            input4  : in std_logic;
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

    component or5
        port(
            input1: in std_logic;
            input2: in std_logic;
            input3: in std_logic;
            input4: in std_logic;
            input5: in std_logic;
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

    component decoder5to32
        port(
            input       : in std_logic_vector(4 downto 0);
            output0     : out std_logic;
            output1     : out std_logic;
            output2     : out std_logic;
            output3     : out std_logic;
            output4     : out std_logic;
            output5     : out std_logic;
            output6     : out std_logic;
            output7     : out std_logic;
            output8     : out std_logic;
            output9     : out std_logic;
            output10    : out std_logic;
            output11    : out std_logic;
            output12    : out std_logic;
            output13    : out std_logic;
            output14    : out std_logic;
            output15    : out std_logic;
            output16    : out std_logic;
            output17    : out std_logic;
            output18    : out std_logic;
            output19    : out std_logic;
            output20    : out std_logic;
            output21    : out std_logic;
            output22    : out std_logic;
            output23    : out std_logic;
            output24    : out std_logic;
            output25    : out std_logic;
            output26    : out std_logic;
            output27    : out std_logic;
            output28    : out std_logic;
            output29    : out std_logic;
            output30    : out std_logic;
            output31    : out std_logic
        );
    end component;

    component encoder32to5
        port(
            input0      : in std_logic;
            input1      : in std_logic;
            input2      : in std_logic;
            input3      : in std_logic;
            input4      : in std_logic;
            input5      : in std_logic;
            input6      : in std_logic;
            input7      : in std_logic;
            input8      : in std_logic;
            input9      : in std_logic;
            input10     : in std_logic;
            input11     : in std_logic;
            input12     : in std_logic;
            input13     : in std_logic;
            input14     : in std_logic;
            input15     : in std_logic;
            input16     : in std_logic;
            input17     : in std_logic;
            input18     : in std_logic;
            input19     : in std_logic;
            input20     : in std_logic;
            input21     : in std_logic;
            input22     : in std_logic;
            input23     : in std_logic;
            input24     : in std_logic;
            input25     : in std_logic;
            input26     : in std_logic;
            input27     : in std_logic;
            input28     : in std_logic;
            input29     : in std_logic;
            input30     : in std_logic;
            input31     : in std_logic;
            output0     : out std_logic_vector(4 downto 0)
        );
    end component;


    for tie_high_0: tie_high use entity work.tie_high(structural);

    for tie_low_0: tie_low use entity work.tie_low(structural);

    for inverter_0, inverter_1, inverter_2, inverter_3, inverter_4, inverter_5
        : inverter use entity work.inverter(structural);
    
    for and2_0, and2_1, and2_2, and2_3, and2_4, and2_5, and2_6, and2_7, and2_8, 
        and2_9, and2_10, and2_11, and2_12, and2_13, and2_14, and2_15, and2_16
        : and2 use entity work.and2(structural);

    for and3_0, and3_1, and3_2, and3_3, and3_4, and3_5, and3_6, and3_7
        : and3 use entity work.and3(structural);

    for and4_0, and4_1, and4_2, and4_3
        : and4 use entity work.and4(structural);
    
    for or2_0, or2_1, or2_2, or2_3, or2_4, or2_5
        : or2 use entity work.or2(structural);

    for or5_0: or5 use entity work.or5(structural);

    for xor2_0: xor2 use entity work.xor2(structural);

    for buff_0, buff_1, buff_2, buff_3, buff_4, buff_5, buff_6, buff_7, 
        buff_8, buff_9, buff_10, buff_11, buff_12
        : buff use entity work.buff(structural);

    for dffer5_0: dffer5 use entity work.dffer5(structural);

    for decoder5to32_0: decoder5to32 use entity work.decoder5to32(structural);

    for encoder32to5_0: encoder32to5 use entity work.encoder32to5(structural);

    
    -- Analog 1 and 0
    signal b1, b0: std_logic;

    -- Current state and next state
    signal state, nextstate: std_logic_vector(4 downto 0);

    -- Intermediate signals
    signal s4xor3, s4and3, s4n, is_state_12_24_20: std_logic;

    signal s00, s01, s02, s03, s04, s05, s06, s07, s08, s09, s10, s11, s12, 
        s13, s14
        : std_logic;

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

    decoder5to32_0: decoder5to32 port map(
        state,
        is_state00, is_state01, open, open, 
        open, open, open, open, 
        is_state08, is_state09, open, open, 
        is_state12, is_state13, is_state14, is_state15, 
        open, open, open, open, 
        is_state20, is_state21, is_state22, open, 
        is_state24, is_state25, is_state26, is_state27, 
        is_state28, is_state29, is_state30, is_state31
    );

    -- TODO add encoder32to5
    -- inputs: next00 - next31, with opens in gaps
    -- output: nextstate
    encoder32to5_0: encoder32to5 port map(
        next00, next01, b0, b0, 
        b0, b0, b0, b0, 
        next08, next09, b0, b0, 
        next12, next13, next14, next15, 
        b0, b0, b0, b0, 
        next20, next21, next22, b0, 
        next24, next25, next26, next27, 
        next28, next29, next30, next31, 
        nextstate
    );


    -- ---------- Transition to next state and store ----------
    dffer5_0: dffer5 port map(nextstate, clk, b1, b0, state, open);


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

    -- -> idle
    and3_0: and3 port map(is_state00, cpu_start_n, cpu_reset_n, s02);   -- idle -> idle
    and2_3: and2 port map(is_state09, cpu_reset_n, s03);                -- rd_miss_send -> idle
    and2_4: and2 port map(is_state08, cpu_reset_n, s04);                -- rd_hit -> idle
    and2_5: and2 port map(is_state22, cpu_reset_n, s05);                -- wr_miss -> idle
    and2_6: and2 port map(is_state21, cpu_reset_n, s06);                -- wr_hit -> idle
    and3_1: and3 port map(is_state01, cpu_start_n, cpu_reset_n, s07);   -- reset -> idle

    or5_0: or5 port map(s02, s03, s04, s05, s06, s08);
    or2_2: or2 port map(s07, s08, next00);

    -- -> rd_init
    and4_0: and4 port map(is_state00, cpu_rd_wrn, cpu_start, cpu_reset_n, s09);     -- idle -> rd_init
    and4_1: and4 port map(is_state01, cpu_rd_wrn, cpu_start, cpu_reset_n, s10);     -- reset -> rd_init
    or2_3: or2 port map(s09, s10, next12);

    -- rd_init -> rd_miss_mem_enable
    and3_2: and3 port map(is_state12, cpu_reset_n, hit_miss_n, next13);

    -- -> rd_miss_mem_wait
    and2_7: and2 port map(is_state13, cpu_reset_n, s11);                    -- rd_miss_mem_enable -> rd_miss_mem_wait
    and3_3: and3 port map(is_state14, cpu_reset_n, shiftreg_done_n, s12);   -- rd_miss_mem_wait -> rd_miss_mem_wait
    or2_4: or2 port map(s11, s12, next14);

    -- rd_miss_mem_wait -> rd_miss_wr1
    and3_4: and3 port map(is_state14, cpu_reset_n, shiftreg_done, next24);

    -- rd_miss_wr1 -> rd_miss_wr2
    and2_8: and2 port map(is_state24, cpu_reset_n, next25);

    -- rd_miss_wr2 -> rd_miss_wr3
    and2_9: and2 port map(is_state25, cpu_reset_n, next26);

    -- rd_miss_wr3 -> rd_miss_wr4
    and2_10: and2 port map(is_state26, cpu_reset_n, next27);

    -- rd_miss_wr4 -> rd_miss_wr5
    and2_11: and2 port map(is_state27, cpu_reset_n, next28);

    -- rd_miss_wr5 -> rd_miss_wr6
    and2_12: and2 port map(is_state28, cpu_reset_n, next29);

    -- rd_miss_wr6 -> rd_miss_wr7
    and2_13: and2 port map(is_state29, cpu_reset_n, next30);

    -- rd_miss_wr7 -> rd_miss_wr8
    and2_14: and2 port map(is_state30, cpu_reset_n, next31);

    -- rd_miss_wr8 -> rd_miss_rd
    and2_15: and2 port map(is_state31, cpu_reset_n, next15);

    -- rd_miss_rd -> rd_miss_send
    and2_16: and2 port map(is_state15, cpu_reset_n, next09);
    
    -- rd_init -> rd_hit
    and3_5: and3 port map(is_state12, cpu_reset_n, hit_miss, next08);

    -- -> wr_init
    and4_2: and4 port map(is_state00, cpu_rd_wrn_n, cpu_start, cpu_reset_n, s13);   -- idle -> wr_init
    and4_3: and4 port map(is_state01, cpu_rd_wrn_n, cpu_start, cpu_reset_n, s14);   -- reset -> wr_init
    or2_5: or2 port map(s13, s14, next20);

    -- wr_init -> wr_miss
    and3_6: and3 port map(is_state20, cpu_reset_n, hit_miss_n, next22);

    -- wr_init -> wr_hit
    and3_7: and3 port map(is_state20, cpu_reset_n, hit_miss, next21);

    -- any state -> reset
    buff_12: buff port map(cpu_reset, next01);

end structural;
