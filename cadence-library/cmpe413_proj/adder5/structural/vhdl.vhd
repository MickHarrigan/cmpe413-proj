-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Wed Nov 30 17:15:22 2022


architecture structural of adder5 is
    component adder1
        port(
            input1      : in std_logic;
            input2      : in std_logic;
            carryin     : in std_logic;
            sum         : out std_logic;
            carryout    : out std_logic
        );
    end component;

    for adder1_0, adder1_1, adder1_2, adder1_3, adder1_4: adder1 use entity work.adder1(structural);

    signal ctemp: std_logic_vector(3 downto 0);

begin
    adder1_0: adder1 port map (input1(0), input2(0), carryin, sum(0), ctemp(0));
    adder1_1: adder1 port map (input1(1), input2(1), ctemp(0), sum(1), ctemp(1));
    adder1_2: adder1 port map (input1(2), input2(2), ctemp(1), sum(2), ctemp(2));
    adder1_3: adder1 port map (input1(3), input2(3), ctemp(2), sum(3), ctemp(3));
    adder1_4: adder1 port map (input1(4), input2(4), ctemp(3), sum(4), carryout);

end structural;
