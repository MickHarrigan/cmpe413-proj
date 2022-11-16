-- Generate ce for cache block
-- Normally, ce is controlled directly by the state machine and is set once at 
-- the beginning of a clock cycle. During states 24-31, ce is adjusted halfway 
-- through a clock cycle.

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity cb_ce_gen is
    port(
        cb_ce:      in std_logic;
        cb_ce_adj:  in std_logic;
        cb_ce_inv:  in std_logic;
        clk:        in std_logic;
        cb_ce_out:  out std_logic
    );
end cb_ce_gen;

architecture structural of cb_ce_gen is
    component and2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );
    end component;

    component xor2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
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

    for and2_0: and2 use entity work.and2(structural);
    for xor2_0: xor2 use entity work.xor2(structural);
    for mux2_0: mux2 use entity work.mux2(structural);

    signal cea, ceg: std_logic;

begin
    and2_0: and2 port map(cb_ce, clk, cea);

    xor2_0: xor2 port map(cb_ce_inv, cea, ceg);

    mux2_0: mux2 port map(ceg, cb_ce, cb_ce_adj, cb_ce_out);

end structural;
