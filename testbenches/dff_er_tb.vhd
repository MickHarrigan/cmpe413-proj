-- Testbench for dff_er
-- TODO: unfinished

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity dff_er_tb is
end dff_er_tb;

architecture test of dff_er_tb is
    component dff_er
        port(
            d       : in std_logic;
            clk     : in std_logic;
            ce      : in std_logic;
            rst     : in std_logic;
            q       : out std_logic;
            qbar    : out std_logic
        );
    end component;

    for uut: dff_er use entity work.dff_er(structural);

    signal d, clk, ce, rst, q, qbar: std_logic;

procedure print_output is


end print_output;


begin

end test;