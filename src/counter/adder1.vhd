-- 1-bit full adder

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity adder1 is
    port(
        input1      : in std_logic;
        input2      : in std_logic;
        carryin     : in std_logic;
        sum         : out std_logic;
        carryout    : out std_logic
    );
end adder1;

architecture structural of adder1 is
    component xor2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );
    end component;

    component and2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );
    end component;

    component or3
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            input3  : in std_logic;
            output  : out std_logic
        );
    end component;

    for xor2_1, xor2_2: xor2 use entity work.xor2(structural);
    for and2_1, and2_2, and2_3: and2 use entity work.and2(structural);
    for or3_1: or3 use entity work.or3(structural);

    signal temp1, temp2, temp3, temp4: std_logic;

begin
    xor2_1: xor2 port map (input1, input2, temp1);
    xor2_2: xor2 port map (carryin, temp1, sum);

    and2_1: and2 port map (input1, input2, temp2);
    and2_2: and2 port map (input1, carryin, temp3);
    and2_3: and2 port map (input2, carryin, temp4);

    or3_1: or3 port map (temp2, temp3, temp4, carryout);

end structural;
