library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity decoder3to8 is
    port(
        en      : in std_logic;
        input0  : in std_logic;
        input1  : in std_logic;
        input2  : in std_logic;
        output0 : out std_logic;
        output1 : out std_logic;
        output2 : out std_logic;
        output3 : out std_logic;
        output4 : out std_logic;
        output5 : out std_logic;
        output6 : out std_logic;
        output7 : out std_logic
    );
end decoder3to8;

architecture structural of decoder3to8 is
    component and3
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            input3  : in std_logic;
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

    component inverter
        port(
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

    for and3_0, and3_1, and3_2, and3_3, and3_4, and3_5, and3_6, and3_7: and3 use entity work.and3(structural);
    for and2_0, and2_1, and2_2, and2_3, and2_4, and2_5, and2_6, and2_7: and2 use entity work.and2(structural);
    for inv_0, inv_1, inv_2: inverter use entity work.inverter(structural);

    signal in0n, in1n, in2n: std_logic;
    signal o0, o1, o2, o3, o4, o5, o6, o7: std_logic;

begin

    inv_0: inverter port map(input0, in0n);
    inv_1: inverter port map(input1, in1n);
    inv_2: inverter port map(input2, in2n);

    and3_0: and3 port map(in0n, in1n, in2n, o0);
    and3_1: and3 port map(input0, in1n, in2n, o1);
    and3_2: and3 port map(in0n, input1, in2n, o2);
    and3_3: and3 port map(input0, input1, in2n, o3);
    and3_4: and3 port map(in0n, in1n, input2, o4);
    and3_5: and3 port map(input0, in1n, input2, o5);
    and3_6: and3 port map(in0n, input1, input2, o6);
    and3_7: and3 port map(input0, input1, input2, o7);

    and2_0: and2 port map(o0, en, output0);
    and2_1: and2 port map(o1, en, output1);
    and2_2: and2 port map(o2, en, output2);
    and2_3: and2 port map(o3, en, output3);
    and2_4: and2 port map(o4, en, output4);
    and2_5: and2 port map(o5, en, output5);
    and2_6: and2 port map(o6, en, output6);
    and2_7: and2 port map(o7, en, output7);

end structural;