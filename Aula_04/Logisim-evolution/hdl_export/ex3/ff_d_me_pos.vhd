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

-----------------------------------------------
entity ff_d_me_pos is
  port(
    D, CLK : in  std_logic;
    Q, QN  : out std_logic
  );
end ff_d_me_pos;
-----------------------------------------------

architecture latches of ff_d_me_pos is

  signal s1 : std_logic;      -- nó interligando latches
  signal qs : std_logic;      -- nó para saída do escravo

begin

  latch1: process(CLK, D)      -- latch mestre: transparente em CLK='0'
  begin
    if CLK = '0' then s1 <= D;
    end if;
  end process latch1;

  latch2: process(CLK, s1)     -- latch escravo: transparente em CLK='1'
  begin
    if CLK = '1' then qs <= s1;
    end if;
  end process latch2;

  Q  <= qs;
  QN <= not qs;
  
end latches;
