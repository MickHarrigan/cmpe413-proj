-- 2 bit bus creator, converts 2 input bits to a single bus

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity bus_creator2 is
    port(
        input1  : in std_logic;
        input0  : in std_logic;
        output  : out std_logic_vector(1 downto 0)
    );
end bus_creator2;

architecture structural of bus_creator2 is
    component buff
        port(
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

    for buff_0, buff_1: buff use entity work.buff(structural);

begin

    buff_0: buff port map(input0, output(0));
    buff_1: buff port map(input1, output(1));

end structural;
    