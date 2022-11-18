--
-- Entity: and5
-- Architecture: structural
-- Author: Daniel Cleaver
-- Created On: 2022-09-16
--
library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity and5 is
    port(
        input1: in std_logic;
        input2: in std_logic;
        input3: in std_logic;
        input4: in std_logic;
        input5: in std_logic;
        output: out std_logic
    );
end and5;

architecture structural of and5 is

begin

    output <= input1 and input2 and input3 and input4 and input5;

end structural;
