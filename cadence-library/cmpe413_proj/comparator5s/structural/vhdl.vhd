-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Tue Nov 29 13:43:40 2022


architecture structural of comparator5s is
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

    component or4
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            input3  : in std_logic;
            input4  : in std_logic;
            output  : out std_logic
        );
    end component;

    for xor2_0, xor2_1, xor2_2, xor2_3, xor2_4: xor2 use entity work.xor2(structural);
    for nor2_0: nor2 use entity work.nor2(structural);
    for or4_0: or4 use entity work.or4(structural);

    signal a,b,c,d,e,f: std_logic;

begin
    xor2_0: xor2 port map(input1(0), input2_0, a);
    xor2_1: xor2 port map(input1(1), input2_1, b);
    xor2_2: xor2 port map(input1(2), input2_2, c);
    xor2_3: xor2 port map(input1(3), input2_3, d);
    xor2_4: xor2 port map(input1(4), input2_4, e);

    or4_0: or4 port map(a, b, c, d, f);

    nor2_0: nor2 port map(f, e, output);

end structural;