library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Basys3 is
    Port (
        sw          : in   std_logic_vector (15 downto 0); -- No Tocar - Señales de entrada de los interruptores -- Arriba   = '1'   -- Los 16 switches.
        btn         : in   std_logic_vector (4 downto 0);  -- No Tocar - Señales de entrada de los botones       -- Apretado = '1'   -- 0 central, 1 arriba, 2 izquierda, 3 derecha y 4 abajo.
        led         : out  std_logic_vector (15 downto 0); -- No Tocar - Señales de salida  a  los leds          -- Prendido = '1'   -- Los 16 leds.
        clk         : in   std_logic;                      -- No Tocar - Señal de entrada del clock              -- Frecuencia = 100Mhz.
        seg         : out  std_logic_vector (7 downto 0);  -- No Tocar - Salida de las señales de segmentos.
        an          : out  std_logic_vector (3 downto 0)   -- No Tocar - Salida del selector de diplay.
    );
end Basys3;

architecture Behavioral of Basys3 is

-- Inicio de la declaración de los componentes.
    
component Debouncer -- No Tocar
    Port (
        clk         : in    std_logic;
        signal_in   : in    std_logic;
        signal_out  : out   std_logic
    );
end component;
    
component Display_Controller -- No Tocar
    Port (  
        dis_a       : in    std_logic_vector (3 downto 0);
        dis_b       : in    std_logic_vector (3 downto 0);
        dis_c       : in    std_logic_vector (3 downto 0);
        dis_d       : in    std_logic_vector (3 downto 0);
        clk         : in    std_logic;
        seg         : out   std_logic_vector (7 downto 0);
        an          : out   std_logic_vector (3 downto 0)
    );
end component;
    
component Reg -- No Tocar
    Port (
        clock       : in    std_logic;
        clear       : in    std_logic;
        load        : in    std_logic;
        up          : in    std_logic;
        down        : in    std_logic;
        datain      : in    std_logic_vector (7 downto 0);
        dataout     : out   std_logic_vector (7 downto 0)
    );
end component;

component ALU -- No Tocar
    Port ( 
        a           : in    std_logic_vector (15 downto 0);
        b           : in    std_logic_vector (15 downto 0);
        sop         : in    std_logic_vector (2 downto 0);
        c           : out   std_logic;
        z           : out   std_logic;
        n           : out   std_logic;
        result      : out   std_logic_vector (15 downto 0)
    );
end component;

-- Componente RegisterFile agregado
component RegisterFile
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
end component;

-- Fin de la declaración de los componentes.

-- Inicio de la declaración de señales.

signal d_btn            : std_logic_vector(4 downto 0);  -- Señales de botones con anti-rebote.
signal dis_a            : std_logic_vector(3 downto 0);  -- Señales de salida al display A.    
signal dis_b            : std_logic_vector(3 downto 0);  -- Señales de salida al display B.     
signal dis_c            : std_logic_vector(3 downto 0);  -- Señales de salida al display C.    
signal dis_d            : std_logic_vector(3 downto 0);  -- Señales de salida al display D.
     
signal result           : std_logic_vector(15 downto 0);  
signal input_s          : std_logic_vector(15 downto 0);  

signal first_operator   : std_logic_vector(15 downto 0);
signal second_operator  : std_logic_vector(15 downto 0);

signal mux_output       : std_logic_vector(15 downto 0);
signal sel_mux_output   : std_logic_vector(1 downto 0);
signal general_selec    : std_logic;

signal status_out       : std_logic_vector(2 downto 0);
signal pc_out           : std_logic_vector(11 downto 0);

-- NUEVA señal para evitar conflictos
signal alu_input        : std_logic_vector(15 downto 0);

-- Fin de la declaración de señales.

begin

-- Inicio de declaración de comportamientos.

dis_a <= mux_output(15 downto 12);
dis_b <= mux_output(11 downto 8);
dis_c <= mux_output(7 downto 4);
dis_d <= mux_output(3 downto 0);

sel_mux_output <= d_btn(2 downto 1);
general_selec <= sw(2);
input_s <= sw;

-- NUEVO: mux de entrada para evitar doble asignación
with general_selec select
    alu_input <= result when '0',
                 sw     when others;

-- MUX de salida a display
with sel_mux_output select
    mux_output <= result          when "00",
                  input_s         when "01",
                  second_operator when "10",
                  first_operator  when others;

-- Instancia de Display_Controller.        
inst_Display_Controller: Display_Controller port map(
    dis_a => dis_a, 
    dis_b => dis_b, 
    dis_c => dis_c, 
    dis_d => dis_d,     
    clk   => clk,
    seg   => seg,
    an    => an
);

-- No Tocar - Instancias de Debouncers.    
inst_Debouncer0: Debouncer port map(clk => clk, signal_in => btn(0), signal_out => d_btn(0));
inst_Debouncer1: Debouncer port map(clk => clk, signal_in => btn(1), signal_out => d_btn(1));
inst_Debouncer2: Debouncer port map(clk => clk, signal_in => btn(2), signal_out => d_btn(2));
inst_Debouncer3: Debouncer port map(clk => clk, signal_in => btn(3), signal_out => d_btn(3));
inst_Debouncer4: Debouncer port map(clk => clk, signal_in => btn(4), signal_out => d_btn(4));

--Instancia de RegisterFile con conexiones según enunciado
inst_RegisterFile: RegisterFile port map(
    clk            => d_btn(0),
    clear          => sw(0),
    l_reg          => sw(6),
    s_reg          => sw(8 downto 7),
    select_first   => sw(12 downto 11),
    select_second  => sw(10 downto 9),
    input_data     => alu_input,
    alu_select     => sw(15 downto 13),
    first_operator  => first_operator,
    second_operator => second_operator,
    result          => result,
    status_out      => status_out,
    pc_out          => pc_out
);

-- LED para status y PC (como en el diagrama del enunciado)
led(15 downto 13) <= status_out;
led(11 downto 0)  <= pc_out;
led(12)           <= '0'; -- libre

-- Fin de declaración de comportamientos.

end Behavioral;
