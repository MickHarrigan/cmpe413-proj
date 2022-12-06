-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Tue Nov 29 13:43:40 2022


architecture structural of decoder2to4 is 
    -- components
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

    for and2_0, and2_1, and2_2, and2_3: and2 use entity work.and2(structural);
    for inv_0, inv_1: inverter use entity work.inverter(structural);

    -- optional wires
    signal in0n: std_logic;
    signal in1n: std_logic;

begin
    inv_0: inverter port map(input0, in0n);
    inv_1: inverter port map(input1, in1n);

    and2_0: and2 port map(in0n, in1n, output0);
    and2_1: and2 port map(input0, in1n, output1);
    and2_2: and2 port map(in0n, input1, output2);
    and2_3: and2 port map(input0, input1, output3);

end structural;
