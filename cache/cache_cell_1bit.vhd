library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity cache_cell_1bit is
    port(
        d_wr:   in std_logic;
        ce:     in std_logic;
        rd_wr:  in std_logic;
        d_rd:   out std_logic;
    );
end cache_cell_1bit;

architecture structural of cache_cell_1bit is
    component Dlatch
        port(
            input1:     in  std_logic_vector(3 downto 0);
            input2:     in  std_logic_vector(3 downto 0);
            carryin:    in  std_logic;
            sum:        out std_logic_vector(3 downto 0);
            carryout:   out std_logic
        );
    end component;

    component tx
        port(
            B:      in std_logic_vector(3 downto 0);
            S0:     in std_logic;
            S1:     in std_logic;
            Y:      out std_logic_vector(3 downto 0)
        );
    end component;

    component cache_decoder
        port(
            B:      in std_logic_vector(3 downto 0);
            S0:     in std_logic;
            S1:     in std_logic;
            Y:      out std_logic_vector(3 downto 0)
        );
    end component;

    for adder4_0: adder4 use entity work.adder4(structural);
    for y_gen_0: y_gen use entity work.y_gen(structural);
    
    signal Y: std_logic_vector(3 downto 0);
    
    begin

    y_gen_0: y_gen port map(B, S0, S1, Y);

    adder4_0: adder4 port map(A, Y, Cin, G, Cout);

end structural;
