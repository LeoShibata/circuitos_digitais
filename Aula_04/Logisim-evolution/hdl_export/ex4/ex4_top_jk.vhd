-- Top-level do Exercicio 4 com FF JK
-- Interliga: clk50MHz -> divider(100Hz) -> debounce(tecla CLK) -> FF JK
-- Entradas pela placa adicional: J, K, PRN, CLRN, tecla CLK (com repique).
-- Saidas: Q e QN para os pontos decimais dos displays 7s.

library ieee;
use ieee.std_logic_1164.all;

entity ex4_top_jk is
  port(
    CLOCK_50 : in  std_logic; -- 50 MHz vindo do pino 12 da placa
    KEY_CLK  : in  std_logic; -- Tecla com repique (botão de clock)
    J_in     : in  std_logic; -- Chave para a entrada J
    K_in     : in  std_logic; -- Chave para a entrada K
    PRN_in   : in  std_logic; -- Chave para Preset
    CLRN_in  : in  std_logic; -- Chave para Clear
    RST_in   : in  std_logic; -- Chave de Reset geral para o divisor
    Q_out    : out std_logic; -- LED para a saída Q
    QN_out   : out std_logic  -- LED para a saída QN
  );
end ex4_top_jk;

architecture structural of ex4_top_jk is

  signal fio_clk_100hz : std_logic;
  signal fio_clk_limpo : std_logic;

  -- Componente Divisor
  component divider is
    generic(divisor: integer := 5);
    port(
      clk_in  : in  std_logic;
      rst     : in  std_logic;
      clk_out : out std_logic
    );
  end component;

  -- Componente Debounce
  component debounce_v1 is
    generic(counter_size : INTEGER := 1);
    port(
      clk    : IN  STD_LOGIC;
      button : IN  STD_LOGIC;
      result : OUT STD_LOGIC
    );
  end component;

  -- Componente Flip-Flop JK
  component ff_jk_descritiva is
    port(
      J, K, CLRN, PRN, CLK : in std_logic;
      Q, QN: out std_logic
    );
  end component;

begin

  -- Instanciando o Divisor (Gera os 100 Hz)
  U1_DIV: divider
    generic map (divisor => 250000) 
    port map (
      clk_in  => CLOCK_50,
      rst     => '0',
      clk_out => fio_clk_100hz
    );

  -- Instanciando o Debounce (Limpa o sinal do botão)
  U2_DEB: debounce_v1
    generic map (counter_size => 1) 
    port map (
      clk    => fio_clk_100hz,
      button => KEY_CLK,
      result => fio_clk_limpo
    );

  -- Instanciando o Flip-Flop JK
  U3_FF: ff_jk_descritiva
    port map (
      J    => J_in,                 -- Liga a chave J
      K    => K_in,                 -- Liga a chave K
      CLRN => CLRN_in,
      PRN  => '1',                  -- O VHDL injeta '1' e ignora o jumper que está no GND
      CLK  => fio_clk_limpo,        -- Recebe o clock LIMPO do debounce
      Q    => Q_out,
      QN   => QN_out
    );

end structural;