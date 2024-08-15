library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

use std.env.finish;

entity list1_5_tb is
--  Port ( );
end list1_5_tb;

architecture Behavioral of list1_5_tb is
    constant clk_hz : integer := 100e6;
    constant clk_period : time := 1 sec / clk_hz;

    signal clk : std_logic := '1';
    signal rst : std_logic := '1';
    signal cathodes: STD_LOGIC_VECTOR (6 downto 0);
    signal anodes: STD_LOGIC_VECTOR (3 downto 0);
begin
    clk <= not clk after clk_period / 2;

    DUT : entity work.list1_5(Behavioral)
    port map (
        clk => clk,
        rst => rst,
        anodes => anodes,
        cathodes => cathodes
    );

    process
    begin
        wait for clk_period * 2;
        rst <= '0';
        wait for clk_period * 1_000_000_000;
        finish;
    end process;

end Behavioral;
