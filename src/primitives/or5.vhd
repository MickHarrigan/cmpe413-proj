library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity or5 is
    port(
        input1: in std_logic;
        input2: in std_logic;
        input3: in std_logic;
        input4: in std_logic;
        input5: in std_logic;
        output: out std_logic
    );
end or5;

architecture structural of or5 is

begin

    output <= input1 or input2 or input3 or input4 or input5;

end structural;
