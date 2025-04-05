----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2025 17:34:21
-- Design Name: 
-- Module Name: HalfAdder - Behavioral
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

entity HalfAdder is
    port (
        a     : in  std_logic;
        b     : in  std_logic;
        sum   : out std_logic;
        carry : out std_logic
    );
end HalfAdder;

architecture behavioral of HalfAdder is
begin
    sum   <= a xor b; -- Suma sin acarreo
    carry <= a and b; -- Acarreo si ambos son 1
end behavioral;

