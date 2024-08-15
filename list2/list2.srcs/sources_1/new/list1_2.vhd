library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity list1_2 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           blink : out STD_LOGIC);
end list1_2;

architecture RTL of list1_2 is
    signal count_reg: integer range 0 to 999;
    signal blink_sig: std_logic;
begin
    process (clk)is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                blink_sig <= '0';
                count_reg <= 999;
            else
                if count_reg = 0 then
                    blink_sig <= not blink_sig; 
                    count_reg <= 999;
                else 
                    count_reg <= count_reg - 1;
                end if;
            end if;
        end if;
    end process;
    
    blink <= blink_sig;
    
end RTL;
