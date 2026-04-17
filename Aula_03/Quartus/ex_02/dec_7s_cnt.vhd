library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Exercicio 2 - Decodificador 7 segmentos com contador manual (botao)
-- Pratica 3 - Circuitos Digitais
-- RA: 2719851 (impar)
-- Entradas: clk_50MHz (cristal EPM240 / PIN_12) - usado para debounce
--           clk       (tecla CH1 / PIN_50 - avanca o contador)
--           clr       (tecla CH2 / PIN_52 - reset manual)
-- Saida:    c_7s(6 downto 0) = a b c d e f g
-- Display catodo comum (ativo em nivel alto)
-- Cada pressao do botao clk avanca o contador em 1 posicao (0 a F).
-- 0xE: mostra '1' (ultimo digito RA 2719851)
-- 0xF: mostra 'J' (RA impar)

entity dec_7s_cnt is
    port(
        clk_50MHz : in  std_logic;
        clk       : in  std_logic;
        clr       : in  std_logic;
        c_7s      : out std_logic_vector(6 downto 0)
    );
end dec_7s_cnt;

architecture decode of dec_7s_cnt is

    signal cnt_i    : std_logic_vector(3 downto 0) := "0000";

    -- Debounce: aguarda 10 ms estaveis antes de aceitar a borda (~500000 ciclos a 50 MHz)
    signal db_cnt   : integer range 0 to 500000 := 0;
    signal btn_sync : std_logic_vector(1 downto 0) := "11";
    signal btn_stbl : std_logic := '1';
    signal btn_prev : std_logic := '1';

begin

    process(clk_50MHz, clr)
    begin
        if clr = '0' then
            cnt_i    <= "0000";
            db_cnt   <= 0;
            btn_sync <= "11";
            btn_stbl <= '1';
            btn_prev <= '1';
        elsif rising_edge(clk_50MHz) then

            -- Sincronizador de 2 estagios (evita metaestabilidade)
            btn_sync <= btn_sync(0) & clk;

            -- Debounce: reinicia contagem se o sinal ainda esta mudando
            if btn_sync(1) /= btn_stbl then
                if db_cnt = 500000 then
                    db_cnt   <= 0;
                    btn_stbl <= btn_sync(1);
                else
                    db_cnt <= db_cnt + 1;
                end if;
            else
                db_cnt <= 0;
            end if;

            -- Detecta borda de descida (botao ativo baixo: 1->0 = pressionar)
            if btn_prev = '1' and btn_stbl = '0' then
                cnt_i <= cnt_i + 1;
            end if;
            btn_prev <= btn_stbl;

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
