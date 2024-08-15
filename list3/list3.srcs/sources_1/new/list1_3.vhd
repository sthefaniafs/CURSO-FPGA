library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity list1_3 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           cont_uni_segundos: out integer range 0 to 9;
           cont_dez_segundos: out integer range 0 to 5;
           cont_uni_minutos: out integer range 0 to 9;
           cont_dez_minutos: out integer range 0 to 5
           );
end list1_3;

architecture RTL of list1_3 is
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
    
    cont_uni_segundos <= uni_segundos;
    cont_dez_segundos <= dez_segundos;
    cont_uni_minutos <= uni_minutos;
    cont_dez_minutos <= dez_minutos;
    
end RTL;
