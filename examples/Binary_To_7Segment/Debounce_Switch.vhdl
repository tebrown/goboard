library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Debounce_Switch is
    port (
        i_Clk       : in std_logic;
        i_Switch    : in std_logic;
        o_Switch    : out std_logic
    );
end entity Debounce_Switch;

architecture RTL of Debounce_Switch is

    -- 10ms at 25 Mhz
    constant c_DEBOUNCE_LIMIT : integer := 250000;
    
    signal r_State  : std_logic := '0'; -- Filtered version of i_Switch
    signal r_Count  : integer range 0 to c_DEBOUNCE_LIMIT := 0;

begin
    p_Debounce: process (i_Clk) is
    begin
        if rising_edge(i_Clk) then
            if (i_Switch /= r_State and r_Count < c_DEBOUNCE_LIMIT) then
                r_Count <= r_Count + 1;
            elsif r_Count = c_DEBOUNCE_LIMIT then
                r_State <= i_Switch;
                r_Count <= 0;
            else
                r_Count <= 0;
            end if;
        end if;

    end process p_Debounce;
   
    o_Switch <= r_State;

end architecture RTL;
