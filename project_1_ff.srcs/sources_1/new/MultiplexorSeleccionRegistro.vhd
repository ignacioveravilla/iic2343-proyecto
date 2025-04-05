----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2025 16:38:54
-- Design Name: 
-- Module Name: MultiplexorSeleccionRegistro - Behavioral
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

entity MultiplexorSeleccionRegistro is
    port (
        reg_a     : in  std_logic_vector(15 downto 0);
        reg_b     : in  std_logic_vector(15 downto 0);
        reg_c     : in  std_logic_vector(15 downto 0);
        reg_d     : in  std_logic_vector(15 downto 0);
        seleccion : in  std_logic_vector(1 downto 0);
        salida    : out std_logic_vector(15 downto 0)
    );
end MultiplexorSeleccionRegistro;

architecture behavioral of MultiplexorSeleccionRegistro is
begin
    with seleccion select
        salida <= reg_a when "00",
                  reg_b when "01",
                  reg_c when "10",
                  reg_d when "11";
end behavioral;
