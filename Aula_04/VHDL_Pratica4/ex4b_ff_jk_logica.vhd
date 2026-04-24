-- Exercicio 4b) Flip-flop JK emulado a partir de FF D - VERSAO EXPRESSAO LOGICA
-- D = J.Q' + K'.Q   (obtido pelo mapa de Karnaugh da conversao JK -> D)

library ieee;
use ieee.std_logic_1164.all;

entity ff_jk_logica is
  port(
    J, K, CLK, PRN, CLRN : in  std_logic;
    Q, QN                : out std_logic
  );
end ff_jk_logica;

architecture ff_jk_logica_arch of ff_jk_logica is
  signal qstate : std_logic;
begin
  process(CLK, PRN, CLRN)
  begin
    if    CLRN = '0' then qstate <= '0';
    elsif PRN  = '0' then qstate <= '1';
    elsif CLK = '1' and CLK'event then
      qstate <= (J and (not qstate)) or ((not K) and qstate);
    end if;
  end process;
  Q  <= qstate;
  QN <= not qstate;
end ff_jk_logica_arch;
