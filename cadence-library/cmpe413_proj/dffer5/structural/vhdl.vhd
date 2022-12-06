-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


architecture structural of dffer5 is
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

    for dffer_0, dffer_1, dffer_2, dffer_3, dffer_4
        : dffer use entity work.dffer(structural);

begin
    dffer_0: dffer port map(d(0), clk, ce, rst, q(0), qbar(0));
    dffer_1: dffer port map(d(1), clk, ce, rst, q(1), qbar(1));
    dffer_2: dffer port map(d(2), clk, ce, rst, q(2), qbar(2));
    dffer_3: dffer port map(d(3), clk, ce, rst, q(3), qbar(3));
    dffer_4: dffer port map(d(4), clk, ce, rst, q(4), qbar(4));

end structural;
