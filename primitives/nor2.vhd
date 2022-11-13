library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity nor2 is
    port(
        input1  : in  std_logic;
        input2  : in  std_logic;
        output  : out std_logic
    );
end nor2;

architecture structural of nor2 is
begin
    output <= input2 nor input1;

end structural;
