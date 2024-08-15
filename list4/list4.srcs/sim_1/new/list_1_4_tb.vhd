library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.finish;

entity list1_tb is
end list1_tb;

architecture sim of list1_tb is
    constant clk_hz : integer := 100e6;
    constant clk_period : time := 1 sec / clk_hz;

    signal clk : std_logic := '1';
    signal rst : std_logic := '1';
    signal cont_uni_segundos: STD_LOGIC_VECTOR (6 downto 0);
    signal cont_dez_segundos: STD_LOGIC_VECTOR (6 downto 0);
    signal cont_uni_minutos: STD_LOGIC_VECTOR (6 downto 0);
    signal cont_dez_minutos: STD_LOGIC_VECTOR (6 downto 0);
    
begin


    clk <= not clk after clk_period / 2;

    DUT : entity work.list1_4(rtl)
    port map (
        clk => clk,
        rst => rst,
        cont_uni_segundos => cont_uni_segundos,
        cont_dez_segundos => cont_dez_segundos,
        cont_uni_minutos => cont_uni_minutos,
        cont_dez_minutos  => cont_dez_minutos
    );

    process
    begin
        wait for clk_period * 2;
        rst <= '0';
        wait for clk_period * 1_000_000_000;
        finish;
    end process;
end architecture;