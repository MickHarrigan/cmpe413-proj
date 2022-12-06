-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Tue Nov 29 13:43:40 2022


architecture structural of bus_creator6 is
    component buff
        port(
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

    for buff_0, buff_1, buff_2, buff_3, buff_4, buff_5: buff use entity work.buff(structural);

begin

    buff_0: buff port map(input0, output(0));
    buff_1: buff port map(input1, output(1));
    buff_2: buff port map(input2, output(2));
    buff_3: buff port map(input3, output(3));
    buff_4: buff port map(input4, output(4));
    buff_5: buff port map(input5, output(5));

end structural;
