library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity dlatch6 is
    port(
        d       : in std_logic_vector(5 downto 0);
        clk     : in std_logic;
        q       : out std_logic_vector(5 downto 0);
        qbar    : out std_logic_vector(5 downto 0)
    );
end dlatch6;

architecture structural of dlatch6 is
    component Dlatch
        port ( d   : in  std_logic;
         clk : in  std_logic;
         q   : out std_logic;
         qbar: out std_logic);
    end component;

    for dl_0, dl_1, dl_2, dl_3, dl_4, dl_5: Dlatch use entity work.Dlatch(structural);

begin
    dl_0: Dlatch port map(d(0), clk, q(0), qbar(0));
    dl_1: Dlatch port map(d(1), clk, q(1), qbar(1));
    dl_2: Dlatch port map(d(2), clk, q(2), qbar(2));
    dl_3: Dlatch port map(d(3), clk, q(3), qbar(3));
    dl_4: Dlatch port map(d(4), clk, q(4), qbar(4));
    dl_5: Dlatch port map(d(5), clk, q(5), qbar(5));

end structural;