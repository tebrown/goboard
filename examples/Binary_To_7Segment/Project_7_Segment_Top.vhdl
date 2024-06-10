library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Project_7_Segment_Top is
    port (
        -- Main Clock 
        i_Clk           : in std_logic;

        -- Input Switch
        i_Switch_1      : in std_logic;

        -- Segment2 is the lower digit, Segment 1 is the upper
        o_Segment2_A    : out std_logic;
        o_Segment2_B    : out std_logic;
        o_Segment2_C    : out std_logic;
        o_Segment2_D    : out std_logic;
        o_Segment2_E    : out std_logic;
        o_Segment2_F    : out std_logic;
        o_Segment2_G    : out std_logic
    );
end entity Project_7_Segment_Top;

architecture RTL of Project_7_Segment_Top is
    signal w_Switch_1   : std_logic;
    signal r_Switch_1   : std_logic;
    signal r_Count      : integer range 0 to 9 := 0;

    signal w_Segment2_A : std_logic;
    signal w_Segment2_B : std_logic;
    signal w_Segment2_C : std_logic;
    signal w_Segment2_D : std_logic;
    signal w_Segment2_E : std_logic;
    signal w_Segment2_F : std_logic;
    signal w_Segment2_G : std_logic;
begin
    -- Instantiate Debounce Filter
    Debounce_Inst   : entity work.Debounce_Switch
        port map (
            i_Clk       => i_Clk,
            i_Switch    => i_Switch_1,
            o_Switch    => w_Switch_1
        );

    -- When switch is pressed, increement counter. Roll over from 9 -> 0
    p_Switch_Count : process (i_Clk)
    begin
        if rising_edge(i_Clk) then
            r_Switch_1 <= w_Switch_1;

            -- Increment count when switch is pushed down
            if (w_Switch_1 = '1' and r_Switch_1 = '0') then
                if (r_Count = 9) then
                    r_Count <= 0;
                else 
                    r_Count <= r_Count + 1;
                end if;
            end if;
        end if;
    end process p_Switch_Count;

    -- Instantiate binary to 7-segment converter
    SevenSeg1_Inst : entity work.Binary_To_7Segment
        port map (
            i_Clk           => i_Clk,
            i_Binary_Num    => std_logic_vector(to_unsigned(r_Count, 4)),
            o_Segment_A     => w_Segment2_A,
            o_Segment_B     => w_Segment2_B,
            o_Segment_C     => w_Segment2_C,
            o_Segment_D     => w_Segment2_D,
            o_Segment_E     => w_Segment2_E,
            o_Segment_F     => w_Segment2_F,
            o_Segment_G     => w_Segment2_G
        ); 
    
    o_Segment2_A <= not w_Segment2_A;
    o_Segment2_B <= not w_Segment2_B;
    o_Segment2_C <= not w_Segment2_C;
    o_Segment2_D <= not w_Segment2_D;
    o_Segment2_E <= not w_Segment2_E;
    o_Segment2_F <= not w_Segment2_F;
    o_Segment2_G <= not w_Segment2_G;

end architecture RTL;

