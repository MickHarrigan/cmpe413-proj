-- 4 rows of 2 bits for tag within the cache

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity tag_block is
    port(
        d_wr    : in std_logic_vector(1 downto 0);
        ce      : in std_logic;
        rd_wr   : in std_logic;
        index0  : in std_logic;
        index1  : in std_logic;
        d_rd    : out std_logic_vector(1 downto 0);
        clk     : in std_logic
    );
end tag_block;

architecture structural of tag_block is
    component cache_cell2
        port(
            d_wr    : in std_logic_vector(1 downto 0);
            ce      : in std_logic;
            rd_wr   : in std_logic;
            d_rd    : out std_logic_vector(1 downto 0);
            clk     : in std_logic
        );
    end component;

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

    for row_0, row_1, row_2, row_3: cache_cell2 use entity work.cache_cell2(structural);
    for decoder: decoder2to4 use entity work.decoder2to4(structural);
    for and2_0, and2_1, and2_2, and2_3: and2 use entity work.and2(structural);

    signal ce0, ce1, ce2, ce3: std_logic;

    signal ce0g, ce1g, ce2g, ce3g: std_logic;

begin
    decoder: decoder2to4 port map(index0, index1, ce0, ce1, ce2, ce3);
    and2_0: and2 port map(ce, ce0, ce0g);
    and2_1: and2 port map(ce, ce1, ce1g);
    and2_2: and2 port map(ce, ce2, ce2g);
    and2_3: and2 port map(ce, ce3, ce3g);
    row_0: cache_cell2 port map(d_wr, ce0g, rd_wr, d_rd, clk);
    row_1: cache_cell2 port map(d_wr, ce1g, rd_wr, d_rd, clk);
    row_2: cache_cell2 port map(d_wr, ce2g, rd_wr, d_rd, clk);
    row_3: cache_cell2 port map(d_wr, ce3g, rd_wr, d_rd, clk);

end structural;