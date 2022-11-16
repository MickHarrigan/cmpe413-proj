-- Generates control signal outputs based on current state

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity output_gen is
    port(
        -- State (input)
        state:          in std_logic_vector(4 downto 0);

        -- Outputs
        cpu_busy:       out std_logic;

        shiftreg_input: out std_logic;
        shiftreg_rst:   out std_logic;

        cb_ce:          out std_logic;
        cb_index1:      out std_logic;
        cb_index0:      out std_logic;
        cb_offset1:     out std_logic;
        cb_offset0:     out std_logic;

        cpu_data_oe:    out std_logic;
        mem_add_oe:     out std_logic;

        mem_enable:     out std_logic
    );
end output_gen;

architecture structural of output_gen is
    component tie_high
        port(
            output: out std_logic
        );
    end component;

    component tie_low
        port(
            output: out std_logic
        );
    end component;

    for tie_high_0: tie_high use entity work.tie_high(structural);
    for tie_low_0: tie_low use entity work.tie_low(structural);

    signal inc, d, qi: std_logic_vector(4 downto 0);
    signal one, zero: std_logic;

begin
    tie_high_0: tie_high port map(one);
    tie_low_0: tie_low port map(zero);

    

end structural;
