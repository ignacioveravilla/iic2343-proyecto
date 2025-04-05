----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2025 16:35:51
-- Design Name: 
-- Module Name: RegistroPC - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity RegistroPC is
    port (
        clk   : in  std_logic;
        clear : in  std_logic;
        load  : in  std_logic;
        d     : in  std_logic_vector(11 downto 0);
        q     : out std_logic_vector(11 downto 0)
    );
end RegistroPC;

architecture behavioral of RegistroPC is

    component ffd
        port (
            clk   : in  std_logic;
            d     : in  std_logic;
            load  : in  std_logic;
            clear : in  std_logic;
            q     : out std_logic
        );
    end component;

begin

    -- Instanciación de 12 flip-flops para el contador PC
    ff0:  ffd port map(clk => clk, d => d(0),  load => load, clear => clear, q => q(0));
    ff1:  ffd port map(clk => clk, d => d(1),  load => load, clear => clear, q => q(1));
    ff2:  ffd port map(clk => clk, d => d(2),  load => load, clear => clear, q => q(2));
    ff3:  ffd port map(clk => clk, d => d(3),  load => load, clear => clear, q => q(3));
    ff4:  ffd port map(clk => clk, d => d(4),  load => load, clear => clear, q => q(4));
    ff5:  ffd port map(clk => clk, d => d(5),  load => load, clear => clear, q => q(5));
    ff6:  ffd port map(clk => clk, d => d(6),  load => load, clear => clear, q => q(6));
    ff7:  ffd port map(clk => clk, d => d(7),  load => load, clear => clear, q => q(7));
    ff8:  ffd port map(clk => clk, d => d(8),  load => load, clear => clear, q => q(8));
    ff9:  ffd port map(clk => clk, d => d(9),  load => load, clear => clear, q => q(9));
    ff10: ffd port map(clk => clk, d => d(10), load => load, clear => clear, q => q(10));
    ff11: ffd port map(clk => clk, d => d(11), load => load, clear => clear, q => q(11));

end behavioral;