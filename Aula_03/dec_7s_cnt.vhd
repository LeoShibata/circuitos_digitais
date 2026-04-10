library ieee;
use ieee.std_logic_1164.all;

-- Exercicio 2 - Decodificador 7 segmentos com contador
-- Pratica 3 - Circuitos Digitais
-- RA: 2719851 (impar)
-- Entradas: clk (CH1/PIN_50), clr (CH2/PIN_52)
-- Saida:    c_7s(6 downto 0) = a b c d e f g
-- Display catodo comum (ativo em nivel alto)
-- O contador avanca uma posicao a cada pulso de clk.
-- Pressionar clr (tecla) reseta o contador (aclr ativo alto: not clr).
-- 0xE: mostra '1' (ultimo digito RA 2719851)
-- 0xF: mostra 'J' (RA impar)

entity dec_7s_cnt is
    port(
        clk  : in  std_logic;
        clr  : in  std_logic;
        c_7s : out std_logic_vector(6 downto 0)
    );
end dec_7s_cnt;

architecture decode of dec_7s_cnt is

    signal cnt_i : std_logic_vector(3 downto 0);

    component cnt_1s is
        port(
            clock : in  std_logic;
            aclr  : in  std_logic;
            q     : out std_logic_vector(3 downto 0)
        );
    end component;

begin
    -- aclr ativo alto: pressionar tecla (clr=0) -> not clr=1 -> reset
    cnt: cnt_1s port map(clock => clk, aclr => not clr, q => cnt_i);

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
