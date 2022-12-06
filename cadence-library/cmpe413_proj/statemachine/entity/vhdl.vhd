-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity statemachine is
    port(
        clk             : in std_logic;

        -- Inputs
        cpu_rd_wrn      : in std_logic;
        cpu_start       : in std_logic;
        cpu_reset       : in std_logic;

        count1          : in std_logic;
        count2          : in std_logic;

        hit_miss        : in std_logic;

        -- Outputs
        cpu_busy        : out std_logic;

        counter_ce      : out std_logic;
        counter_rst     : out std_logic;

        cpu_data_oe     : out std_logic;
        mem_add_oe      : out std_logic;

        mem_enable      : out std_logic;

        cb_d_wr_control : out std_logic;

        cb_ce           : out std_logic;
        cb_rd_wr        : out std_logic;

        cb_offset_control   : out std_logic;
        
        tb_ce           : out std_logic;
        tb_rd_wr        : out std_logic;

        valid_ce        : out std_logic;
        valid_ce_all    : out std_logic;

        valid_rd_wr     : out std_logic;
        valid_d_wr      : out std_logic
    );
end statemachine;
