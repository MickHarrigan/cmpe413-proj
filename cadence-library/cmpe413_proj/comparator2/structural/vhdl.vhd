-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Tue Nov 29 13:43:40 2022


architecture structural of comparator2 is
    component xor2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );
    end component;

    component nor2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );
    end component;

    for xor2_0, xor2_1: xor2 use entity work.xor2(structural);
    for nor2_0: nor2 use entity work.nor2(structural);

    signal x, y: std_logic;

begin
    xor2_0: xor2 port map(input1(0), input2(0), x);
    xor2_1: xor2 port map(input1(1), input2(1), y);

    nor2_0: nor2 port map(x, y, output);

end structural;
