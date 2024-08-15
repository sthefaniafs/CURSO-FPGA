library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity list1 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           cnt : out integer range 0 to 999);
end list1;

architecture RTL of list1 is
    signal count_reg: integer range 0 to 999;
begin
    process (clk)is
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
    cnt <= count_reg;

end RTL;
