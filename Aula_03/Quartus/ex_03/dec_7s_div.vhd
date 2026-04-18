library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Exercicio 3 - Decodificador 7 segmentos com contador e divisor de frequencia
-- Pratica 3 - Circuitos Digitais
-- RA: 2719851 (impar)
-- Entradas: clk_50MHz (cristal EPM240 / PIN_12)
--           clr       (tecla CH1 / PIN_50 - reset manual)
-- Saida:    c_7s(6 downto 0) = a b c d e f g
-- Display catodo comum (ativo em nivel alto)
-- O divisor divide 50 MHz por 50.000.000 -> 1 Hz
-- O contador avanca uma posicao a cada 1 segundo automaticamente.
-- Pressionar clr reseta ambos os contadores.
-- 0xE: mostra '1' (ultimo digito RA 2719851)
-- 0xF: mostra 'J' (RA impar)

entity dec_7s_div is
    port(
        clk_50MHz : in  std_logic;
        clr       : in  std_logic;
        c_7s      : out std_logic_vector(6 downto 0)
    );
end dec_7s_div;

architecture decode of dec_7s_div is

    signal cnt_i   : std_logic_vector(3 downto 0);
    signal clk_1Hz : std_logic;

    component cnt_50M is
        port(
            clock : in  std_logic;
            aclr  : in  std_logic;
            cout  : out std_logic
        );
    end component;

begin
    -- Divisor de frequencia: 50 MHz -> 1 Hz (carry-out a cada 50.000.000 pulsos)
    -- aclr ativo alto: pressionar tecla (clr=0) -> not clr=1 -> reset
    div: cnt_50M port map(clock => clk_50MHz, aclr => not clr, cout => clk_1Hz);

    -- Contador de 4 bits com clock enable: usa clk_50MHz como clock real
    -- e clk_1Hz como habilitacao, evitando glitches ao usar cout como clock
    process(clk_50MHz, clr)
    begin
        if clr = '0' then
            cnt_i <= "0000";
        elsif rising_edge(clk_50MHz) then
            if clk_1Hz = '1' then
                cnt_i <= cnt_i + 1;
            end if;
        end if;
    end process;

    --              abcdefg          klmn
    with cnt_i select
        c_7s <= "1111110" when "0000",  -- 0  -> 7E h
                "0110000" when "0001",  -- 1  -> 30 h
                "1101101" when "0010",  -- 2  -> 6D h
                "1111001" when "0011",  -- 3  -> 79 h
                "0110011" when "0100",  -- 4  -> 33 h
                "1011011" when "0101",  -- 5  -> 5B h
                "1011111" when "0110",  -- 6  -> 5F h
                "1110000" when "0111",  -- 7  -> 70 h
                "1111111" when "1000",  -- 8  -> 7F h
                "1111011" when "1001",  -- 9  -> 7B h
                "1110111" when "1010",  -- A  -> 77 h
                "0011111" when "1011",  -- b  -> 1F h
                "1001110" when "1100",  -- C  -> 4E h
                "0111101" when "1101",  -- d  -> 3D h
                "0110000" when "1110",  -- E  -> mostra '1' (ultimo digito RA 2719851)
                "0111100" when "1111",  -- F  -> mostra 'J' (RA impar)
                "0000000" when others;
end decode;
