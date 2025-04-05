----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2025 16:43:39
-- Design Name: 
-- Module Name: DemultiplexorCargaRegistro - Behavioral
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

entity DemultiplexorCargaRegistro is
    port (
        habilitar_escritura : in  std_logic;
        seleccion            : in  std_logic_vector(1 downto 0);
        load_a               : out std_logic;
        load_b               : out std_logic;
        load_c               : out std_logic;
        load_d               : out std_logic
    );
end DemultiplexorCargaRegistro;

architecture behavioral of DemultiplexorCargaRegistro is
begin
    load_a <= '1' when (habilitar_escritura = '1' and seleccion = "00") else '0';
    load_b <= '1' when (habilitar_escritura = '1' and seleccion = "01") else '0';
    load_c <= '1' when (habilitar_escritura = '1' and seleccion = "10") else '0';
    load_d <= '1' when (habilitar_escritura = '1' and seleccion = "11") else '0';
end behavioral;
