library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity decoder2to4 is
    port(
        input0  : in std_logic;
        input1  : in std_logic;
        output0 : out std_logic;
        output1 : out std_logic;
        output2 : out std_logic;
        output3 : out std_logic
    );
end decoder2to4;

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
    and2_1: and2 port map(in0n, input1, output1);
    and2_2: and2 port map(input0, in1n, output2);
    and2_3: and2 port map(input0, input1, output3);

end structural;
