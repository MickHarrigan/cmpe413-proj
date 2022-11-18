library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity decoder5to32 is
    port(
        input0      : in std_logic_vector(4 downto 0);
        output0     : out std_logic;
        output1     : out std_logic;
        output2     : out std_logic;
        output3     : out std_logic;
        output4     : out std_logic;
        output5     : out std_logic;
        output6     : out std_logic;
        output7     : out std_logic;
        output8     : out std_logic;
        output9     : out std_logic;
        output10    : out std_logic;
        output11    : out std_logic;
        output12    : out std_logic;
        output13    : out std_logic;
        output14    : out std_logic;
        output15    : out std_logic;
        output16    : out std_logic;
        output17    : out std_logic;
        output18    : out std_logic;
        output19    : out std_logic;
        output20    : out std_logic;
        output21    : out std_logic;
        output22    : out std_logic;
        output23    : out std_logic;
        output24    : out std_logic;
        output25    : out std_logic;
        output26    : out std_logic;
        output27    : out std_logic;
        output28    : out std_logic;
        output29    : out std_logic;
        output30    : out std_logic;
        output31    : out std_logic;
    );
end decoder5to32;

architecture structural of decoder5to32 is
    -- components
    component and5
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            input3  : in std_logic;
            input4  : in std_logic;
            input5  : in std_logic;
            output  : out std_logic
        );
    end component;

    component inverter
        port(
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

    for inv_0, inv_1, inv_2, inv_3, inv_4: inverter use entity work.inverter(structural);
    for and5_0, and5_1, and5_2, and5_3, and5_4, and5_5, and5_6, and5_7, and5_8,
    and5_9, and5_10, and5_11, and5_12, and5_13, and5_14, and5_15, and5_16, and5_17,
    and5_18, and5_19, and5_20, and5_21, and5_22, and5_23, and5_24, and5_25, and5_26,
    and5_27, and5_28, and5_29, and5_30, and5_31: and5 use entity work.and5(structural);
    
    signal in0n, in1n, in2n, in3n, in4n: std_logic;

begin
    inv_0: inverter port map(input0, in0n);
    inv_1: inverter port map(input1, in1n);
    inv_2: inverter port map(input2, in2n);
    inv_3: inverter port map(input3, in3n);
    inv_4: inverter port map(input4, in4n);

    and5_0:         and5 port map(in0n, in1n, in2n, in3n, in4n, output0);
    and5_1:         and5 port map(input0, in1n, in2n, in3n, in4n, output1);
    and5_2:         and5 port map(in0n, input1, in2n, in3n, in4n, output2);
    and5_3:         and5 port map(input0, input1, in2n, in3n, in4n, output3);
    and5_4:         and5 port map(in0n, in1n, input2, in3n, in4n, output4);
    and5_5:         and5 port map(input0, in1n, input2, in3n, in4n, output5);
    and5_6:         and5 port map(in0n, input1, input2, in3n, in4n, output6);
    and5_7:         and5 port map(input0, input1, input2, in3n, in4n, output7);
    and5_8:         and5 port map(in0n, in1n, in2n, input3, in4n, output8);
    and5_9:         and5 port map(input0, in1n, in2n, input3, in4n, output9);
    and5_10:        and5 port map(in0n, input1, in2n, input3, in4n, output10);
    and5_11:        and5 port map(input0, input1, in2n, input3, in4n, output11);
    and5_12:        and5 port map(in0n, in1n, input2, input3, in4n, output12);
    and5_13:        and5 port map(input0, in1n, input2, input3, in4n, output13);
    and5_14:        and5 port map(in0n, input1, input2, input3, in4n, output14);
    and5_15:        and5 port map(input0, input1, input2, input3, in4n, output15);
    and5_16:        and5 port map(in0n, in1n, in2n, in3n, input4, output16);
    and5_17:        and5 port map(input0, in1n, in2n, in3n, input4, output17);
    and5_18:        and5 port map(in0n, input1, in2n, in3n, input4, output18);
    and5_19:        and5 port map(input0, input1, in2n, in3n, input4, output19);
    and5_20:        and5 port map(in0n, in1n, input2, in3n, input4, output20);
    and5_21:        and5 port map(input0, in1n, input2, in3n, input4, output21);
    and5_22:        and5 port map(in0n, input1, input2, in3n, input4, output22);
    and5_23:        and5 port map(input0, input1, input2, in3n, input4, output23);
    and5_24:        and5 port map(in0n, in1n, in2n, input3, input4, output24);
    and5_25:        and5 port map(input0, in1n, in2n, input3, input4, output25);
    and5_26:        and5 port map(in0n, input1, in2n, input3, input4, output26);
    and5_27:        and5 port map(input0, input1, in2n, input3, input4, output27);
    and5_28:        and5 port map(in0n, in1n, input2, input3, input4, output28);
    and5_29:        and5 port map(input0, in1n, input2, input3, input4, output29);
    and5_30:        and5 port map(in0n, input1, input2, input3, input4, output30);
    and5_31:        and5 port map(input0, input1, input2, input3, input4, output31);



end structural;

