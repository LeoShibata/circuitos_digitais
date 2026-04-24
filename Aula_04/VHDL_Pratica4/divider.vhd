-- Divisor de frequencia: 50 MHz -> 100 Hz (periodo 10 ms)
-- Razao = 50_000_000 / 100 = 500_000 => meio ciclo = 250_000
-- A saida clk_out eh uma onda quadrada de 100 Hz usada para amostragem do debounce.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divider is
  generic (
    HALF_COUNT : integer := 250_000       -- 50MHz / (2*250_000) = 100 Hz
  );
  port(
    clk_in  : in  std_logic;              -- 50 MHz (pino 12)
    rst_n   : in  std_logic := '1';       -- reset assincrono ativo em baixo
    clk_out : out std_logic
  );
end divider;

architecture divider_arch of divider is
  signal cnt  : integer range 0 to HALF_COUNT-1 := 0;
  signal tout : std_logic := '0';
begin
  process(clk_in, rst_n)
  begin
    if rst_n = '0' then
      cnt  <= 0;
      tout <= '0';
    elsif rising_edge(clk_in) then
      if cnt = HALF_COUNT-1 then
        cnt  <= 0;
        tout <= not tout;
      else
        cnt  <= cnt + 1;
      end if;
    end if;
  end process;
  clk_out <= tout;
end divider_arch;
