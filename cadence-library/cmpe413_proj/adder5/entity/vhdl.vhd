-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity adder5 is
    port(
        input1      : in std_logic_vector(4 downto 0);
        input2      : in std_logic_vector(4 downto 0);
        carryin     : in std_logic;
        sum         : out std_logic_vector(4 downto 0);
        carryout    : out std_logic
    );
end adder5;
