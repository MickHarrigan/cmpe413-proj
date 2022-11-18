-- 5 bit bus creator, converts 5 input lines into a single 5 bit bus

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity bus_creator5 is
    port(
        input4  : in std_logic;
        input3  : in std_logic;
        input2  : in std_logic;
        input1  : in std_logic;
        input0  : in std_logic;
        output  : out std_logic_vector(4 downto 0)
    );
end bus_creator5;

architecture structural of bus_creator5 is
    component buff
        port(
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

    for buff_0, buff_1, buff_2, buff_3, buff_4: buff use entity work.buff(structural);

begin

    buff_0: buff port map(input0, output(0));
    buff_1: buff port map(input1, output(1));
    buff_2: buff port map(input2, output(2));
    buff_3: buff port map(input3, output(3));
    buff_4: buff port map(input4, output(4));

end structural;
    