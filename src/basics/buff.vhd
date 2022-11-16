-- Buffer using 2 inverters

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity buff is
    port(
        input   : in std_logic;
        output  : out std_logic
    );
end buff;

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
