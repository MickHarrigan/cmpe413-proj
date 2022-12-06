-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


architecture structural of cache_cell8 is
    component cache_cell1
        port(
            d_wr    : in std_logic;
            ce      : in std_logic;
            rd_wr   : in std_logic;
            d_rd    : out std_logic;
            clk     : in std_logic
        );
    end component;

    for cache_cell1_0, cache_cell1_1, cache_cell1_2, cache_cell1_3,
        cache_cell1_4, cache_cell1_5, cache_cell1_6, cache_cell1_7
        : cache_cell1 use entity work.cache_cell1(structural);
    
begin
        cache_cell1_0: cache_cell1 port map(d_wr(0), ce, rd_wr, d_rd(0), clk);
        cache_cell1_1: cache_cell1 port map(d_wr(1), ce, rd_wr, d_rd(1), clk);
        cache_cell1_2: cache_cell1 port map(d_wr(2), ce, rd_wr, d_rd(2), clk);
        cache_cell1_3: cache_cell1 port map(d_wr(3), ce, rd_wr, d_rd(3), clk);
        cache_cell1_4: cache_cell1 port map(d_wr(4), ce, rd_wr, d_rd(4), clk);
        cache_cell1_5: cache_cell1 port map(d_wr(5), ce, rd_wr, d_rd(5), clk);
        cache_cell1_6: cache_cell1 port map(d_wr(6), ce, rd_wr, d_rd(6), clk);
        cache_cell1_7: cache_cell1 port map(d_wr(7), ce, rd_wr, d_rd(7), clk);

end structural;
