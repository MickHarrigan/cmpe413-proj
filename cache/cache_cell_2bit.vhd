-- 2-bit cache cell

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity cache_cell_2bit is
    port(
        d_wr    : in std_logic_vector(1 downto 0);
        ce      : in std_logic;
        rd_wr   : in std_logic;
        d_rd    : out std_logic_vector(1 downto 0)
    );
end cache_cell_2bit;

architecture structural of cache_cell_2bit is
    component cache_cell_1bit
        port(
            d_wr    : in std_logic;
            ce      : in std_logic;
            rd_wr   : in std_logic;
            d_rd    : out std_logic
        );
    end component;

    for cache_cell_1bit_0, cache_cell_1bit_1: cache_cell_1bit use entity work.cache_cell_1bit(structural);
    
begin
        cache_cell_1bit_0: cache_cell_1bit port map(d_wr(0), ce, rd_wr, d_rd(0));
        cache_cell_1bit_1: cache_cell_1bit port map(d_wr(1), ce, rd_wr, d_rd(1));
        
end structural;
