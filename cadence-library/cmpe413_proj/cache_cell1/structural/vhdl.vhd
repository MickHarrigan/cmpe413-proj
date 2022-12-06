-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


architecture structural of cache_cell1 is
    component dffer
        port(
            d       : in std_logic;
            clk     : in std_logic;
            ce      : in std_logic;
            rst     : in std_logic;
            q       : out std_logic;
            qbar    : out std_logic
        );
    end component;

    component tx
        port(
            sel     : in std_logic;
            selnot  : in std_logic;
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

    component inverter
        port(
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

    component cache_decoder
        port(
            ce      : in std_logic;
            rd_wr   : in std_logic;
            we      : out std_logic;
            re      : out std_logic
        );
    end component;

    component tie_low
        port(
            output: out std_logic
        );
    end component;

    for dffer_0: dffer use entity work.dffer(structural);
    for tx_0: tx use entity work.tx(structural);
    for inverter_0, inverter_1: inverter use entity work.inverter(structural);
    for cache_decoder_0: cache_decoder use entity work.cache_decoder(structural);
    for tie_low_0: tie_low use entity work.tie_low(structural);
    
    signal we, re, re_n, q, b0, clkn: std_logic;
    
begin
    tie_low_0: tie_low port map(b0);

    inverter_0: inverter port map(clk, clkn);

    dffer_0: dffer port map(d_wr, clkn, we, b0, q, open);

    tx_0: tx port map(re, re_n, q, d_rd);

    inverter_1: inverter port map(re, re_n);

    cache_decoder_0: cache_decoder port map(ce, rd_wr, we, re);

end structural;
