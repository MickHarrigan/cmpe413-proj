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
        ceg:        out std_logic
    );
end cb_ce_gen;

architecture structural of cb_ce_gen is
    component mux2
        port(
            input0  : in std_logic;
            input1  : in std_logic;
            s       : in std_logic;
            output  : out std_logic
        );
    end component;


begin

end structural;
