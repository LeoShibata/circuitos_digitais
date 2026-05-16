	-- Top-level do Exercicio 4 com FF T
-- Estrutura identica ao ex4_top_jk, trocando o FF JK pelo FF T.

library ieee;
use ieee.std_logic_1164.all;

entity ex4_top_t is
  port(
    CLOCK_50 : in  std_logic; -- 50 MHz vindo do pino 12 da placa
    KEY_CLK  : in  std_logic; -- Tecla com repique (botão de clock)
    T_in     : in  std_logic; -- Chave para a entrada T
    PRN_in   : in  std_logic; -- Chave para Preset
    CLRN_in  : in  std_logic; -- Chave para Clear
    RST_in   : in  std_logic; -- Chave de Reset geral para o divisor
    Q_out    : out std_logic; -- LED para a saída Q
    QN_out   : out std_logic  -- LED para a saída QN
  );
end ex4_top_t;

architecture structural of ex4_top_t is

  signal fio_clk_100hz : std_logic;
  signal fio_clk_limpo : std_logic;

  -- Declarando o componente Divisor
  component divider is
    generic(divisor: integer := 5);
    port(
      clk_in  : in  std_logic;
      rst     : in  std_logic;
      clk_out : out std_logic
    );
  end component;

  -- Declarando o componente Debounce
  component debounce_v1 is
    generic(counter_size : INTEGER := 1);
    port(
      clk    : IN  STD_LOGIC;
      button : IN  STD_LOGIC;
      result : OUT STD_LOGIC
    );
  end component;

  -- Declarando o seu Flip-Flop (T descritiva)
  component ff_t_descritiva is
    port(
      T, CLRN, PRN, CLK : in std_logic;
      Q, QN: out std_logic
    );
  end component;

begin

  -- Instanciando e conectando o Divisor
  U1_DIV: divider
    generic map (divisor => 250000) -- Ajustado para gerar 100 Hz a partir de 50 MHz
    port map (
      clk_in  => CLOCK_50,
      rst     => '0',
      clk_out => fio_clk_100hz      -- Saída vai para o fio interno
    );

  -- Instanciando e conectando o Debounce
  U2_DEB: debounce_v1
    generic map (counter_size => 1) 
    port map (
      clk    => fio_clk_100hz,      -- Recebe o clock de 100 Hz do divisor
      button => KEY_CLK,            -- Recebe a tecla com repique
      result => fio_clk_limpo       -- Entrega o sinal estabilizado no fio interno
    );

  -- Instanciando e conectando o Flip-Flop
  U3_FF: ff_t_descritiva
    port map (
      T    => T_in,
      CLRN => CLRN_in,
      PRN  => '1',
      CLK  => fio_clk_limpo,        -- Recebe o clock LIMPO (sem repique)
      Q    => Q_out,
      QN   => QN_out
    );

end structural;