-- Exercicio 2a) Latch D transparente com portas NAND (versao otimizada 4 NANDs)
-- Quando EN=1, Q segue D; quando EN=0, mantem estado.
-- Tabela verdade:
--   EN  D  |  Q     QN
--    0  x  |  Q     QN   (memoria)
--    1  0  |  0     1
--    1  1  |  1     0

library ieee;
use ieee.std_logic_1164.all;

entity latch_d_nand is
  port(
    D, EN : in  std_logic;
    Q, QN : out std_logic
  );
end latch_d_nand;

architecture latch_d_nand_arch of latch_d_nand is
  signal s_n, r_n : std_logic;
  signal q_i, qn_i : std_logic;
begin
  -- etapa de entrada (2 NANDs) : gera S_n e R_n a partir de D e EN
  s_n <= D nand EN;                 -- S_n = NOT(D.EN)
  r_n <= (not D) nand EN;           -- R_n = NOT(D'.EN)  -- usa 1 inversor
  -- para ficar SOMENTE com 4 NANDs, pode-se substituir "not D" por (D nand D)
  -- etapa de memoria (latch SR-NAND)
  q_i  <= s_n nand qn_i;
  qn_i <= r_n nand q_i;
  Q  <= q_i;
  QN <= qn_i;
end latch_d_nand_arch;
