-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity cache_decoder is
    port(
        ce      : in std_logic;
        rd_wr   : in std_logic;
        we      : out std_logic;
        re      : out std_logic
    );
end cache_decoder;
