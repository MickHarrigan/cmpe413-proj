-- 8 bit register using dffer
-- primary use case is in C_d storage

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity dffer8 is
    port(
        d       : in std_logic_vector(7 downto 0);
        clk     : in std_logic;
        ce      : in std_logic;
        rst     : in std_logic;
        q       : out std_logic_vector(7 downto 0);
        qbar    : out std_logic_vector(7 downto 0)
    );
end dffer8;

architecture structural of dffer8 is
    component dffer
        port(
            d       : in std_logic;
            clk     : in std_logic;
            ce      : in std_logic;
            rst     : in std_logic;
            q       : out std_logic;
            qbar    : out std_logic
        );
    end component;

    for dffer_0, dffer_1, dffer_2, dffer_3, dffer_4, dffer_5, dffer_6, dffer_7
        : dffer use entity work.dffer(structural);

begin
    dffer_0: dffer port map(d(0), clk, ce, rst, q(0), qbar(0));
    dffer_1: dffer port map(d(1), clk, ce, rst, q(1), qbar(1));
    dffer_2: dffer port map(d(2), clk, ce, rst, q(2), qbar(2));
    dffer_3: dffer port map(d(3), clk, ce, rst, q(3), qbar(3));
    dffer_4: dffer port map(d(4), clk, ce, rst, q(4), qbar(4));
    dffer_5: dffer port map(d(5), clk, ce, rst, q(5), qbar(5));
    dffer_6: dffer port map(d(6), clk, ce, rst, q(6), qbar(6));
    dffer_7: dffer port map(d(7), clk, ce, rst, q(7), qbar(7));

end structural;