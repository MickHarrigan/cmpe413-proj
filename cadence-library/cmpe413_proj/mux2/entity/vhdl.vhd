-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Tue Nov 29 13:43:40 2022


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity mux2 is
    port(
        input0  : in std_logic;
        input1  : in std_logic;
        s       : in std_logic;
        output  : out std_logic
    );
end mux2;
