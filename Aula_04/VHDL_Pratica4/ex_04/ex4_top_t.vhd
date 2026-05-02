-- Top-level do Exercicio 4 com FF T
-- Estrutura identica ao ex4_top_jk, trocando o FF JK pelo FF T.

library ieee;
use ieee.std_logic_1164.all;

entity ex4_top_t is
  port(
    clk50   : in  std_logic;
    T       : in  std_logic;
    CLRN    : in  std_logic;
    PRN     : in  std_logic;
    key_clk : in  std_logic;
    Q       : out std_logic;
    QN      : out std_logic
  );
end ex4_top_t;

architecture ex4_top_t_arch of ex4_top_t is
  component divider
    generic ( HALF_COUNT : integer := 250_000 );
    port( clk_in : in std_logic; rst_n : in std_logic := '1';
          clk_out : out std_logic );
  end component;

  component debounce
    port( sample_clk : in std_logic; btn_in : in std_logic;
          btn_out : out std_logic );
  end component;

  component ff_t_logica
    port( T, CLK, PRN, CLRN : in std_logic;
          Q, QN : out std_logic );
  end component;

  signal clk_100hz : std_logic;
  signal clk_clean : std_logic;
begin
  U_DIV : divider
    port map ( clk_in => clk50, rst_n => '1', clk_out => clk_100hz );

  U_DEB : debounce
    port map ( sample_clk => clk_100hz, btn_in => key_clk,
               btn_out => clk_clean );

  U_T : ff_t_logica
    port map ( T => T, CLK => clk_clean,
               PRN => PRN, CLRN => CLRN,
               Q => Q, QN => QN );
end ex4_top_t_arch;
