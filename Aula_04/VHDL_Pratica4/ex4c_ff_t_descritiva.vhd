-- Exercicio 4c) Flip-flop T emulado a partir de FF D - VERSAO DESCRITIVA
-- Resposta a borda POSITIVA, PRN/CLRN assincronos ativos em baixo.
-- Tabela: T=0 -> Q mantem; T=1 -> Q = not Q (toggle).

library ieee;
use ieee.std_logic_1164.all;

entity ff_t_descritiva is
  port(
    T, CLK, PRN, CLRN : in  std_logic;
    Q, QN             : out std_logic
  );
end ff_t_descritiva;

architecture ff_t_descritiva_arch of ff_t_descritiva is
  signal qstate : std_logic;
begin
  process(CLK, PRN, CLRN)
  begin
    if    CLRN = '0' then qstate <= '0';
    elsif PRN  = '0' then qstate <= '1';
    elsif CLK = '1' and CLK'event then
      if T = '1' then qstate <= not qstate;
      end if;
    end if;
  end process;
  Q  <= qstate;
  QN <= not qstate;
end ff_t_descritiva_arch;
