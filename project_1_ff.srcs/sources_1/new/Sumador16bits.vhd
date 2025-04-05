----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2025 17:35:51
-- Design Name: 
-- Module Name: Sumador16bits - Behavioral
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

entity Sumador16bits is
    port (
        a         : in  std_logic_vector(15 downto 0);
        b         : in  std_logic_vector(15 downto 0);
        cin       : in  std_logic;
        s         : out std_logic_vector(15 downto 0);
        carry_out : out std_logic
    );
end Sumador16bits;

architecture behavioral of Sumador16bits is

    component FullAdder is
        port (
            a     : in  std_logic;
            b     : in  std_logic;
            cin   : in  std_logic;
            sum   : out std_logic;
            carry : out std_logic
        );
    end component;

    signal carry : std_logic_vector(15 downto 0);

begin

    -- Bit 0: usa cin externo
    fa0: FullAdder port map(a => a(0), b => b(0), cin => cin, sum => s(0), carry => carry(0));

    -- Bits 1 al 14: usan carry anterior
    fa1:  FullAdder port map(a => a(1),  b => b(1),  cin => carry(0),  sum => s(1),  carry => carry(1));
    fa2:  FullAdder port map(a => a(2),  b => b(2),  cin => carry(1),  sum => s(2),  carry => carry(2));
    fa3:  FullAdder port map(a => a(3),  b => b(3),  cin => carry(2),  sum => s(3),  carry => carry(3));
    fa4:  FullAdder port map(a => a(4),  b => b(4),  cin => carry(3),  sum => s(4),  carry => carry(4));
    fa5:  FullAdder port map(a => a(5),  b => b(5),  cin => carry(4),  sum => s(5),  carry => carry(5));
    fa6:  FullAdder port map(a => a(6),  b => b(6),  cin => carry(5),  sum => s(6),  carry => carry(6));
    fa7:  FullAdder port map(a => a(7),  b => b(7),  cin => carry(6),  sum => s(7),  carry => carry(7));
    fa8:  FullAdder port map(a => a(8),  b => b(8),  cin => carry(7),  sum => s(8),  carry => carry(8));
    fa9:  FullAdder port map(a => a(9),  b => b(9),  cin => carry(8),  sum => s(9),  carry => carry(9));
    fa10: FullAdder port map(a => a(10), b => b(10), cin => carry(9),  sum => s(10), carry => carry(10));
    fa11: FullAdder port map(a => a(11), b => b(11), cin => carry(10), sum => s(11), carry => carry(11));
    fa12: FullAdder port map(a => a(12), b => b(12), cin => carry(11), sum => s(12), carry => carry(12));
    fa13: FullAdder port map(a => a(13), b => b(13), cin => carry(12), sum => s(13), carry => carry(13));
    fa14: FullAdder port map(a => a(14), b => b(14), cin => carry(13), sum => s(14), carry => carry(14));
    fa15: FullAdder port map(a => a(15), b => b(15), cin => carry(14), sum => s(15), carry => carry_out);

end behavioral;

