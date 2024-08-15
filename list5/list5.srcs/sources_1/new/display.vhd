library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display is
  Port (entrada : in integer;
        saida : out std_logic_vector (6 downto 0));
end display;

architecture RTL of display is
    constant DISPLAY_7SEG_ZERO : std_logic_vector(6 downto 0) := "0000001";
    constant DISPLAY_7SEG_ONE : std_logic_vector(6 downto 0) := "1001111";
    constant DISPLAY_7SEG_TWO : std_logic_vector(6 downto 0) := "0010010";
    constant DISPLAY_7SEG_THREE : std_logic_vector(6 downto 0) := "0000110";
    constant DISPLAY_7SEG_FOUR : std_logic_vector(6 downto 0) := "1001100";
    constant DISPLAY_7SEG_FIVE : std_logic_vector(6 downto 0) := "0100100";
    constant DISPLAY_7SEG_SIX : std_logic_vector(6 downto 0) := "0100000";
    constant DISPLAY_7SEG_SEVEN : std_logic_vector(6 downto 0) := "0001111";
    constant DISPLAY_7SEG_EIGHT : std_logic_vector(6 downto 0) := "0000000";
    constant DISPLAY_7SEG_NINE : std_logic_vector(6 downto 0) := "0000100";
    constant DISPLAY_7SEG_INVALID : std_logic_vector(6 downto 0) := "1111110";

begin
  with entrada select saida <=
    DISPLAY_7SEG_ZERO when 0,
    DISPLAY_7SEG_ONE when 1,
    DISPLAY_7SEG_TWO when 2,
    DISPLAY_7SEG_THREE when 3,
    DISPLAY_7SEG_FOUR when 4,
    DISPLAY_7SEG_FIVE when 5,
    DISPLAY_7SEG_SIX when 6,
    DISPLAY_7SEG_SEVEN when 7,
    DISPLAY_7SEG_EIGHT when 8,
    DISPLAY_7SEG_NINE when 9,
    DISPLAY_7SEG_INVALID when others;  

end RTL;
