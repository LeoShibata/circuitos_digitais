-- Exercicio 4c) Flip-flop T emulado a partir de FF D - VERSAO EXPRESSAO LOGICA
-- D = T xor Q

library ieee;
use ieee.std_logic_1164.all;

entity ff_t_logica is
  port(
    T, CLRN, PRN, CLK : in  std_logic;
    Q, QN             : out std_logic
  );
end ff_t_logica;

architecture behavior of ff_t_logica is

  signal qstate : std_logic;
  
begin
  process(CLK, PRN, CLRN)
  begin
    if    CLRN = '0' then qstate <= '0';
    elsif PRN  = '0' then qstate <= '1';
    elsif CLK = '1' and CLK'event then     -- Borda POSITIVA
	  -- Expressão booleana D = T XOR Q
      qstate <= T xor qstate;
    end if;
  end process;
  
  Q  <= qstate;
  QN <= not qstate;
  
end behavior;
