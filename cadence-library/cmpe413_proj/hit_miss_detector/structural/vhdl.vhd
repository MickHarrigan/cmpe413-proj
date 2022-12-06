-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


architecture structural of hit_miss_detector is
    component and2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );
    end component;

    component comparator2
        port(
            input1  : in std_logic_vector(1 downto 0);
            input2  : in std_logic_vector(1 downto 0);
            output  : out std_logic
        );
    end component;

    for comp2_0: comparator2 use entity work.comparator2(structural);
    for and2_0: and2 use entity work.and2(structural);

    signal x: std_logic;

begin
    -- valid & comparator2(input1, input2) == hit
    
    comp2_0: comparator2 port map(input1, input2, x);

    and2_0: and2 port map(valid, x, output);

end structural;