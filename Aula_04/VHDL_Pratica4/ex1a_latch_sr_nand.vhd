-- Exercicio 1a) Latch SR estilo NAND (entradas S_n e R_n ativas em BAIXO)
-- Versao comportamental (sem realimentacao combinacional explicita)
-- para evitar erro de "combinational loop" no Quartus.
--
-- Tabela verdade:
--   S_n R_n |  Q   QN
--    0   0  |  1   1   (proibido - evitar)
--    0   1  |  1   0   (set)
--    1   0  |  0   1   (reset)
--    1   1  |  Q   QN  (memoria)

library ieee;
use ieee.std_logic_1164.all;

entity latch_sr_nand is
  port(
    S_n, R_n : in  std_logic;
    Q, QN    : out std_logic
  );
end latch_sr_nand;

architecture latch_sr_nand_arch of latch_sr_nand is
  signal q_i  : std_logic;
  signal qn_i : std_logic;
begin
  process(S_n, R_n)
  begin
    if S_n = '0' and R_n = '0' then
      -- estado proibido: replica o que o NAND fisico faria (ambos em 1)
      q_i  <= '1';
      qn_i <= '1';
    elsif S_n = '0' and R_n = '1' then
      q_i  <= '1';
      qn_i <= '0';
    elsif S_n = '1' and R_n = '0' then
      q_i  <= '0';
      qn_i <= '1';
    end if;
    -- caso S_n=R_n=1: nada eh atribuido => Quartus infere LATCH (memoria)
  end process;

  Q  <= q_i;
  QN <= qn_i;
end latch_sr_nand_arch;
