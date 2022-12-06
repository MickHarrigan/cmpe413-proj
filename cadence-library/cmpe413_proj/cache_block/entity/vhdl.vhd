-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity cache_block is
    port(
        d_wr    : in std_logic_vector(7 downto 0);
        ce      : in std_logic;
        rd_wr   : in std_logic;
        index0  : in std_logic;
        index1  : in std_logic;
        offset0 : in std_logic;
        offset1 : in std_logic;
        d_rd    : out std_logic_vector(7 downto 0);
        clk     : in std_logic
    );
end cache_block;
