-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Tue Nov 29 13:43:40 2022


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity comparator5s is
    port(
        input1      : in std_logic_vector(4 downto 0);
        input2_0    : in std_logic;
        input2_1    : in std_logic;
        input2_2    : in std_logic;
        input2_3    : in std_logic;
        input2_4    : in std_logic;
        output      : out std_logic
    );
end comparator5s;
