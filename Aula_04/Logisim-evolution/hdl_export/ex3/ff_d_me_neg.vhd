-- Exercicio 3b) Flip-flop D mestre-escravo com resposta a borda NEGATIVA do clock
-- Estrutura inversa da versao positiva: mestre transparente em CLK=1,
-- escravo transparente em CLK=0; efeito: copia D na descida.

library ieee;
use ieee.std_logic_1164.all;

entity ff_d_me_neg is
  port(
    D, CLK : in  std_logic;
    Q, QN  : out std_logic
  );
end ff_d_me_neg;

architecture latches of ff_d_me_neg is

  signal s1 : std_logic;    -- nó interligando latches
  signal qs : std_logic;    -- nó para saída do escravo
  
begin

  latch1: process(CLK, D)        -- Mestre: transparente em CLK='1'
  begin
    if CLK = '1' then s1 <= D;
    end if;
  end process latch1;

  latch2: process(CLK, s1)       -- Escravo: transparente em CLK='0'
  begin
    if CLK = '0' then qs <= s1;
    end if;
  end process latch2;

  Q  <= qs;
  QN <= not qs;
  
end latches;
