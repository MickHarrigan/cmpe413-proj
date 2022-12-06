-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity valid_ce_gen is
    port(
        index0:         in std_logic;
        index1:         in std_logic;
        valid_ce:       in std_logic;
        valid_ce_all:   in std_logic;
        valid_ce0:     out std_logic;
        valid_ce1:     out std_logic;
        valid_ce2:     out std_logic;
        valid_ce3:     out std_logic
    );
end valid_ce_gen;
