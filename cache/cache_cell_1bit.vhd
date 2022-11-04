library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity cache_cell_1bit is
    port(
        d_wr:   in std_logic;
        ce:     in std_logic;
        rd_wr:  in std_logic;
        d_rd:   out std_logic
    );
end cache_cell_1bit;

architecture structural of cache_cell_1bit is
    component Dlatch
        port(
            d:      in std_logic;
            clk:    in std_logic;
            q:      out std_logic;
            qbar:   out std_logic
        );
    end component;

    component tx
        port(
            sel:    in std_logic;
            selnot: in std_logic;
            input:  in std_logic;
            output: out std_logic
        );
    end component;

    component inverter
        port(
            input:  in std_logic;
            output: out std_logic
        );
    end component;

    component cache_decoder
        port(
            ce:     in std_logic;
            rd_wr:  in std_logic;
            we:     out std_logic;
            re:     out std_logic
        );
    end component;

    for Dlatch_0: Dlatch use entity work.Dlatch(structural);
    for tx_0: tx use entity work.tx(structural);
    for inverter_0: inverter use entity work.inverter(structural);
    for cache_decoder_0: cache_decoder use entity work.cache_decoder(structural);
    
    signal we: std_logic;
    signal re: std_logic;
    signal re_n: std_logic;
    signal q: std_logic;
    
    begin

    Dlatch_0: Dlatch port map(d_wr, we, q, open);

    tx_0: tx port map(re, re_n, q, d_rd);

    inverter_0: inverter port map(re, re_n);

    cache_decoder_0: cache_decoder port map(ce, rd_wr, we, re);

end structural;
