library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity P1_cronometro_sincrono_vhdl is
    port (
        clk      : in  std_logic; -- Período de 1s
        z        : in  std_logic; -- Reseta o contador e suspende a contagem 
        ud       : in  std_logic; -- low (0) -> ascendente, high (1) -> descendente.
        sst      : in  std_logic; -- Ativa / Para a Contagem
        qu_7s    : out std_logic_vector(6 downto 0);
        qd_7s    : out std_logic_vector(6 downto 0)
    );
end P1_cronometro_sincrono_vhdl;

architecture cronometro_sincrono_arch of P1_cronometro_sincrono_vhdl is
    signal u         : std_logic_vector(3 downto 0);
    signal d         : std_logic_vector(2 downto 0);
    signal dir_atual : std_logic; -- Registrador para armazenar a direção
begin
    proc: process(clk, z)
    begin
        -- Reset Assíncrono e Atualização de Direção
        if z = '1' then
            dir_atual <= ud; -- Atualiza a direção APENAS quando Z é acionado
            
            if ud = '0' then 
                -- Se for ascendente, reseta para 00
                u <= "0000";
                d <= "000";
            else             
                -- Se for descendente, reseta para 59
                u <= "1001";
                d <= "101";
            end if;
            
        -- Processamento Síncrono
        elsif rising_edge(clk) then
            if sst = '1' then -- Só conta se Start/Stop estiver ativo
                
                -- Usa o sinal 'dir_atual' travado, ignorando mudanças em 'ud' enquanto z='0'
                -- Ascendente
                if dir_atual = '0' then
                    if u < "1001" then
                        u <= u + "0001";
                    else
                        u <= "0000";
                        if d < "101" then
                            d <= d + "001";
                        else 
                            d <= "000";
                        end if;
                    end if;
                    
                -- Descendente    
                else 
                    if u > "0000" then
                        u <= u - "0001";
                    else
                        u <= "1001";
                        if d > "000" then
                            d <= d - "001";
                        else 
                            d <= "101";
                        end if;
                    end if;
                end if;
                
            end if;
        end if;
    end process proc;

    -- Display Unidades (Acionado pelo sinal 'u')
    with u select
        qu_7s <= "1111110" when "0000", -- 0
                 "0110000" when "0001", -- 1
                 "1101101" when "0010", -- 2
                 "1111001" when "0011", -- 3
                 "0110011" when "0100", -- 4
                 "1011011" when "0101", -- 5
                 "1011111" when "0110", -- 6
                 "1110000" when "0111", -- 7
                 "1111111" when "1000", -- 8
                 "1110011" when "1001", -- 9
                 "0000000" when others;

    -- Display Dezenas (Acionado pelo sinal 'd')
    with d select
        qd_7s <= "1111110" when "000", -- 0
                 "0110000" when "001", -- 1
                 "1101101" when "010", -- 2
                 "1111001" when "011", -- 3
                 "0110011" when "100", -- 4
                 "1011011" when "101", -- 5
                 "0000000" when others;

end cronometro_sincrono_arch;