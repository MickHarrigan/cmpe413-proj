-- These are the standard libraries that you are defining. library IEEE;
library STD;
library IEEE;
use IEEE.std_logic_1164.all;
-- Keep the entity name same as the file name as it will be easier during compilation.
-- Ports are the inputs and outputs from your circuit.
entity inverter is
port (
input : in std_logic;
output : out std_logic);
end inverter;
-- Define an architecture for the inverter entity which is either functional or behavioral.
architecture structural of inverter is
begin
-- Concurrent assignment statement.
output <= not (input);
end structural;
