-- 5 bit comparator (different types of inputs)
-- outputs 1 when input1 and all equivalent bits of input2 are equal

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity comparator5s is
    port(
        input1      : in std_logic_vector(4 downto 0);
        input2_0    : in std_logic;
        input2_1    : in std_logic;
        input2_2    : in std_logic;
        input2_3    : in std_logic;
        input2_4    : in std_logic;
        output      : out std_logic
    );
end comparator5s;

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