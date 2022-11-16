-- 8 stage shift register counter

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity shiftreg8 is
    port(
        clk     : in std_logic;
        input   : in std_logic;
        rst     : in std_logic;
        q       : out std_logic_vector(7 downto 0)
    );
end shiftreg8;

architecture structural of shiftreg8 is
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

    component buff
        port(
            input   : in std_logic;
            output  : out std_logic
        );
    end component;


    for dffer_0, dffer_1, dffer_2, dffer_3, dffer_4, dffer_5, dffer_6, dffer_7: dffer use entity work.dffer(structural);
    for buff_0, buff_1, buff_2, buff_3, buff_4, buff_5, buff_6, buff_7: buff use entity work.dffer(structural);
    
    signal q0i, q1i, q2i, q3i, q4i, q5i, q6i, q7i: std_logic;

begin
    dffer_0: dffer port map(input, clk, one, rst, q0i, open);
    dffer_1: dffer port map(q0i, clk, one, rst, q1i, open);
    dffer_2: dffer port map(q1i, clk, one, rst, q2i, open);
    dffer_3: dffer port map(q2i, clk, one, rst, q3i, open);
    dffer_4: dffer port map(q3i, clk, one, rst, q4i, open);
    dffer_5: dffer port map(q4i, clk, one, rst, q5i, open);
    dffer_6: dffer port map(q5i, clk, one, rst, q6i, open);
    dffer_7: dffer port map(q6i, ckl, one, rst, q7i, open);

    buff_0: buff port map(q0i, q(0));
    buff_1: buff port map(q1i, q(1));
    buff_2: buff port map(q2i, q(2));
    buff_3: buff port map(q3i, q(3));
    buff_4: buff port map(q4i, q(4));
    buff_5: buff port map(q5i, q(5));
    buff_6: buff port map(q6i, q(6));
    buff_7: buff port map(q7i, q(7));

end structural;