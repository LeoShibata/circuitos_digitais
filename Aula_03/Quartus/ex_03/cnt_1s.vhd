library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Contador binario de 4 bits (modulo 16), contagem crescente
-- com reset assincrono ativo alto
-- Gerado equivalente ao bloco IP LPM_COUNTER da Altera
-- (4 bits, Up only, Plain binary, Asynchronous Clear)

entity cnt_1s is
    port(
        clock : in  std_logic;
        aclr  : in  std_logic;
        q     : out std_logic_vector(3 downto 0)
    );
end cnt_1s;

architecture behavior of cnt_1s is
    signal count : std_logic_vector(3 downto 0);
begin
    process(clock, aclr)
    begin
        if aclr = '1' then
            count <= "0000";
        elsif rising_edge(clock) then
            count <= count + 1;
        end if;
    end process;
    q <= count;
end behavior;
