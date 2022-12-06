-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Mon Nov 28 14:39:50 2022


library STD;
library IEEE;                      
use IEEE.std_logic_1164.all;       

entity dff is                      
  port ( d   : in  std_logic;
         clk : in  std_logic;
         q   : out std_logic;
         qbar: out std_logic); 
end dff;                          
