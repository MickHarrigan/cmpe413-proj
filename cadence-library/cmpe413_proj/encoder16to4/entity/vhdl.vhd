-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Tue Nov 29 13:43:40 2022


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity encoder16to4 is
    port(
        input0      : in std_logic;
        input1      : in std_logic;
        input2      : in std_logic;
        input3      : in std_logic;
        input4      : in std_logic;
        input5      : in std_logic;
        input6      : in std_logic;
        input7      : in std_logic;
        input8      : in std_logic;
        input9      : in std_logic;
        input10     : in std_logic;
        input11     : in std_logic;
        input12     : in std_logic;
        input13     : in std_logic;
        input14     : in std_logic;
        input15     : in std_logic;
        output      : out std_logic_vector(3 downto 0)
    );
end encoder16to4;
