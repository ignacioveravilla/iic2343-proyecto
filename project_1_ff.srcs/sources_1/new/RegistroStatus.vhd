----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2025 16:33:12
-- Design Name: 
-- Module Name: RegistroStatus - Behavioral
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

entity RegistroStatus is
    port (
        clk   : in  std_logic;
        clear : in  std_logic;
        load  : in  std_logic;
        d     : in  std_logic_vector(2 downto 0);
        q     : out std_logic_vector(2 downto 0)
    );
end RegistroStatus;

architecture behavioral of RegistroStatus is
    component FFD
        port (
            clk   : in  std_logic;
            d     : in  std_logic;
            load  : in  std_logic;
            clear : in  std_logic;
            q     : out std_logic
        );
    end component;
begin
    ff0: FFD port map(clk => clk, d => d(0), load => load, clear => clear, q => q(0)); -- C
    ff1: FFD port map(clk => clk, d => d(1), load => load, clear => clear, q => q(1)); -- Z
    ff2: FFD port map(clk => clk, d => d(2), load => load, clear => clear, q => q(2)); -- N
end behavioral;
