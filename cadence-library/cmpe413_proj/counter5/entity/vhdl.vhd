-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity counter5 is
    port(
        clk : in std_logic;
        ce  : in std_logic;
        rst : in std_logic;
        q   : out std_logic_vector(4 downto 0)
    );
end counter5;
