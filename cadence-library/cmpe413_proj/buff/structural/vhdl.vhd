-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Tue Nov 29 13:43:40 2022


architecture structural of buff is
    component inverter
        port(
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

    for inverter_0, inverter_1: inverter use entity work.inverter(structural);
    
    signal x: std_logic;

begin
    inverter_0: inverter port map(input, x);
    inverter_1: inverter port map(x, output);

end structural;
