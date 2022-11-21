library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity encoder16to4 is
    port(
        input0      : in std_logic;
        input1      : in std_logic;
        input2      : in std_logic;
        input3      : in std_logic;
        input4      : in std_logic;
        input5      : in std_logic;
        input6      : in std_logic;
        input7      : in std_logic;
        input8      : in std_logic;
        input9      : in std_logic;
        input10     : in std_logic;
        input11     : in std_logic;
        input12     : in std_logic;
        input13     : in std_logic;
        input14     : in std_logic;
        input15     : in std_logic;
        output      : out std_logic_vector(3 downto 0)
    );
end encoder16to4;

architecture structural of encoder16to4 is
    component or4
        port(
            input1: in std_logic;
            input2: in std_logic;
            input3: in std_logic;
            input4: in std_logic;
            output: out std_logic
        );
    end component;

    component or2
        port(
            input1: in std_logic;
            input2: in std_logic;
            output: out std_logic
        );
    end component;

    for or4_0, or4_1, or4_2, or4_3, or4_4, or4_5, 
        or4_6, or4_7: or4 use entity work.or4(structural); 
    
    for or2_0, or2_1, or2_2, or2_3: or2 use entity work.or2(structural);

    signal a,b,c,d,e,f,g,h: std_logic;


begin
    -- o0 = odds
    or4_0 : or4 port map(input1, input3, input5, input7, a);
    or4_1 : or4 port map(input9, input11, input13, input15, b);
    or2_0 : or2 port map(a,b, output(0));

    -- o1 = 2,3,6,7,10,11,14,15,18,19,22,23,26,27,30,31
    or4_2 : or4 port map(input2, input3, input6, input7, c);
    or4_3 : or4 port map(input10, input11, input14, input15, d);
    or2_1 : or2 port map(c,d, output(1));

    -- o2 = 4-7, 12-15, 20-23, 28-31
    or4_4 : or4 port map(input4, input5, input6, input7, e);
    or4_5 : or4 port map(input12, input13, input14, input15, f);
    or2_2 : or2 port map(e,f, output(2));

    -- o3 = 8-15, 24-31
    or4_6 : or4 port map(input8, input9, input10, input11, g);
    or4_7 : or4 port map(input12, input13, input14, input15, h);
    or2_3 : or2 port map(g,h, output(3));

end structural;
