library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity encoder32to5 is
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
        input16     : in std_logic;
        input17     : in std_logic;
        input18     : in std_logic;
        input19     : in std_logic;
        input20     : in std_logic;
        input21     : in std_logic;
        input22     : in std_logic;
        input23     : in std_logic;
        input24     : in std_logic;
        input25     : in std_logic;
        input26     : in std_logic;
        input27     : in std_logic;
        input28     : in std_logic;
        input29     : in std_logic;
        input30     : in std_logic;
        input31     : in std_logic;
        output      : out std_logic_vector(4 downto 0)
    );
end encoder32to5;

architecture structural of encoder32to5 is
    component or4
        port(
            input1: in std_logic;
            input2: in std_logic;
            input3: in std_logic;
            input4: in std_logic;
            output: out std_logic
        );
    end component;

    for or4_0, or4_1, or4_2, or4_3, or4_4, or4_5, 
        or4_6, or4_7, or4_8, or4_9, or4_10, or4_11, 
        or4_12, or4_13, or4_14, or4_15, or4_16, or4_17, 
        or4_18, or4_19, or4_20, or4_21, or4_22, or4_23, 
        or4_24: or4 use entity work.or4(structural); 

    signal a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,w,x,y,z: std_logic;


begin
    -- o0 = odds
    or4_0 : or4 port map(input1, input3, input5, input7, a);
    or4_1 : or4 port map(input9, input11, input13, input15, b);
    or4_2 : or4 port map(input17, input19, input21, input23, c);
    or4_3 : or4 port map(input25, input27, input29, input31, d);
    or4_4 : or4 port map(a,b,c,d, output0(0));

    -- o1 = 2,3,6,7,10,11,14,15,18,19,22,23,26,27,30,31
    or4_5 : or4 port map(input2, input3, input6, input7, e);
    or4_6 : or4 port map(input10, input11, input14, input15, f);
    or4_7 : or4 port map(input18, input19, input22, input23, g);
    or4_8 : or4 port map(input26, input27, input30, input31, h);
    or4_9 : or4 port map(e,f,g,h, output0(1));

    -- o2 = 4-7, 12-15, 20-23, 28-31
    or4_10 : or4 port map(input4, input5, input6, input7, i);
    or4_11 : or4 port map(input12, input13, input14, input15, j);
    or4_12 : or4 port map(input20, input21, input22, input23, k);
    or4_13 : or4 port map(input28, input29, input30, input31, l);
    or4_14 : or4 port map(i,j,k,l, output0(2));

    -- o3 = 8-15, 24-31
    or4_15 : or4 port map(input8, input9, input10, input11, m);
    or4_16 : or4 port map(input12, input13, input14, input15, n);
    or4_17 : or4 port map(input24, input25, input26, input27, o);
    or4_18 : or4 port map(input28, input29, input30, input31, p);
    or4_19 : or4 port map(m,n,o,p, output0(3));

    -- o4 = 16-31
    or4_20 : or4 port map(input16, input17, input18, input19, w);
    or4_21 : or4 port map(input20, input21, input22, input23, x);
    or4_22 : or4 port map(input24, input25, input26, input27, y);
    or4_23 : or4 port map(input28, input29, input30, input31, z);
    or4_24 : or4 port map(w,x,y,z, output0(4));

end structural;