-- Negative edge-triggered DFF with chip enable and synchronous reset

library STD;
library IEEE;                      
use IEEE.std_logic_1164.all;

entity dffer is
    port(
        d       : in std_logic;
        clk     : in std_logic;
        ce      : in std_logic;
        rst     : in std_logic;
        q       : out std_logic;
        qbar    : out std_logic
    );
end dffer;

architecture structural of dffer is
    component dff
        port(
            d       : in std_logic;
            clk     : in std_logic;
            q       : out std_logic;
            qbar    : out std_logic
        );
    end component;

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

    component mux2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            s       : in std_logic;
            output  : out std_logic
        );
    end component;

    component buff
        port(
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

    for dff_0: dff use entity work.dff(structural);
    for and2_0: and2 use entity work.and2(structural);
    for inverter_0: inverter use entity work.inverter(structural);
    for mux2_0: mux2 use entity work.mux2(structural);
    for buff_0: buff use entity work.buff(structural);

    signal rstn, de, dg, qi: std_logic;

begin
    inverter_0: inverter port map(rst, rstn);

    mux2_0: mux2 port map(d, qi, ce, de);

    and2_0: and2 port map(de, rstn, dg);

    dff_0: dff port map(dg, clk, qi, qbar);

    buff_0: buff port map(qi, q);

end structural;
