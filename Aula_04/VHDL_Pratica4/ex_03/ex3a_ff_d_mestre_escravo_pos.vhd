-- Exercicio 3a) Flip-flop D mestre-escravo com resposta a borda POSITIVA do clock
-- Estrutura: dois latches D em cascata
--   - Latch mestre transparente quando CLK=0 (usa CLK invertido como EN)
--   - Latch escravo transparente quando CLK=1
-- Efeito liquido: Q copia D na subida do clock.
-- Tabela verdade:
--   CLK (borda)  D  |  Q(t+)
--       ^          0 |   0
--       ^          1 |   1
--       outro      x |   Q (mantem)

library ieee;
use ieee.std_logic_1164.all;

entity ff_d_me_pos is
  port(
    D, CLK : in  std_logic;
    Q, QN  : out std_logic
  );
end ff_d_me_pos;

architecture ff_d_me_pos_arch of ff_d_me_pos is
  signal qm, qs : std_logic := '0';
begin
  process(CLK, D)
  begin
    -- latch mestre: transparente em CLK='0'
    if CLK = '0' then
      qm <= D;
    end if;
    -- latch escravo: transparente em CLK='1'
    if CLK = '1' then
      qs <= qm;
    end if;
  end process;
  Q  <= qs;
  QN <= not qs;
end ff_d_me_pos_arch;
