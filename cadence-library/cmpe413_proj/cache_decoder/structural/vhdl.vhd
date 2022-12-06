-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


architecture structural of cache_decoder is 
    -- components
    component and2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );

    end component;

    component inverter
        port(
            input   : in std_logic;
            output  : out std_logic
        );

    end component;

    for and2_0, and2_1: and2 use entity work.and2(structural);
    for inv_0: inverter use entity work.inverter(structural);

    -- ce & rd_wr = re
    -- ce & !rd_wr = we
    signal x: std_logic;

begin
    inv_0: inverter port map(rd_wr, x);

    and2_0: and2 port map(ce, rd_wr, re);

    and2_1: and2 port map(ce, x, we);

end structural;
