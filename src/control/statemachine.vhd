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

        count1          : in std_logic;
        count2          : in std_logic;

        hit_miss        : in std_logic;

        -- Outputs
        cpu_busy        : out std_logic;

        counter_ce      : out std_logic;
        counter_rst     : out std_logic;

        cpu_data_oe     : out std_logic;
        mem_add_oe      : out std_logic;

        mem_enable      : out std_logic;

        cb_d_wr_control : out std_logic;

        cb_ce           : out std_logic;
        cb_rd_wr        : out std_logic;

        cb_offset_control   : out std_logic;
        
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

    component or3
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            input3  : in std_logic;
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

    component buff
        port(
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

    component dffer4
        port(
            d       : in std_logic_vector(3 downto 0);
            clk     : in std_logic;
            ce      : in std_logic;
            rst     : in std_logic;
            q       : out std_logic_vector(3 downto 0);
            qbar    : out std_logic_vector(3 downto 0)
        );
    end component;

    component decoder4to16
        port(
            input       : in std_logic_vector(3 downto 0);
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
            output15    : out std_logic
        );
    end component;

    component encoder16to4
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
            output      : out std_logic_vector(3 downto 0)
        );
    end component;


    for tie_high_0: tie_high use entity work.tie_high(structural);

    for tie_low_0: tie_low use entity work.tie_low(structural);

    for inverter_0, inverter_1, inverter_2, inverter_3, inverter_4, 
        inverter_5, inverter_6
        : inverter use entity work.inverter(structural);
    
    for and2_0, and2_1, and2_2, and2_3, and2_4, and2_5, and2_6
        : and2 use entity work.and2(structural);

    for and3_0, and3_1, and3_2, and3_3, and3_4, and3_5, and3_6, and3_7, 
        and3_8, and3_9
        : and3 use entity work.and3(structural);

    for and4_0, and4_1, and4_2, and4_3: and4 use entity work.and4(structural);
    
    for or2_0, or2_1, or2_2, or2_3, or2_4, or2_5, or2_6, or2_7
        : or2 use entity work.or2(structural);

    for or3_0, or3_1, or3_2: or3 use entity work.or3(structural);
    
    for or4_0: or4 use entity work.or4(structural);

    for xor2_0: xor2 use entity work.xor2(structural);

    for buff_0, buff_1, buff_2, buff_3, buff_4, buff_5, buff_6, buff_7, 
        buff_8, buff_9, buff_10 
        : buff use entity work.buff(structural);

    for dffer4_0: dffer4 use entity work.dffer4(structural);

    for decoder4to16_0: decoder4to16 use entity work.decoder4to16(structural);

    for encoder16to4_0: encoder16to4 use entity work.encoder16to4(structural);

    
    -- Analog 1 and 0
    signal b1, b0: std_logic;

    -- Current state and next state
    signal state, nextstate: std_logic_vector(3 downto 0);

    -- Intermediate signals
    signal s3n, is_state_04_14, is_state_04_08_14: std_logic;

    signal cpu_rd_wrn_n, cpu_start_n, cpu_reset_n, count1_n, count2_n, hit_miss_n: std_logic;

    signal s00, s01, s02, s03, s04, s05, s06, s07, s08, s09, s10, s11, s12, 
        s13, s14
        : std_logic;

    signal is_state00, is_state01, is_state04, is_state05, is_state06, 
        is_state07, is_state08, is_state09, is_state12, is_state13, 
        is_state14, is_state15
        : std_logic;
    
    signal next00, next01, next04, next05, next06, next07, next08, next09, 
        next12, next13, next14, next15
        : std_logic;

begin
    tie_high_0: tie_high port map(b1);
    tie_low_0: tie_low port map(b0);

    decoder4to16_0: decoder4to16 port map(
        state,
        is_state00, is_state01, open, open, 
        is_state04, is_state05, is_state06, is_state07, 
        is_state08, is_state09, open, open, 
        is_state12, is_state13, is_state14, is_state15
    );

    encoder16to4_0: encoder16to4 port map(
        next00, next01, b0, b0,
        next04, next05, next06, next07, 
        next08, next09, b0, b0,
        next12, next13, next14, next15, 
        nextstate
    );


    -- ---------- Transition to next state and store ----------
    
    dffer4_0: dffer4 port map(nextstate, clk, b1, b0, state, open);


    -- ---------- Output logic ----------
    -- Intermediate signals
    inverter_0: inverter port map(state(3), s3n);
    or2_0: or2 port map(is_state04, is_state14, is_state_04_14);
    or2_1: or2 port map(is_state_04_14, is_state08, is_state_04_08_14);

    -- cpu_busy
    or3_0: or3 port map(state(3), is_state04, is_state06, cpu_busy);

    -- counter_ce
    or3_1: or3 port map(is_state12, is_state13, is_state08, counter_ce);

    -- counter_rst
    or2_2: or2 port map(is_state06, is_state01, counter_rst);

    -- cpu_data_oe
    or2_3: or2 port map(is_state05, is_state07, cpu_data_oe);

    -- mem_add_oe
    buff_0: buff port map(is_state12, mem_add_oe);

    -- mem_enable
    buff_1: buff port map(is_state12, mem_enable);

    -- cb_d_wr_control
    buff_2: buff port map(is_state08, cb_d_wr_control);

    -- cb_ce
    xor2_0: xor2 port map(state(3), state(2), cb_ce);

    -- cb_rd_wr
    and2_0: and2 port map(s3n, state(2), cb_rd_wr);

    -- cb_offset_control
    buff_3: buff port map(is_state08, cb_offset_control);

    -- tb_ce
    buff_4: buff port map(is_state_04_08_14, tb_ce);
    
    -- tb_rd_wr
    buff_5: buff port map(is_state_04_14, tb_rd_wr);
        
    -- valid_ce
    buff_6: buff port map(is_state_04_08_14, valid_ce);

    -- valid_ce_all
    buff_7: buff port map(is_state01, valid_ce_all);

    -- valid_rd_wr
    buff_8: buff port map(is_state_04_14, valid_rd_wr);
    
    -- valid_d_wr
    buff_9: buff port map(is_state08, valid_d_wr);


    -- ---------- Next state logic ----------
    -- Intermediate signals
    inverter_1: inverter port map(cpu_rd_wrn, cpu_rd_wrn_n);
    inverter_2: inverter port map(cpu_start, cpu_start_n);
    inverter_3: inverter port map(cpu_reset, cpu_reset_n);
    inverter_4: inverter port map(count1, count1_n);
    inverter_5: inverter port map(count2, count2_n);
    inverter_6: inverter port map(hit_miss, hit_miss_n);

    -- -> idle
    and3_0: and3 port map(is_state00, cpu_start_n, cpu_reset_n, s00);   -- idle -> idle
    and2_1: and2 port map(is_state07, cpu_reset_n, s01);                -- rd_miss_send -> idle
    and2_2: and2 port map(is_state05, cpu_reset_n, s02);                -- rd_hit -> idle
    and2_3: and2 port map(is_state15, cpu_reset_n, s03);                -- wr_miss -> idle
    and2_4: and2 port map(is_state09, cpu_reset_n, s04);                -- wr_hit -> idle
    and3_1: and3 port map(is_state01, cpu_start_n, cpu_reset_n, s05);   -- reset -> idle
    or4_0: or4 port map(s00, s01, s02, s03, s06);
    or3_2: or3 port map(s06, s04, s05, next00);

    -- -> rd_init
    and4_0: and4 port map(is_state00, cpu_rd_wrn, cpu_start, cpu_reset_n, s07); -- idle -> rd_init
    and4_1: and4 port map(is_state01, cpu_rd_wrn, cpu_start, cpu_reset_n, s08); -- reset -> rd_init
    or2_4: or2 port map(s07, s08, next04);

    -- rd_init -> rd_miss_mem_enable
    and3_2: and3 port map(is_state04, cpu_reset_n, hit_miss_n, next12);

    -- -> rd_miss_mem_wait
    and2_5: and2 port map(is_state12, cpu_reset_n, s09);            -- rd_miss_mem_enable -> rd_miss_mem_wait
    and3_3: and3 port map(is_state13, cpu_reset_n, count1_n, s10);  -- rd_miss_mem_wait -> rd_miss_mem_wait
    or2_5: or2 port map(s09, s10, next13);

    -- -> rd_miss_wr
    and3_4: and3 port map(is_state13, cpu_reset_n, count1, s11);    -- rd_miss_mem_wait -> rd_miss_wr
    and3_5: and3 port map(is_state08, cpu_reset_n, count2_n, s12);  -- rd_miss_wr -> rd_miss_wr
    or2_6: or2 port map(s11, s12, next08);

    -- rd_miss_wr -> rd_miss_rd
    and3_6: and3 port map(is_state08, cpu_reset_n, count2, next06);

    -- rd_miss_rd -> rd_miss_send
    and2_6: and2 port map(is_state06, cpu_reset_n, next07);
    
    -- rd_init -> rd_hit
    and3_7: and3 port map(is_state04, cpu_reset_n, hit_miss, next05);

    -- -> wr_init
    and4_2: and4 port map(is_state00, cpu_rd_wrn_n, cpu_start, cpu_reset_n, s13);   -- idle -> wr_init
    and4_3: and4 port map(is_state01, cpu_rd_wrn_n, cpu_start, cpu_reset_n, s14);   -- reset -> wr_init
    or2_7: or2 port map(s13, s14, next14);

    -- wr_init -> wr_miss
    and3_8: and3 port map(is_state14, cpu_reset_n, hit_miss_n, next15);

    -- wr_init -> wr_hit
    and3_9: and3 port map(is_state14, cpu_reset_n, hit_miss, next09);

    -- any state -> reset
    buff_10: buff port map(cpu_reset, next01);

end structural;
