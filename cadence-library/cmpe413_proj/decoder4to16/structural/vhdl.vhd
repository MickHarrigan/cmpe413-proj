-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Tue Nov 29 13:43:40 2022


architecture structural of decoder4to16 is
    -- components
    component decoder3to8
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
    end component;

    component inverter
        port(
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

    for dec3to8_0, dec3to8_1: decoder3to8 use entity work.decoder3to8(structural);
    for inv_0: inverter use entity work.inverter(structural);
    
    signal input3bar: std_logic;

begin

    inv_0: inverter port map(input(3), input3bar);
    
    dec3to8_0: decoder3to8 port map(input3bar, input(0), input(1), input(2), output0, output1, output2, output3, output4, output5, output6, output7);
    dec3to8_1: decoder3to8 port map(input(3), input(0), input(1), input(2), output8, output9, output10, output11, output12, output13, output14, output15);

end structural;
