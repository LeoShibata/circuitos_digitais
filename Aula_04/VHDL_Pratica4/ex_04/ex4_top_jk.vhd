-- Top-level do Exercicio 4 com FF JK
-- Interliga: clk50MHz -> divider(100Hz) -> debounce(tecla CLK) -> FF JK
-- Entradas pela placa adicional: J, K, PRN, CLRN, tecla CLK (com repique).
-- Saidas: Q e QN para os pontos decimais dos displays 7s.

library ieee;
use ieee.std_logic_1164.all;

entity ex4_top_jk is
  port(
    clk50  : in  std_logic;    -- pino 12 da placa EPM240 (50 MHz)
    J      : in  std_logic;
    K      : in  std_logic;
    CLRN   : in  std_logic;    -- ativo em baixo
    PRN    : in  std_logic;    -- ativo em baixo (pode estar ligado a GND)
    key_clk: in  std_logic;    -- tecla fisica (com repique)
    Q      : out std_logic;
    QN     : out std_logic
  );
end ex4_top_jk;

architecture ex4_top_jk_arch of ex4_top_jk is
  component divider
    generic ( HALF_COUNT : integer := 250_000 );
    port( clk_in : in std_logic; rst_n : in std_logic := '1';
          clk_out : out std_logic );
  end component;

  component debounce
    port( sample_clk : in std_logic; btn_in : in std_logic;
          btn_out : out std_logic );
  end component;

  component ff_jk_logica
    port( J, K, CLK, PRN, CLRN : in std_logic;
          Q, QN : out std_logic );
  end component;

  signal clk_100hz  : std_logic;
  signal clk_clean  : std_logic;
begin
  U_DIV : divider
    port map ( clk_in => clk50, rst_n => '1', clk_out => clk_100hz );

  U_DEB : debounce
    port map ( sample_clk => clk_100hz, btn_in => key_clk,
               btn_out => clk_clean );

  U_JK  : ff_jk_logica
    port map ( J => J, K => K, CLK => clk_clean,
               PRN => PRN, CLRN => CLRN,
               Q => Q, QN => QN );
end ex4_top_jk_arch;
