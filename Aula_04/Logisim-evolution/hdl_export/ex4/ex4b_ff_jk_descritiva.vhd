-- Exercicio 4b) Flip-flop JK emulado a partir de FF D - VERSAO DESCRITIVA
-- Resposta a borda POSITIVA do clock, PRN/CLRN assincronos ativos em baixo.
-- Tabela verdade:
--   J K | Q(t+)
--   0 0 |  Q
--   0 1 |  0
--   1 0 |  1
--   1 1 |  not Q

library ieee;
use ieee.std_logic_1164.all;

entity ff_jk_descritiva is
  port(
    J, K, CLRN, PRN, CLK : in  std_logic;
    Q, QN                : out std_logic
  );
end ff_jk_descritiva;

architecture behavior of ff_jk_descritiva is

  signal qstate : std_logic;
  
begin

  process(CLK, PRN, CLRN)
  begin
    if    CLRN = '0' then qstate <= '0';
    elsif PRN  = '0' then qstate <= '1';
    
	elsif CLK = '1' and CLK'event then       -- Ajustado para borda positiva
      if    J = '1' and K = '1' then qstate <= not qstate;    -- Toggle
      elsif J = '1' and K = '0' then qstate <= '1';           -- Set
      elsif J = '0' and K = '1' then qstate <= '0';           -- Reset
      end if;
    end if;
  end process;
  
  Q  <= qstate;
  QN <= not qstate;
  
end behavior;

