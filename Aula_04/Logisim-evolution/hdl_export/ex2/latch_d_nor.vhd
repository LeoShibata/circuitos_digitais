-- Exercicio 2b) Latch D transparente com portas NOR (versao otimizada 4 NORs)
-- Quando EN=1, Q segue D; quando EN=0, mantem estado.

library ieee;
use ieee.std_logic_1164.all;

entity latch_d_nor is
  port(
    D, EN : in  std_logic;      -- entradas: habilitação e dados
    Q, QN : out std_logic       -- saídas: Q e Q invertido
  );
end latch_d_nor;

architecture arch_latch of latch_d_nor is
  signal qstate: std_logic;     -- sinal interno de memória
  
begin

  process(EN, D) 
  begin
    if EN = '0' then qstate <= D;            -- estado transparente: Q copia D
    end if;                                  -- inferência de memória quando EN = '0'
  end process;

  Q  <= qstate;
  QN <= not qstate;

end arch_latch;