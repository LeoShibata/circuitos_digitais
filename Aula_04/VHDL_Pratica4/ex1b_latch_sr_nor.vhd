-- Exercicio 1b) Latch SR com portas NOR
-- Entradas ativas em alto (S, R)
-- Tabela verdade:
--    S   R  |  Q   QN
--    0   0  |  Q   QN  (memoria)
--    0   1  |  0   1   (reset)
--    1   0  |  1   0   (set)
--    1   1  |  0   0   (proibido)

library ieee;
use ieee.std_logic_1164.all;

entity latch_sr_nor is
  port(
    S, R  : in  std_logic;
    Q, QN : out std_logic
  );
end latch_sr_nor;

architecture latch_sr_nor_arch of latch_sr_nor is
  signal q_i, qn_i : std_logic;
begin
  q_i  <= R nor qn_i;
  qn_i <= S nor q_i;
  Q    <= q_i;
  QN   <= qn_i;
end latch_sr_nor_arch;
