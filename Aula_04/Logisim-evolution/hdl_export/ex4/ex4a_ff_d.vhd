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

entity ex4a_ff_d is
  port(
    D, CLRN, PRN, CLK : in  std_logic;
    Q, QN             : out std_logic
  );
end ex4a_ff_d;

architecture behavior of ex4a_ff_d is

  signal qstate : std_logic;

begin

  process(CLK, PRN, CLRN)
  begin
    if    CLRN = '0' then qstate <= '0';           -- O Clear tem a maior prioridade e força 0 na saída
    elsif PRN  = '0' then qstate <= '1';           -- O Present tem a segunda maior prioridade e força 1 na saída
	
	-- Se nem Clear nem Preset estão ativos (ambos em '1'),
	-- o circuito opera normalment na borda de subida do clock
    elsif CLK = '1' and CLK'event then qstate <= D;  
    end if;
  end process;
  
  Q  <= qstate;
  QN <= not qstate;

end behavior;
