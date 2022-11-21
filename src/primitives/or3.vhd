library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity or3 is
    port(
        input1  : in std_logic;
        input2  : in std_logic;
        input3  : in std_logic;
        output  : out std_logic
    );
end or3;

architecture structural of or3 is
begin
    output <= input1 or input2 or input3;

end structural;
