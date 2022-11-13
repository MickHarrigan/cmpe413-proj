-- 2-to-1 mux

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity mux2 is
    port(
        input1  : in std_logic;
        input2  : in std_logic;
        s       : in std_logic;
        output  : out std_logic
    );
end mux2;

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

    signal sn: std_logic;
    signal in1g: std_logic;
    signal in2g: std_logic;
    
begin
    inverter_0: inverter port map(s, sn);
    
    and2_0: and2 port map(input1, sn, in1g);
    and2_1: and2 port map(input2, s, in2g);
    
    or2_0: or2 port map(in1g, in2g, output);

end structural;
