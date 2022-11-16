-- Negative edge-triggered 5-bit up-counter

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity counter5 is
    port(
        clk : in std_logic;
        ce  : in std_logic;
        rst : in std_logic;
        q   : out std_logic_vector(4 downto 0)
    );
end counter5;

architecture structural of counter5 is
    component dffer5
        port(
            d       : in std_logic_vector(4 downto 0);
            clk     : in std_logic;
            ce      : in std_logic;
            rst     : in std_logic;
            q       : out std_logic_vector(4 downto 0);
            qbar    : out std_logic_vector(4 downto 0)
        );
    end component;

    component adder5
        port(
            input1      : in std_logic_vector(4 downto 0);
            input2      : in std_logic_vector(4 downto 0);
            carryin     : in std_logic;
            sum         : out std_logic_vector(4 downto 0);
            carryout    : out std_logic
        );
    end component;

    component buff
        port(
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

    component buff5
        port(
            input   : in std_logic_vector(4 downto 0);
            output  : out std_logic_vector(4 downto 0)
        );
    end component;

    component tie_high
        port(
            output: out std_logic
        );
    end component;

    component tie_low
        port(
            output: out std_logic
        );
    end component;

    for dffer5_0: dffer5 use entity work.dffer5(structural);
    for adder5_0: adder5 use entity work.adder5(structural);
    for buff_0, buff_1, buff_2, buff_3, buff_4: buff use entity work.buff(structural);
    for buff5_0: buff5 use entity work.buff5(structural);
    for tie_high_0: tie_high use entity work.tie_high(structural);
    for tie_low_0: tie_low use entity work.tie_low(structural);

    signal inc, d, qi: std_logic_vector(4 downto 0);
    signal one, zero: std_logic;

begin
    tie_high_0: tie_high port map(one);
    tie_low_0: tie_low port map(zero);

    -- Generate 5-bit number with value 1
    buff_0: buff port map(one, inc(0));
    buff_1: buff port map(zero, inc(1));
    buff_2: buff port map(zero, inc(2));
    buff_3: buff port map(zero, inc(3));
    buff_4: buff port map(zero, inc(4));

    adder5_0: adder5 port map(qi, inc, zero, d, open);

    dffer5_0: dffer5 port map(d, clk, ce, rst, qi, open);

    buff5_0: buff5 port map(qi, q);

end structural;

