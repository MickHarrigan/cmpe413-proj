-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


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
