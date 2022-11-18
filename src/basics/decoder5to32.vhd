library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity decoder5to32 is
    port(
        input0      : in std_logic_vector(4 downto 0);
        output0     : out std_logic;
        output1     : out std_logic;
        output2     : out std_logic;
        output3     : out std_logic;
        output4     : out std_logic;
        output5     : out std_logic;
        output6     : out std_logic;
        output7     : out std_logic;
        output8     : out std_logic;
        output9     : out std_logic;
        output10    : out std_logic;
        output11    : out std_logic;
        output12    : out std_logic;
        output13    : out std_logic;
        output14    : out std_logic;
        output15    : out std_logic;
        output16    : out std_logic;
        output17    : out std_logic;
        output18    : out std_logic;
        output19    : out std_logic;
        output20    : out std_logic;
        output21    : out std_logic;
        output22    : out std_logic;
        output23    : out std_logic;
        output24    : out std_logic;
        output25    : out std_logic;
        output26    : out std_logic;
        output27    : out std_logic;
        output28    : out std_logic;
        output29    : out std_logic;
        output30    : out std_logic;
        output31    : out std_logic
    );
end decoder5to32;

architecture structural of decoder5to32 is
    -- components
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

    component decoder3to8
        port(
            en      : in std_logic;
            input0  : in std_logic;
            input1  : in std_logic;
            input2  : in std_logic;
            output0 : out std_logic;
            output1 : out std_logic;
            output2 : out std_logic;
            output3 : out std_logic;
            output4 : out std_logic;
            output5 : out std_logic;
            output6 : out std_logic;
            output7 : out std_logic
        );
    end component;

    for dec2to4_0: decoder2to4 use entity work.decoder2to4(structural);
    for dec3to8_0, dec3to8_1, dec3to8_2, dec3to8_3: decoder3to8 use entity work.decoder3to8(structural);
    
    signal en0, en1, en2, en3: std_logic;

begin

    dec2to4_0: decoder2to4 port map(input0(3), input0(4), en0, en1, en2, en3);
    
    dec3to8_0: decoder3to8 port map(en0, input0(0), input0(1), input0(2), output0, output1, output2, output3, output4, output5, output6, output7);
    dec3to8_1: decoder3to8 port map(en1, input0(0), input0(1), input0(2), output8, output9, output10, output11, output12, output13, output14, output15);
    dec3to8_2: decoder3to8 port map(en2, input0(0), input0(1), input0(2), output16, output17, output18, output19, output20, output21, output22, output23);
    dec3to8_3: decoder3to8 port map(en3, input0(0), input0(1), input0(2), output24, output25, output26, output27, output28, output29, output30, output31);

end structural;

