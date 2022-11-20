-- Top level cache

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity chip is
    port(
        cpu_add     : in  std_logic_vector(5 downto 0);
        cpu_data    : inout  std_logic_vector(7 downto 0);
        cpu_rd_wrn  : in  std_logic;    
        start       : in  std_logic;
        clk         : in  std_logic;
        reset       : in  std_logic;
        mem_data    : in  std_logic_vector(7 downto 0);
        Vdd         : in  std_logic;
        Gnd         : in  std_logic;
        busy        : out std_logic;
        mem_en      : out std_logic;
        mem_add     : out std_logic_vector(5 downto 0)
    );
end chip;

architecture structural of chip is
    component tie_low
        port(
            output: out std_logic
        );
    end component;

    -- state machine
    component statemachine
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
            --cb_ce_adj       : out std_logic; TODO
            --cb_ce_inv       : out std_logic;
            
            cb_rd_wr        : out std_logic;
            cb_offset1      : out std_logic;
            cb_offset0      : out std_logic;

            tb_ce           : out std_logic;
            tb_rd_wr        : out std_logic;

            valid_ce        : out std_logic;
            valid_ce_all    : out std_logic;
            valid_rd_wr     : out std_logic;
            valid_d_wr      : out std_logic;

            cb_d_wr_control : out std_logic
        );
    end component;

    --component cb_ce_gen TODO
    --    port(
    --        cb_ce:      in std_logic;
    --        cb_ce_adj:  in std_logic;
    --        cb_ce_inv:  in std_logic;
    --        clk:        in std_logic;
    --        cb_ce_out:  out std_logic
    --    );
    --end component;

    component valid_ce_gen
        port(
            index0:         in std_logic;
            index1:         in std_logic;
            valid_ce:       in std_logic;
            valid_ce_all:   in std_logic;
            valid_ce0:     out std_logic;
            valid_ce1:     out std_logic;
            valid_ce2:     out std_logic;
            valid_ce3:     out std_logic
        );
    end component;

    -- cache block
    component cache_block
        port(
            d_wr    : in std_logic_vector(7 downto 0);
            ce      : in std_logic;
            rd_wr   : in std_logic;
            index0  : in std_logic;
            index1  : in std_logic;
            offset0 : in std_logic;
            offset1 : in std_logic;
            d_rd    : out std_logic_vector(7 downto 0);
            clk     : in std_logic
        );
    end component;
    -- tag block
    component tag_block
        port(
            d_wr    : in std_logic_vector(1 downto 0);
            ce      : in std_logic;
            rd_wr   : in std_logic;
            index0  : in std_logic;
            index1  : in std_logic;
            d_rd    : out std_logic_vector(1 downto 0);
            clk     : in std_logic
        );
    end component;
    -- "valid" (4 cells of cache)
    component cache_cell1
        port(
            d_wr    : in std_logic;
            ce      : in std_logic;
            rd_wr   : in std_logic;
            d_rd    : out std_logic;
            clk     : in std_logic
        );
    end component;

    -- component dffer
    --     port(
    --         d       : in std_logic;
    --         clk     : in std_logic;
    --         ce      : in std_logic;
    --         rst     : in std_logic;
    --         q       : out std_logic;
    --         qbar    : out std_logic
    --     );
    -- end component;

    component Dlatch
        port ( d   : in  std_logic;
         clk : in  std_logic;
         q   : out std_logic;
         qbar: out std_logic);
    end component;

    component dlatch6
        port(
        d       : in std_logic_vector(5 downto 0);
        clk     : in std_logic;
        q       : out std_logic_vector(5 downto 0);
        qbar    : out std_logic_vector(5 downto 0)
    );
    end component;

    component dlatch8
        port(
        d       : in std_logic_vector(7 downto 0);
        clk     : in std_logic;
        q       : out std_logic_vector(7 downto 0);
        qbar    : out std_logic_vector(7 downto 0)
    );
    end component;

    -- -- registers (8 and 6)
    -- component dffer6
    --     port(
    --         d       : in std_logic_vector(5 downto 0);
    --         clk     : in std_logic;
    --         ce      : in std_logic;
    --         rst     : in std_logic;
    --         q       : out std_logic_vector(5 downto 0);
    --         qbar    : out std_logic_vector(5 downto 0)
    --     );
    -- end component;

    -- component dffer8
    --     port(
    --         d       : in std_logic_vector(7 downto 0);
    --         clk     : in std_logic;
    --         ce      : in std_logic;
    --         rst     : in std_logic;
    --         q       : out std_logic_vector(7 downto 0);
    --         qbar    : out std_logic_vector(7 downto 0)
    --     );
    -- end component;

    component buff
        port(
            input   : in std_logic;
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

    component bus_creator2
        port(
            input1  : in std_logic;
            input0  : in std_logic;
            output  : out std_logic_vector(1 downto 0)
        );
    end component;

    component bus_creator6
        port(
            input5  : in std_logic;
            input4  : in std_logic;
            input3  : in std_logic;
            input2  : in std_logic;
            input1  : in std_logic;
            input0  : in std_logic;
            output  : out std_logic_vector(5 downto 0)
        );
    end component;

    -- oe_d
    component output_enable8
        port(
            input   : in std_logic_vector(7 downto 0);
            oe      : in std_logic;
            output  : out std_logic_vector(7 downto 0)
        );
    end component;
    -- oe_a
    component output_enable6
        port(
            input   : in std_logic_vector(5 downto 0);
            oe      : in std_logic;
            output  : out std_logic_vector(5 downto 0)
        );
    end component;
    -- counter
    component shiftreg8
        port(
            clk     : in std_logic;
            input   : in std_logic;
            rst     : in std_logic;
            q       : out std_logic_vector(7 downto 0)
        );
    end component;
    -- hit miss detector
    component hit_miss_detector
        port(
            input1  : in std_logic_vector(1 downto 0);
            input2  : in std_logic_vector(1 downto 0);
            valid   : in std_logic;
            output  : out std_logic
        );
    end component;

    for tie_low_0: tie_low use entity work.tie_low(structural);

    -- for reg_cpu_add: dffer6 use entity work.dffer6(structural);
    for latch_cpu_add: dlatch6 use entity work.dlatch6(structural);

    -- for reg_cpu_data: dffer8 use entity work.dffer8(structural);
    for latch_cpu_data: dlatch8 use entity work.dlatch8(structural);

    -- for reg_cpu_rd_wrn: dffer use entity work.dffer(structural);
    for latch_cpu_rd_wrn: dlatch use entity work.dlatch(structural);

    for sm: statemachine use entity work.statemachine(structural);

    for counter: shiftreg8 use entity work.shiftreg8(structural);

    for buff_shiftreg_done: buff use entity work.buff(structural);

    for mux2_0, mux2_1, mux2_2, mux2_3, mux2_4, mux2_5, mux2_6, mux2_7
        : mux2 use entity work.mux2(structural);

    --for cb_ce_gen_0: cb_ce_gen use entity work.cb_ce_gen(structural);

    for cb: cache_block use entity work.cache_block(structural);

    for bus_creator2_tb_d_wr, bus_creator2_hm_tag: bus_creator2 use entity work.bus_creator2(structural);

    for tb: tag_block use entity work.tag_block(structural);

    for valid_ce_gen_0: valid_ce_gen use entity work.valid_ce_gen(structural);

    for valid0, valid1, valid2, valid3
        : cache_cell1 use entity work.cache_cell1(structural);

    for hm: hit_miss_detector use entity work.hit_miss_detector(structural);

    for oe_cpu_data: output_enable8 use entity work.output_enable8(structural);

    for bus_creator6_mem_add: bus_creator6 use entity work.bus_creator6(structural);

    for oe_mem_add: output_enable6 use entity work.output_enable6(structural);

    
    signal b0: std_logic;

    signal cpu_add_stored: std_logic_vector(5 downto 0);
    signal cpu_rd_wrn_stored: std_logic;
    signal cpu_data_stored: std_logic_vector(7 downto 0);

    signal shiftreg_input, shiftreg_rst, shiftreg_done: std_logic;
    signal shiftreg_q: std_logic_vector(7 downto 0);

    signal cb_ce: std_logic;
    --cb_ce_adj, cb_ce_inv, cb_ce_out TODO
    signal cb_rd_wr, cb_offset1, cb_offset0: std_logic;
    signal cb_d_rd: std_logic_vector(7 downto 0);

    signal tb_ce, tb_rd_wr: std_logic; 
    signal tb_d_wr, tb_d_rd: std_logic_vector(1 downto 0);

    signal valid_ce, valid_ce_all, valid_rd_wr, valid_d_wr, valid_d_rd: std_logic;
    signal valid_ce0, valid_ce1, valid_ce2, valid_ce3: std_logic;

    signal hit_miss: std_logic;
    signal hm_tag: std_logic_vector(1 downto 0);
    
    signal mem_add_out: std_logic_vector(5 downto 0);
    signal cpu_data_oe, mem_add_oe: std_logic;

    signal cb_d_wr_control: std_logic;
    signal cb_d_wr: std_logic_vector(7 downto 0);
    
begin
    tie_low_0: tie_low port map(b0);


    -- NOTE: Make sure to add these back if the dlatches fail.
    -- connect cpu_add to 6 bit register
    -- ce is whatever enables the address register, same for rst
    -- wire_to_cache is a 5 downto 0 vector that goes to tag comparator (hit miss) and cache_block index/offset
    -- reg_cpu_add: dffer6 port map(cpu_add, clk, start, reset, cpu_add_stored, open);
    latch_cpu_add: dlatch6 port map(cpu_add, start, cpu_add_stored, open);

    -- ce/rst same as cpu_add
    -- wire_to_sm connects to state machine for read/write
    -- reg_cpu_rd_wrn: dffer port map(cpu_rd_wrn, clk, start, reset, cpu_rd_wrn_stored, open);
    latch_cpu_rd_wrn: Dlatch port map(cpu_rd_wrn, start, cpu_rd_wrn_stored, open);

    -- ce/rst same as cpu_add
    -- no clue where this goes directly with somewhere
    -- reg_cpu_data: dffer8 port map(cpu_data, clk, start, reset, cpu_data_stored, open);
    latch_cpu_data: dlatch8 port map(cpu_data, start, cpu_data_stored, open);

    sm: statemachine port map(
        clk, 
        cpu_rd_wrn_stored, start, reset, 
        shiftreg_done, 
        hit_miss, 
        cpu_add_stored(1), cpu_add_stored(0), 
        busy, 
        shiftreg_input, shiftreg_rst, 
        cpu_data_oe, mem_add_oe, 
        mem_en, 
        cb_ce, --cb_ce_adj, cb_ce_inv, TODO
        cb_rd_wr, cb_offset1, cb_offset0, 
        tb_ce, tb_rd_wr, 
        valid_ce, valid_ce_all, valid_rd_wr, valid_d_wr,
        cb_d_wr_control
    );


    counter: shiftreg8 port map(clk, shiftreg_input, shiftreg_rst, shiftreg_q);
    buff_shiftreg_done: buff port map(shiftreg_q(6), shiftreg_done);
    
    -- Select between cpu_data and mem_data
    mux2_0: mux2 port map(cpu_data_stored(0), mem_data(0), cb_d_wr_control, cb_d_wr(0));
    mux2_1: mux2 port map(cpu_data_stored(1), mem_data(1), cb_d_wr_control, cb_d_wr(1));
    mux2_2: mux2 port map(cpu_data_stored(2), mem_data(2), cb_d_wr_control, cb_d_wr(2));
    mux2_3: mux2 port map(cpu_data_stored(3), mem_data(3), cb_d_wr_control, cb_d_wr(3));
    mux2_4: mux2 port map(cpu_data_stored(4), mem_data(4), cb_d_wr_control, cb_d_wr(4));
    mux2_5: mux2 port map(cpu_data_stored(5), mem_data(5), cb_d_wr_control, cb_d_wr(5));
    mux2_6: mux2 port map(cpu_data_stored(6), mem_data(6), cb_d_wr_control, cb_d_wr(6));
    mux2_7: mux2 port map(cpu_data_stored(7), mem_data(7), cb_d_wr_control, cb_d_wr(7));
    
    --cb_ce_gen_0: cb_ce_gen port map(cb_ce, cb_ce_adj, cb_ce_inv, clk, cb_ce_out);
    cb: cache_block port map(
        cb_d_wr, cb_ce, cb_rd_wr, -- cb_ce_out->cb_ce TODO
        cpu_add_stored(2), cpu_add_stored(3), cb_offset0, cb_offset1,
        cb_d_rd, clk
    );

    bus_creator2_tb_d_wr: bus_creator2 port map(cpu_add_stored(5), cpu_add_stored(4), tb_d_wr);
    tb: tag_block port map(tb_d_wr, tb_ce, tb_rd_wr, cpu_add_stored(2), cpu_add_stored(3), tb_d_rd, clk);

    valid_ce_gen_0: valid_ce_gen port map(
        cpu_add_stored(2), cpu_add_stored(3),
        valid_ce, valid_ce_all, 
        valid_ce0, valid_ce1, valid_ce2, valid_ce3
    );
    valid0: cache_cell1 port map(valid_d_wr, valid_ce0, valid_rd_wr, valid_d_rd, clk);
    valid1: cache_cell1 port map(valid_d_wr, valid_ce1, valid_rd_wr, valid_d_rd, clk);
    valid2: cache_cell1 port map(valid_d_wr, valid_ce2, valid_rd_wr, valid_d_rd, clk);
    valid3: cache_cell1 port map(valid_d_wr, valid_ce3, valid_rd_wr, valid_d_rd, clk);

    bus_creator2_hm_tag: bus_creator2 port map(cpu_add_stored(3), cpu_add_stored(2), hm_tag);
    hm: hit_miss_detector port map(tb_d_rd, hm_tag, valid_d_rd, hit_miss);
    
    oe_cpu_data: output_enable8 port map(cb_d_rd, cpu_data_oe, cpu_data);

    bus_creator6_mem_add: bus_creator6 port map(
        cpu_add_stored(5), 
        cpu_add_stored(4), 
        cpu_add_stored(3), 
        cpu_add_stored(2), 
        b0, b0,
        mem_add_out
    );
    oe_mem_add: output_enable6 port map(mem_add_out, mem_add_oe, mem_add);

end structural;
