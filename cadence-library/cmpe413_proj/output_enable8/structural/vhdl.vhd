-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


architecture structural of output_enable8 is
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

    for tx_0, tx_1, tx_2, tx_3, tx_4, tx_5, tx_6, tx_7: tx use entity work.tx(structural);
    for inv: inverter use entity work.inverter(structural);

    signal oe_n: std_logic;

begin
    inv: inverter port map(oe, oe_n);

    tx_0: tx port map(oe, oe_n, input(0), output(0));
    tx_1: tx port map(oe, oe_n, input(1), output(1));
    tx_2: tx port map(oe, oe_n, input(2), output(2));
    tx_3: tx port map(oe, oe_n, input(3), output(3));
    tx_4: tx port map(oe, oe_n, input(4), output(4));
    tx_5: tx port map(oe, oe_n, input(5), output(5));
    tx_6: tx port map(oe, oe_n, input(6), output(6));
    tx_7: tx port map(oe, oe_n, input(7), output(7));

end structural;
