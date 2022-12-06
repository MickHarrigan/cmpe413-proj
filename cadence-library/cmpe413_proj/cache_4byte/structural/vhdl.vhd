-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


architecture structural of cache_4byte is
    -- components
    component cache_cell8
        port(
            d_wr    : in std_logic_vector(7 downto 0);
            ce      : in std_logic;
            rd_wr   : in std_logic;
            d_rd    : out std_logic_vector(7 downto 0);
            clk     : in std_logic
        );
    end component;

    component decoder2to4
        port(
            input0  : in std_logic;
            input1  : in std_logic;
            output0 : out std_logic;
            output1 : out std_logic;
            output2 : out std_logic;
            output3 : out std_logic
        );
    end component;

    component and2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );
    end component;


    for cell8_0, cell8_1, cell8_2, cell8_3: cache_cell8 use entity work.cache_cell8(structural);
    for decoder: decoder2to4 use entity work.decoder2to4(structural);
    for and2_0, and2_1, and2_2, and2_3: and2 use entity work.and2(structural);

    signal ce0, ce1, ce2, ce3: std_logic;

    signal ce0g, ce1g, ce2g, ce3g: std_logic;

begin
    decoder: decoder2to4 port map(a0, a1, ce0, ce1, ce2, ce3);
    and2_0: and2 port map(ce, ce0, ce0g);
    and2_1: and2 port map(ce, ce1, ce1g);
    and2_2: and2 port map(ce, ce2, ce2g);
    and2_3: and2 port map(ce, ce3, ce3g);
    cell8_0: cache_cell8 port map(d_wr, ce0g, rd_wr, d_rd, clk);
    cell8_1: cache_cell8 port map(d_wr, ce1g, rd_wr, d_rd, clk);
    cell8_2: cache_cell8 port map(d_wr, ce2g, rd_wr, d_rd, clk);
    cell8_3: cache_cell8 port map(d_wr, ce3g, rd_wr, d_rd, clk);


end structural;