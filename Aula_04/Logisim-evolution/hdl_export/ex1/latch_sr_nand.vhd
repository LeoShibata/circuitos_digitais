library ieee;
use ieee.std_logic_1164.all;

entity latch_sr_nand is
  port(
    S, R  : in  std_logic;      -- SET e RESET
    Q, QN : out std_logic       -- Saídas Q e Q invertido
  );
end latch_sr_nand;

architecture type_architecture of latch_sr_nand is

signal qstate: std_logic;

begin

  process(S, R) 
  begin
    if S = '0' and R = '1' then qstate <= '1';
    elsif S = '1' and R = '0' then qstate <= '0';
    end if;
  end process;

  Q  <= qstate;
  QN <= not qstate;

end type_architecture;