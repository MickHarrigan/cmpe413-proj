library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity or2 is
    port(
        input1  : in std_logic;
        input2  : in std_logic;
        output  : out std_logic
    );
end or2;

architecture structural of or2 is
begin
    output <= input1 or input2;

end structural;
