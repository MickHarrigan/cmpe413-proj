-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


architecture structural of buff5 is
    component buff
        port(
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

    for buff_0, buff_1, buff_2, buff_3, buff_4: buff use entity work.buff(structural);

begin
   buff_0: buff port map(input(0), output(0));
   buff_1: buff port map(input(1), output(1));
   buff_2: buff port map(input(2), output(2));
   buff_3: buff port map(input(3), output(3));
   buff_4: buff port map(input(4), output(4));

end structural;
