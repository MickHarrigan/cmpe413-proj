-- Top level cache

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity chip is
    port(
        cpu_add     : in  std_logic_vector(5 downto 0);
        cpu_data    : inout  std_logic_vector(7 downto 0);
        cpu_rd_wrn  : in  std_logic;    
        start       : in  std_logic;
        clk         : in  std_logic;
        reset       : in  std_logic;
        mem_data    : in  std_logic_vector(7 downto 0);
        Vdd         : in  std_logic;
        Gnd         : in  std_logic;
        busy        : out std_logic;
        mem_en      : out std_logic;
        mem_add     : out std_logic_vector(5 downto 0)
    );
end chip;

architecture structural of chip is
    -- state machine
    component statemachine
        port(
            clk:            in std_logic;

            -- Current state (output)
            curr_state:     out std_logic_vector(4 downto 0);

            -- Next state (input)
            next_state:     in std_logic_vector(4 downto 0);

            -- Inputs
            cpu_rd_wrn:     in std_logic;
            cpu_start:      in std_logic;
            cpu_reset:      in std_logic;

            shiftreg_done:  in std_logic;

            hit_miss:       in std_logic;

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
    end component;
    -- cache block
    component cache_block
        port(
            d_wr    : in std_logic_vector(7 downto 0);
            ce      : in std_logic;
            rd_wr   : in std_logic;
            index0  : in std_logic;
            index1  : in std_logic;
            offset0 : in std_logic;
            offset1 : in std_logic;
            d_rd    : out std_logic_vector(7 downto 0)
        );
    end component;
    -- tag block
    component tag_block
        port(
            d_wr    : in std_logic_vector(1 downto 0);
            ce      : in std_logic;
            rd_wr   : in std_logic;
            index0  : in std_logic;
            index1  : in std_logic;
            d_rd    : out std_logic_vector(1 downto 0)
        );
    end component;
    -- "valid" (4 cells of cache)
    component cache_cell1
        port(
            d_wr    : in std_logic;
            ce      : in std_logic;
            rd_wr   : in std_logic;
            d_rd    : out std_logic
        );
    end component;
    -- registers (8 and 6)
    component dffer6
        port(
            d       : in std_logic_vector(5 downto 0);
            clk     : in std_logic;
            ce      : in std_logic;
            rst     : in std_logic;
            q       : out std_logic_vector(5 downto 0);
            qbar    : out std_logic_vector(5 downto 0)
        );
    end component;

    component dffer8
        port(
            d       : in std_logic_vector(7 downto 0);
            clk     : in std_logic;
            ce      : in std_logic;
            rst     : in std_logic;
            q       : out std_logic_vector(7 downto 0);
            qbar    : out std_logic_vector(7 downto 0)
        );
    end component;
    -- oe_d
    component output_enable8
        port(
            input   : in std_logic_vector(7 downto 0);
            oe      : in std_logic;
            output  : out std_logic_vector(7 downto 0)
        );
    end component;
    -- oe_a
    component output_enable6
        port(
            input   : in std_logic_vector(5 downto 0);
            oe      : in std_logic;
            output  : out std_logic_vector(5 downto 0)
        );
    end component;
    -- counter
    component shiftreg8
        port(
            clk     : in std_logic;
            input   : in std_logic;
            rst     : in std_logic;
            q       : out std_logic_vector(7 downto 0)
        );
    end component;
    -- hit miss detector
    -- unimplemented!()
    
begin
    
end structural;
