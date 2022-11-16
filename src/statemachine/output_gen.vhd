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

        cpu_data_oe:    out std_logic;
        mem_add_oe:     out std_logic;

        mem_enable:     out std_logic;

        cb_ce:          out std_logic;
        cb_ce_adj:      out std_logic;
        cb_ce_inv:      out std_logic;
        
        cb_rd_wr:       out std_logic;
        cb_offset1:     out std_logic;
        cb_offset0:     out std_logic;

        tb_ce:          out std_logic;
        tb_rd_wr:       out std_logic;

        valid_ce:       out std_logic;
        valid_ce_all:   out std_logic;
        valid_rd_wr:    out std_logic;
        valid_d_wr:     out std_logic
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

    component and2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );
    end component;

    component or2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );
    end component;

    component or4
        port(
            input1: in std_logic;
            input2: in std_logic;
            input3: in std_logic;
            input4: in std_logic;
            output: out std_logic
        );
    end component;

    component xor2
        port(
            input1  : in std_logic;
            input2  : in std_logic;
            output  : out std_logic
        );
    end component;

    component bus_creator5
        port(
            input4  : in std_logic;
            input3  : in std_logic;
            input2  : in std_logic;
            input1  : in std_logic;
            input0  : in std_logic;
            output  : out std_logic_vector(4 downto 0)
        );
    end component;

    component comparator5s
        port(
            input1      : in std_logic_vector(4 downto 0);
            input2_0    : in std_logic;
            input2_1    : in std_logic;
            input2_2    : in std_logic;
            input2_3    : in std_logic;
            input2_4    : in std_logic;
            output      : out std_logic
        );
    end component;

    component mux2
        port(
            input0  : in std_logic;
            input1  : in std_logic;
            s       : in std_logic;
            output  : out std_logic
        );
    end component;


    for tie_high_0: tie_high use entity work.tie_high(structural);
    for tie_low_0: tie_low use entity work.tie_low(structural);


    for and2_0, and2_1: and2 use entity work.and2(structural);
    for or2_0: or2 use entity work.or2(structural);
    for xor2_0: xor2 use entity work.xor2(structural);

    for bus_creator5_0, bus_creator5_1, bus_creator5_2, bus_creator5_3,
        bus_creator5_4, bus_creator5_5, bus_creator5_6, bus_creator5_7,
        bus_creator5_8
        : bus_creator5 use entity work.bus_creator5(structural);

    
    signal b1, b0: std_logic;

    signal s4xor3, s4and3: std_logic;

    signal s00: std_logic;

    signal state01, state08, state09, state12, state13, state15, state20, 
        state21, state24
        : std_logic_vector(4 downto 0);

begin
    tie_high_0: tie_high port map(b1);
    tie_low_0: tie_low port map(b0);

    -- State codes
    bus_creator5_0: bus_creator5 port map(b0, b0, b0, b0, b1, state01);
    bus_creator5_1: bus_creator5 port map(b0, b1, b0, b0, b0, state08);
    bus_creator5_2: bus_creator5 port map(b0, b1, b0, b0, b1, state09);
    bus_creator5_3: bus_creator5 port map(b0, b1, b1, b0, b0, state12);
    bus_creator5_4: bus_creator5 port map(b0, b1, b1, b0, b1, state13);
    bus_creator5_5: bus_creator5 port map(b0, b1, b1, b1, b1, state15);
    bus_creator5_6: bus_creator5 port map(b1, b0, b1, b0, b0, state20);
    bus_creator5_7: bus_creator5 port map(b1, b0, b1, b0, b1, state21);
    bus_creator5_8: bus_creator5 port map(b1, b1, b0, b0, b0, state24);
    

    -- cpu_busy
    xor2_0: xor2 port map(state(4), state(3), s4xor3);
    and2_0: and2 port map(s4xor3, state(2), s00);
    and2_1: and2 port map(state(4), state(3), s4and3);
    or2_0: or2 port map(s00, s4and3, cpu_busy);

    -- shiftreg_input
    --comparator5s_0: comparator5s port map()

    

end structural;
