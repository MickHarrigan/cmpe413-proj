--
-- Entity: inverter
-- Architecture: structural
-- Author: cpatel2
-- Created On: 2022-09-16
--
library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity inverter is

  port (
    input    : in  std_logic;
    output   : out std_logic);
end inverter;

architecture structural of inverter is

begin

  output <= not (input);

end structural;


