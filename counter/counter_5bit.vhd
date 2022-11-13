-- Negative edge-triggered 5-bit up counter

library STD;
library IEEE;                      
use IEEE.std_logic_1164.all;

entity counter_5bit is
    port(
        ce  : in std_logic;
        rst : in std_logic;
        clk : in std_logic;
        q   : out std_logic_vector(4 downto 0)
    );
end counter_5bit;

architecture structural of counter_5bit is
    component dff
        port(
            d       : in std_logic;
            clk     : in std_logic;
            q       : out std_logic;
            qbar    : out std_logic
        );
    end component;

    for dff_0, dff_1, dff_2, dff_3, dff_4: dff use entity work.dff(structural);

begin

end structural;
