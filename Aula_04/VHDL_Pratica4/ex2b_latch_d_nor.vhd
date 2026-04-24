-- Exercicio 2b) Latch D transparente com portas NOR (versao otimizada 4 NORs)
-- Quando EN=1, Q segue D; quando EN=0, mantem estado.

library ieee;
use ieee.std_logic_1164.all;

entity latch_d_nor is
  port(
    D, EN : in  std_logic;
    Q, QN : out std_logic
  );
end latch_d_nor;

architecture latch_d_nor_arch of latch_d_nor is
  signal s_i, r_i : std_logic;
  signal q_i, qn_i : std_logic;
begin
  -- etapa de entrada: gera S e R a partir de D e EN usando NORs
  -- S = D.EN  ; R = D'.EN
  -- com NORs: S = NOR( NOR(D,D), NOR(EN,EN) )  -- nao otimizado
  -- versao otimizada (4 NORs no total contando o latch):
  s_i <= not ((not D) nor (not EN));   -- equivalente a D.EN
  r_i <= not (D       nor (not EN));   -- equivalente a D'.EN
  -- latch SR-NOR
  q_i  <= r_i nor qn_i;
  qn_i <= s_i nor q_i;
  Q  <= q_i;
  QN <= qn_i;
end latch_d_nor_arch;
