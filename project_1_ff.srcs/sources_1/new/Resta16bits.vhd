----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2025 17:36:55
-- Design Name: 
-- Module Name: Resta16bits - Behavioral
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

entity Resta16bits is
    port (
        a         : in  std_logic_vector(15 downto 0);
        b         : in  std_logic_vector(15 downto 0);
        s         : out std_logic_vector(15 downto 0);
        carry_out : out std_logic
    );
end Resta16bits;

architecture behavioral of Resta16bits is

    component Sumador16bits is
        port (
            a         : in  std_logic_vector(15 downto 0);
            b         : in  std_logic_vector(15 downto 0);
            cin       : in  std_logic;
            s         : out std_logic_vector(15 downto 0);
            carry_out : out std_logic
        );
    end component;

    signal b_invertido : std_logic_vector(15 downto 0);

begin
    -- Negamos bit a bit b
    b_invertido <= not b;

    -- Resta: a + not(b) + 1
    restador: Sumador16bits port map(
        a         => a,
        b         => b_invertido,
        cin       => '1',
        s         => s,
        carry_out => carry_out
    );

end behavioral;




