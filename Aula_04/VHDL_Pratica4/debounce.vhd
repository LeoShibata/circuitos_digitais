-- Circuito anti-repique (debounce)
-- Amostra a entrada bruta (btn_in) usando um clock lento (sample_clk, 100 Hz = 10 ms).
-- So propaga mudanca em btn_out quando N amostras consecutivas sao iguais.
-- Com N=3 e 10 ms/amostra => janela estavel minima = ~20 ms (filtra repiques tipicos).
-- A saida tem mesma polaridade da entrada (botao normalmente em '1', pressionado '0').

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debounce is
  port(
    sample_clk : in  std_logic;   -- clock lento vindo do divider (100 Hz)
    btn_in     : in  std_logic;   -- botao cru com repique
    btn_out    : out std_logic    -- botao estavel (sem repique)
  );
end debounce;

architecture debounce_arch of debounce is
  signal sr    : std_logic_vector(2 downto 0) := (others => '1');
  signal state : std_logic := '1';
begin
  process(sample_clk)
  begin
    if rising_edge(sample_clk) then
      sr <= sr(1 downto 0) & btn_in;   -- shift register de 3 amostras
      if    sr = "000" then state <= '0';
      elsif sr = "111" then state <= '1';
      end if;
    end if;
  end process;
  btn_out <= state;
end debounce_arch;
