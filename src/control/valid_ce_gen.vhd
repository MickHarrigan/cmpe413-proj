-- Generates ce for the 4 cache cells storing valid bits

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

architecture structural of valid_ce_gen is
    component decoder2to4
        port(
            input0  : in std_logic;
            input1  : in std_logic;
            output0 : out std_logic;
            output1 : out std_logic;
            output2 : out std_logic;
            output3 : out std_logic
        );
    end component;

    component and2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );
    end component;

    component or2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );
    end component;

    for decoder: decoder2to4 use entity work.decoder2to4(structural);
    for and2_0, and2_1, and2_2, and2_3: and2 use entity work.and2(structural);
    for or2_0, or2_1, or2_2, or2_3: or2 use entity work.or2(structural);

    signal vce0, vce1, vce2, vce3, vce0g, vce1g, vce2g, vce3g: std_logic;

begin
    -- Determine which ce would be selected normally
    decoder: decoder2to4 port map(index0, index1, vce0, vce1, vce2, vce3);

    -- Gate with valid_ce
    and2_0: and2 port map(vce0, valid_ce, vce0g);
    and2_1: and2 port map(vce1, valid_ce, vce1g);
    and2_2: and2 port map(vce2, valid_ce, vce2g);
    and2_3: and2 port map(vce3, valid_ce, vce3g);

    -- Override with 1 if valid_ce_all is 1
    or2_0: or2 port map(vce0g, valid_ce_all, valid_ce0);
    or2_1: or2 port map(vce1g, valid_ce_all, valid_ce1);
    or2_2: or2 port map(vce2g, valid_ce_all, valid_ce2);
    or2_3: or2 port map(vce3g, valid_ce_all, valid_ce3);

end structural;
