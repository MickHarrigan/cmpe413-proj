-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity adder1 is
    port(
        input1      : in std_logic;
        input2      : in std_logic;
        carryin     : in std_logic;
        sum         : out std_logic;
        carryout    : out std_logic
    );
end adder1;
