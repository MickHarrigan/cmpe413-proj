-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Tue Nov 29 13:43:40 2022


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity decoder4to16 is
    port(
        input       : in std_logic_vector(3 downto 0);
        output0     : out std_logic;
        output1     : out std_logic;
        output2     : out std_logic;
        output3     : out std_logic;
        output4     : out std_logic;
        output5     : out std_logic;
        output6     : out std_logic;
        output7     : out std_logic;
        output8     : out std_logic;
        output9     : out std_logic;
        output10    : out std_logic;
        output11    : out std_logic;
        output12    : out std_logic;
        output13    : out std_logic;
        output14    : out std_logic;
        output15    : out std_logic
    );
end decoder4to16;
