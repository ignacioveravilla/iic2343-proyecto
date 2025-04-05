library ieee;
use ieee.std_logic_1164.all;

entity ffd is
    port (
        clk   : in  std_logic;
        d     : in  std_logic;
        load  : in  std_logic;
        clear : in  std_logic;
        q     : out std_logic
    );
end ffd;

architecture behavioral of ffd is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if clear = '1' then
                q <= '0';
            elsif load = '1' then
                q <= d;
            end if;
        end if;
    end process;
end behavioral;
