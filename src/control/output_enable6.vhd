-- Output enable module for C_a and M_d
-- controls when outputs are to be allowed out of the shared in/out pins, as well as memory address passed in on a read miss

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity output_enable6 is
    port(
        input   : in std_logic_vector(5 downto 0);
        oe      : in std_logic;
        output  : out std_logic_vector(5 downto 0)
    );
end output_enable6;

architecture structural of output_enable6 is
    component tx
        port(
            sel     : in std_logic;
            selnot  : in std_logic;
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

    component inverter
        port(
            input   : in std_logic;
            output  : out std_logic
        );
    end component;

    for tx_0, tx_1, tx_2, tx_3, tx_4, tx_5: tx use entity work.tx(structural);
    for inv: inverter use entity work.inverter(structural);

    signal oe_n: std_logic;

begin
    inv: inverter port map(oe, oe_n);

    tx_0: tx port map(oe, oe_n, input(0), output(0));
    tx_1: tx port map(oe, oe_n, input(1), output(1));
    tx_2: tx port map(oe, oe_n, input(2), output(2));
    tx_3: tx port map(oe, oe_n, input(3), output(3));
    tx_4: tx port map(oe, oe_n, input(4), output(4));
    tx_5: tx port map(oe, oe_n, input(5), output(5));

end structural;
