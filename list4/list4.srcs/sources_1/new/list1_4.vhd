library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity list1_4 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           cont_uni_segundos: out STD_LOGIC_VECTOR (6 downto 0);
           cont_dez_segundos: out STD_LOGIC_VECTOR (6 downto 0);
           cont_uni_minutos: out STD_LOGIC_VECTOR (6 downto 0);
           cont_dez_minutos: out STD_LOGIC_VECTOR (6 downto 0));
end list1_4;

architecture RTL of list1_4 is
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
    signal count_reg: integer range 0 to 999;
    signal uni_segundos: integer range 0 to 9;
    signal dez_segundos: integer range 0 to 5;
    signal uni_minutos: integer range 0 to 9;
    signal dez_minutos: integer range 0 to 5;
begin

    process(clk)is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                count_reg <= 999;
            else
                if count_reg = 0 then
                    count_reg <= 999;
                else 
                    count_reg <= count_reg - 1;
                end if;
            end if;
        end if;
    end process;
    
    process(clk)
    begin
        if rising_edge(clk) then
            if (count_reg = 0) then
                if (uni_segundos < 9) then
                    uni_segundos <= uni_segundos + 1;
                else
                    uni_segundos <= 0;
                end if;
            end if;
            
            if (count_reg = 0) and
            (uni_segundos = 9) then
                if (dez_segundos < 5) then
                    dez_segundos <= dez_segundos + 1;
                else
                    dez_segundos <= 0;
                end if;
            end if;
                
            if (count_reg = 0) and
            (uni_segundos = 9) and
            (dez_segundos = 5) then
                if (uni_minutos < 9) then
                    uni_minutos <= uni_minutos + 1;
                else
                    uni_minutos <= 0;
                end if;
            end if;
                
            if (count_reg = 0) and
            (uni_segundos = 9) and
            (dez_segundos = 5) and
            (uni_minutos = 9) then
                if (dez_minutos = 5) then
                    dez_minutos <= 0;
                else
                    dez_minutos <= dez_minutos + 1;
                end if;
            end if;
    end if;
    end process;

-- convertendo para 7 segmentos 
    with uni_segundos select cont_uni_segundos <=
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

    with dez_segundos select cont_dez_segundos <=
        DISPLAY_7SEG_ZERO when 0,
        DISPLAY_7SEG_ONE when 1,
        DISPLAY_7SEG_TWO when 2,
        DISPLAY_7SEG_THREE when 3,
        DISPLAY_7SEG_FOUR when 4,
        DISPLAY_7SEG_FIVE when 5,
        DISPLAY_7SEG_INVALID when others;
    
    with uni_minutos select cont_uni_minutos <=
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
    
    with dez_minutos select cont_dez_minutos <=
        DISPLAY_7SEG_ZERO when 0,
        DISPLAY_7SEG_ONE when 1,
        DISPLAY_7SEG_TWO when 2,
        DISPLAY_7SEG_THREE when 3,
        DISPLAY_7SEG_FOUR when 4,
        DISPLAY_7SEG_FIVE when 5,
        DISPLAY_7SEG_INVALID when others;
end RTL;
