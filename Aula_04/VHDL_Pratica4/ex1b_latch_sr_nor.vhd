-- Exercicio 1b) Latch SR estilo NOR (entradas S e R ativas em ALTO)
-- Versao comportamental (sem realimentacao combinacional explicita)
-- para evitar erro de "combinational loop" no Quartus.
--
-- Tabela verdade:
--   S   R |  Q   QN
--   0   0 |  Q   QN  (memoria)
--   0   1 |  0   1   (reset)
--   1   0 |  1   0   (set)
--   1   1 |  0   0   (proibido)
--
-- Atencao: na placa do laboratorio os botoes estao em '1' em repouso.
-- Para usar este latch direto com os botoes, INVERTA os sinais antes
-- (ou troque pelo latch NAND, que ja eh ativo em baixo).

library ieee;
use ieee.std_logic_1164.all;

entity latch_sr_nor is
  port(
    S, R  : in  std_logic;
    Q, QN : out std_logic
  );
end latch_sr_nor;

architecture latch_sr_nor_arch of latch_sr_nor is
  signal q_i  : std_logic;
  signal qn_i : std_logic;
begin
  process(S, R)
  begin
    if S = '1' and R = '1' then
      -- estado proibido: replica o que o NOR fisico faria (ambos em 0)
      q_i  <= '0';
      qn_i <= '0';
    elsif S = '1' and R = '0' then
      q_i  <= '1';
      qn_i <= '0';
    elsif S = '0' and R = '1' then
      q_i  <= '0';
      qn_i <= '1';
    end if;
    -- caso S=R=0: nada eh atribuido => Quartus infere LATCH (memoria)
  end process;

  Q  <= q_i;
  QN <= qn_i;
end latch_sr_nor_arch;
