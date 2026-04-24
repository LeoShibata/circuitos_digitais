-- Exercicio 4a) Flip-flop D com resposta a borda POSITIVA do clock
-- Entradas preset (PRN) e clear (CLRN) assincronas, ativas em baixo.
-- Tabela verdade:
--   CLRN PRN CLK D | Q
--    0    x   x  x | 0
--    1    0   x  x | 1
--    1    1   ^  D | D
--    1    1 outro x| Q (mantem)

library ieee;
use ieee.std_logic_1164.all;

entity ff_d is
  port(
    D, CLK, PRN, CLRN : in  std_logic;
    Q, QN             : out std_logic
  );
end ff_d;

architecture ff_d_arch of ff_d is
  signal qstate : std_logic;
begin
  process(CLK, PRN, CLRN)
  begin
    if    CLRN = '0' then qstate <= '0';
    elsif PRN  = '0' then qstate <= '1';
    elsif CLK = '1' and CLK'event then
      qstate <= D;
    end if;
  end process;
  Q  <= qstate;
  QN <= not qstate;
end ff_d_arch;
