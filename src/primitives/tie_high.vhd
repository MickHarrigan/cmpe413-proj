--
-- Entity: tie_high
-- Architecture: structural
-- Author: Daniel Cleaver
-- Created On: 2022-10-22
--
library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity tie_high is
    port(
        output: out std_logic
    );
end tie_high;

architecture structural of tie_high is

begin

    output <= '1';

end structural;
