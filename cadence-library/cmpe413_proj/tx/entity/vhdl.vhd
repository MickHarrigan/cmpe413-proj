-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Mon Nov 28 14:39:50 2022


library STD;
library IEEE;                      
use IEEE.std_logic_1164.all;       

entity tx is                      
  port ( sel   : in std_logic;
         selnot: in std_logic;
         input : in std_logic;
         output:out std_logic);
end tx;                          
