library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity list1_5 is
  Port (clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        cathodes : out STD_LOGIC_VECTOR (6 downto 0);
        anodes : out STD_LOGIC_VECTOR (3 downto 0));
end list1_5;

architecture Behavioral of list1_5 is
    signal count_reg: integer range 0 to 99999999;
    
    signal uni_segundos: integer range 0 to 9;
    signal dez_segundos: integer range 0 to 5;
    signal uni_minutos: integer range 0 to 9;
    signal dez_minutos: integer range 0 to 5;
    
    signal reg_uni_segundos: STD_LOGIC_VECTOR (6 downto 0);
    signal reg_dez_segundos:  STD_LOGIC_VECTOR (6 downto 0);
    signal reg_uni_minutos: STD_LOGIC_VECTOR (6 downto 0);
    signal reg_dez_minutos: STD_LOGIC_VECTOR (6 downto 0);
    
    signal anodo : STD_LOGIC_VECTOR (1 downto 0);
    
    constant anode_config_0 : std_logic_vector(3 downto 0) := "1110";
    constant anode_config_1 : std_logic_vector(3 downto 0) := "1101";
    constant anode_config_2 : std_logic_vector(3 downto 0) := "1011";
    constant anode_config_3 : std_logic_vector(3 downto 0) := "0111";
    
    -- componente para converter para 7 segmentos
    component display is
        Port (entrada : in integer;
              saida : out std_logic_vector (6 downto 0));
    end component;

begin

    -- processo para contar
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                count_reg <= 99999999;
            else
                if count_reg = 0 then
                    count_reg <= 99999999;
                else 
                    count_reg <= count_reg - 1;
                end if;
            end if;
        end if;
    end process;
    
    -- processo para definir mudança do anodes 
    -- mudar display a cada 10 ms 
    -- para mudar são necessários 1000000 ciclos de clock
    
   process(clk)
   variable ciclos: integer := 0;
    begin
        if rising_edge(clk) then
            if (ciclos < 1e6) then
	           ciclos := ciclos + 1;
            else
	           ciclos := 0;
	           if anodo < "11" then
		          anodo <= anodo + 1;
		       else
		          anodo <= "00";
	           end if;
            end if;
        end if;
    end process;
    
    -- processo para definir segundos e minutos 
   
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
    display_unidade_segundos: display port map (uni_segundos, reg_uni_segundos);
    display_dezena_segundos: display port map (dez_segundos, reg_dez_segundos);
    display_unidade_minutos: display port map (uni_minutos, reg_uni_minutos);
    display_dezena_minutos: display port map (dez_minutos, reg_dez_minutos);
    
    with anodo select anodes <=
        anode_config_1 when "01",
        anode_config_2 when "10",
        anode_config_3 when "11",
        anode_config_0 when others;
        
    with anodo select cathodes <=
        reg_dez_segundos when "01",
        reg_uni_minutos when "10",
        reg_dez_minutos when "11",
        reg_uni_segundos when others;
    
end Behavioral;
