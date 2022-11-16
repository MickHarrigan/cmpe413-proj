--
-- Entity: tie_low
-- Architecture: structural
-- Author: Daniel Cleaver
-- Created On: 2022-10-22
--
library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity tie_low is
    port(
        output: out std_logic
    );
end tie_low;

architecture structural of tie_low is

begin

    output <= '0';

end structural;
