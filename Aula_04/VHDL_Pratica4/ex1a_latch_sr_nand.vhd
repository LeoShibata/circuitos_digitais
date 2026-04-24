-- Exercicio 1a) Latch SR com portas NAND
-- Entradas ativas em baixo (S_n, R_n)
-- Tabela verdade:
--   S_n R_n |  Q   QN
--    0   0  |  1   1   (proibido)
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
  signal q_i, qn_i : std_logic;
begin
  q_i  <= S_n nand qn_i;
  qn_i <= R_n nand q_i;
  Q    <= q_i;
  QN   <= qn_i;
end latch_sr_nand_arch;
