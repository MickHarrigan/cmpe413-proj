-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity hit_miss_detector is
    port(
        input1  : in std_logic_vector(1 downto 0);
        input2  : in std_logic_vector(1 downto 0);
        valid   : in std_logic;
        output  : out std_logic
    );
end hit_miss_detector;
