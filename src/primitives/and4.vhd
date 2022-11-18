library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity and4 is

  port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    input3   : in std_logic;
    input4   : in std_logic;
    output   : out std_logic);
end and4;

architecture structural of and4 is

begin

  output <= input1 and input2 and input3 and input4;

end structural;
