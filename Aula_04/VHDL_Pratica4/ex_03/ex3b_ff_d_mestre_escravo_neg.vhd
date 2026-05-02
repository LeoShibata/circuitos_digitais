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

architecture ff_d_me_neg_arch of ff_d_me_neg is
  signal qm, qs : std_logic := '0';
begin
  process(CLK, D)
  begin
    if CLK = '1' then
      qm <= D;
    end if;
    if CLK = '0' then
      qs <= qm;
    end if;
  end process;
  Q  <= qs;
  QN <= not qs;
end ff_d_me_neg_arch;
