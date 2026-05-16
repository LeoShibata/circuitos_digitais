library ieee;
use ieee.std_logic_1164.all;

entity ex4_top_d is
  port(
    CLOCK_50 : in  std_logic; 
    KEY_CLK  : in  std_logic; 
    D_in     : in  std_logic; -- Chave para a entrada D
    CLRN_in  : in  std_logic; 
    Q_out    : out std_logic; 
    QN_out   : out std_logic  
  );
end ex4_top_d;

architecture structural of ex4_top_d is
  signal fio_clk_100hz : std_logic;
  signal fio_clk_limpo : std_logic;

  component divider is
    generic(divisor: integer := 5);
    port(clk_in : in std_logic; rst : in std_logic; clk_out : out std_logic);
  end component;

  component debounce_v1 is
    generic(counter_size : INTEGER := 1);
    port(clk : IN STD_LOGIC; button : IN STD_LOGIC; result : OUT STD_LOGIC);
  end component;

  component ex4a_ff_d is
    port(D, CLRN_in, PRN_in, CLK : in std_logic; Q_out, QN_out : out std_logic);
  end component;

begin
  U1_DIV: divider
    generic map (divisor => 250000) 
    port map (clk_in => CLOCK_50, rst => '0', clk_out => fio_clk_100hz);

  U2_DEB: debounce_v1
    generic map (counter_size => 1) 
    port map (clk => fio_clk_100hz, button => KEY_CLK, result => fio_clk_limpo);

  U3_FF: ex4a_ff_d
    port map (
      D       => D_in,
      CLRN_in => CLRN_in,
      PRN_in  => '1',         -- Força o Preset inativo (foge do jumper)
      CLK     => fio_clk_limpo, 
      Q_out   => Q_out,
      QN_out  => QN_out
    );
end structural;