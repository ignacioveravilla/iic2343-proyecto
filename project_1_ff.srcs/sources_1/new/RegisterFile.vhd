----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2025 16:52:57
-- Design Name: 
-- Module Name: RegisterFile - Behavioral
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

entity RegisterFile is
    port (
        clk           : in  std_logic;
        clear         : in  std_logic;
        l_reg         : in  std_logic;
        s_reg         : in  std_logic_vector(1 downto 0);
        select_first  : in  std_logic_vector(1 downto 0);
        select_second : in  std_logic_vector(1 downto 0);
        input_data    : in  std_logic_vector(15 downto 0);
        alu_select    : in  std_logic_vector(2 downto 0);
        
        first_operator  : out std_logic_vector(15 downto 0);
        second_operator : out std_logic_vector(15 downto 0);
        result          : out std_logic_vector(15 downto 0);
        status_out      : out std_logic_vector(2 downto 0);
        pc_out          : out std_logic_vector(11 downto 0)
    );
end RegisterFile;

architecture behavioral of RegisterFile is

    -- COMPONENTES
    component RegistroPC is
        port (
            clk   : in  std_logic;
            clear : in  std_logic;
            load  : in  std_logic;
            d     : in  std_logic_vector(11 downto 0);
            q     : out std_logic_vector(11 downto 0)
        );
    end component;

    component RegistroStatus is
        port (
            clk   : in  std_logic;
            clear : in  std_logic;
            load  : in  std_logic;
            d     : in  std_logic_vector(2 downto 0);
            q     : out std_logic_vector(2 downto 0)
        );
    end component;

    component ALU is
        port (
            a    : in  std_logic_vector(15 downto 0);
            b    : in  std_logic_vector(15 downto 0);
            sel  : in  std_logic_vector(2 downto 0);
            s    : out std_logic_vector(15 downto 0);
            czn  : out std_logic_vector(2 downto 0)
        );
    end component;

    component Registro16 is
        port (
            clk   : in  std_logic;
            clear : in  std_logic;
            load  : in  std_logic;
            d     : in  std_logic_vector(15 downto 0);
            q     : out std_logic_vector(15 downto 0)
        );
    end component;

    component DemultiplexorCargaRegistro is
        port (
            habilitar_escritura : in  std_logic;
            seleccion            : in  std_logic_vector(1 downto 0);
            load_a               : out std_logic;
            load_b               : out std_logic;
            load_c               : out std_logic;
            load_d               : out std_logic
        );
    end component;

    component MultiplexorSeleccionRegistro is
        port (
            reg_a     : in  std_logic_vector(15 downto 0);
            reg_b     : in  std_logic_vector(15 downto 0);
            reg_c     : in  std_logic_vector(15 downto 0);
            reg_d     : in  std_logic_vector(15 downto 0);
            seleccion : in  std_logic_vector(1 downto 0);
            salida    : out std_logic_vector(15 downto 0)
        );
    end component;

    -- SEÑALES INTERNAS
    signal q_a, q_b, q_c, q_d       : std_logic_vector(15 downto 0);
    signal load_a, load_b, load_c, load_d : std_logic;
    signal op1, op2                 : std_logic_vector(15 downto 0);
    signal czn_interno             : std_logic_vector(2 downto 0);
    signal pc_actual               : std_logic_vector(11 downto 0);
    signal pc_next                 : std_logic_vector(11 downto 0);

begin

    -- REGISTRO STATUS
    status_reg: RegistroStatus port map(
        clk   => clk,
        clear => clear,
        load  => '1',
        d     => czn_interno,
        q     => status_out
    );

    -- CONTADOR CLÁSICO DE PC (sin librerías, sin process)
    pc_next(0)  <= not pc_actual(0);
    pc_next(1)  <= pc_actual(1) xor (pc_actual(0));
    pc_next(2)  <= pc_actual(2) xor (pc_actual(1) and pc_actual(0));
    pc_next(3)  <= pc_actual(3) xor (pc_actual(2) and pc_actual(1) and pc_actual(0));
    pc_next(4)  <= pc_actual(4) xor (pc_actual(3) and pc_actual(2) and pc_actual(1) and pc_actual(0));
    pc_next(5)  <= pc_actual(5) xor (pc_actual(4) and pc_actual(3) and pc_actual(2) and pc_actual(1) and pc_actual(0));
    pc_next(6)  <= pc_actual(6) xor (pc_actual(5) and pc_actual(4) and pc_actual(3) and pc_actual(2) and pc_actual(1) and pc_actual(0));
    pc_next(7)  <= pc_actual(7) xor (pc_actual(6) and pc_actual(5) and pc_actual(4) and pc_actual(3) and pc_actual(2) and pc_actual(1) and pc_actual(0));
    pc_next(8)  <= pc_actual(8) xor (pc_actual(7) and pc_actual(6) and pc_actual(5) and pc_actual(4) and pc_actual(3) and pc_actual(2) and pc_actual(1) and pc_actual(0));
    pc_next(9)  <= pc_actual(9) xor (pc_actual(8) and pc_actual(7) and pc_actual(6) and pc_actual(5) and pc_actual(4) and pc_actual(3) and pc_actual(2) and pc_actual(1) and pc_actual(0));
    pc_next(10) <= pc_actual(10) xor (pc_actual(9) and pc_actual(8) and pc_actual(7) and pc_actual(6) and pc_actual(5) and pc_actual(4) and pc_actual(3) and pc_actual(2) and pc_actual(1) and pc_actual(0));
    pc_next(11) <= pc_actual(11) xor (pc_actual(10) and pc_actual(9) and pc_actual(8) and pc_actual(7) and pc_actual(6) and pc_actual(5) and pc_actual(4) and pc_actual(3) and pc_actual(2) and pc_actual(1) and pc_actual(0));

    pc_reg: RegistroPC port map(
        clk   => clk,
        clear => clear,
        load  => '1',
        d     => pc_next,
        q     => pc_actual
    );

    pc_out <= pc_actual;

    -- ALU
    alu_inst: ALU port map(
        a    => op1,
        b    => op2,
        sel  => alu_select,
        s    => result,
        czn  => czn_interno
    );

    first_operator  <= op1;
    second_operator <= op2;

    -- REGISTROS A-D
    reg_a_inst: Registro16 port map(clk => clk, clear => clear, load => load_a, d => input_data, q => q_a);
    reg_b_inst: Registro16 port map(clk => clk, clear => clear, load => load_b, d => input_data, q => q_b);
    reg_c_inst: Registro16 port map(clk => clk, clear => clear, load => load_c, d => input_data, q => q_c);
    reg_d_inst: Registro16 port map(clk => clk, clear => clear, load => load_d, d => input_data, q => q_d);

    -- DEMUX de escritura
    demux_inst: DemultiplexorCargaRegistro port map(
        habilitar_escritura => l_reg,
        seleccion            => s_reg,
        load_a               => load_a,
        load_b               => load_b,
        load_c               => load_c,
        load_d               => load_d
    );

    -- MUX de lectura
    mux_first: MultiplexorSeleccionRegistro port map(
        reg_a     => q_a,
        reg_b     => q_b,
        reg_c     => q_c,
        reg_d     => q_d,
        seleccion => select_first,
        salida    => op1
    );

    mux_second: MultiplexorSeleccionRegistro port map(
        reg_a     => q_a,
        reg_b     => q_b,
        reg_c     => q_c,
        reg_d     => q_d,
        seleccion => select_second,
        salida    => op2
    );

end behavioral;
