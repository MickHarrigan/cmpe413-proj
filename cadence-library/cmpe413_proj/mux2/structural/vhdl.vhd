-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Tue Nov 29 13:43:40 2022


architecture structural of mux2 is
    component or2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );
    end component;

    component and2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );
    end component;

    component inverter
        port(
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

    for or2_0: or2 use entity work.or2(structural);
    for and2_0, and2_1: and2 use entity work.and2(structural);
    for inverter_0: inverter use entity work.inverter(structural);    

    signal sn, in0g, in1g: std_logic;
        
begin
    inverter_0: inverter port map(s, sn);
    
    and2_0: and2 port map(input0, sn, in0g);
    and2_1: and2 port map(input1, s, in1g);
    
    or2_0: or2 port map(in0g, in1g, output);

end structural;
