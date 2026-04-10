library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Divisor de frequencia: contador modulo 50.000.000
-- Conta de 0 a 49.999.999 e emite um pulso de carry-out (cout)
-- Equivalente ao LPM_COUNTER da Altera (modulus=50000000, carry-out)
-- Entrada: clock 50 MHz (PIN_12)
-- Saida:   cout = 1 pulso por segundo (1 Hz)

entity cnt_50M is
    port(
        clock : in  std_logic;
        aclr  : in  std_logic;
        cout  : out std_logic
    );
end cnt_50M;

architecture behavior of cnt_50M is
    -- 2^26 = 67.108.864 > 50.000.000 -> necessario 26 bits
    signal count : std_logic_vector(25 downto 0);
begin
    process(clock, aclr)
    begin
        if aclr = '1' then
            count <= (others => '0');
            cout  <= '0';
        elsif rising_edge(clock) then
            if count = 49999999 then
                count <= (others => '0');
                cout  <= '1';
            else
                count <= count + 1;
                cout  <= '0';
            end if;
        end if;
    end process;
end behavior;
