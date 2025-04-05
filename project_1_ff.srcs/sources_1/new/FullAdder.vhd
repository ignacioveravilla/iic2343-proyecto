----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2025 17:35:05
-- Design Name: 
-- Module Name: FullAdder - Behavioral
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

entity FullAdder is
    port (
        a     : in  std_logic;
        b     : in  std_logic;
        cin   : in  std_logic;
        sum   : out std_logic;
        carry : out std_logic
    );
end FullAdder;

architecture behavioral of FullAdder is
begin
    -- suma = a xor b xor cin
    -- carry = (a and b) or (a and cin) or (b and cin)
    sum   <= a xor b xor cin;
    carry <= (a and b) or (a and cin) or (b and cin);
end behavioral;

