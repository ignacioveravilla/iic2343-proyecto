----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2025 16:47:37
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
    port (
        a    : in  std_logic_vector(15 downto 0);
        b    : in  std_logic_vector(15 downto 0);
        sel  : in  std_logic_vector(2 downto 0);
        s    : out std_logic_vector(15 downto 0);
        czn  : out std_logic_vector(2 downto 0)
    );
end ALU;

architecture behavioral of ALU is

    -- Componentes
    component Sumador16bits is
        port (
            a         : in  std_logic_vector(15 downto 0);
            b         : in  std_logic_vector(15 downto 0);
            cin       : in  std_logic;
            s         : out std_logic_vector(15 downto 0);
            carry_out : out std_logic
        );
    end component;

    component Resta16bits is
        port (
            a         : in  std_logic_vector(15 downto 0);
            b         : in  std_logic_vector(15 downto 0);
            s         : out std_logic_vector(15 downto 0);
            carry_out : out std_logic
        );
    end component;

    -- Señales internas
    signal suma_resultado       : std_logic_vector(15 downto 0);
    signal resta_resultado      : std_logic_vector(15 downto 0);
    signal carry_suma           : std_logic;
    signal carry_resta          : std_logic;
    signal logica_resultado     : std_logic_vector(15 downto 0);
    signal resultado_final      : std_logic_vector(15 downto 0); -- <- NUEVA SEÑAL

begin

    -- Instancia del sumador
    sumador_inst: Sumador16bits port map(
        a         => a,
        b         => b,
        cin       => '0',
        s         => suma_resultado,
        carry_out => carry_suma
    );

    -- Instancia del restador
    restador_inst: Resta16bits port map(
        a         => a,
        b         => b,
        s         => resta_resultado,
        carry_out => carry_resta
    );

    -- Operaciones lógicas
    with sel select
        logica_resultado <= a and b         when "010",
                            a or  b         when "011",
                            a xor b         when "100",
                            not a           when "101",
                            (others => '0') when others;

    -- Resultado final
    with sel select
        resultado_final <= suma_resultado   when "000",
                          resta_resultado   when "001",
                          logica_resultado  when others;

    s <= resultado_final;

    -- Banderas
    with sel select
        czn(2) <= carry_suma  when "000",
                  carry_resta when "001",
                  '0'         when others;

    czn(1) <= '1' when resultado_final = x"0000" else '0'; -- Z
    czn(0) <= resultado_final(15);                         -- N

end behavioral;
