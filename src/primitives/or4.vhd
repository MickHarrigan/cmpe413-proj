--
-- Entity: or4
-- Architecture: structural
-- Author: Daniel Cleaver
-- Created On: 2022-09-16
--
library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity or4 is
    port(
        input1: in std_logic;
        input2: in std_logic;
        input3: in std_logic;
        input4: in std_logic;
        output: out std_logic
    );
end or4;

architecture structural of or4 is

begin

    output <= input1 or input2 or input3 or input4;

end structural;
