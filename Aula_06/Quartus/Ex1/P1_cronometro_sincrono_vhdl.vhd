library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.pacote_cronometro.all; 

entity P1_cronometro_sincrono_vhdl is
    port(
        clk, z, ud, sst : in  std_logic;                     
        qu_7s, qd_7s    : out std_logic_vector(6 downto 0);
        clk_in, clk_out : out std_logic
    );
end P1_cronometro_sincrono_vhdl;

architecture cronometro_sincrono_arch of P1_cronometro_sincrono_vhdl is
    
	 signal flag_run     : std_logic := '0'; -- O cronômetro começa pausado (0)
    signal sst_anterior : std_logic := '1'; -- Memória do estado anterior do botão (começa solto '1')
    signal clock, clk_debounce, start_stop : std_logic;
    signal u          : std_logic_vector(3 downto 0);
    signal d_4bits    : std_logic_vector(3 downto 0); -- Expandido para 4 bits para caber no componente
    signal dir_atual  : std_logic; -- Registrador para segurar o valor de 'ud'

begin

    -- 1. Instanciando os Componentes do Package
    div : divider 
        port map(clk_in => clk, clk_out_1 => clk_debounce, clk_out_2 => clock);
        
    deb : debounce_v1 
        port map(clk => clk_debounce, button => sst, result => start_stop);
        
    decod_unidade : bin_to_7seg 
        port map(bin => u, seg => qu_7s);
        
    decod_dezena : bin_to_7seg 
        port map(bin => d_4bits, seg => qd_7s);

    -- Processo para criar o efeito Liga/Desliga (Toggle) no botão sst
    -- Processo para criar o efeito Liga/Desliga (Toggle) no botão sst
    proc_toggle: process(clk_debounce, z)
    begin
        -- O botão Z funciona como Reset Assíncrono também para a Flag
        -- Isso garante que a placa inicie pausada e que o Z "suspenda a contagem"
        if z = '0' then
            flag_run <= '0';
            sst_anterior <= '1';
            
        elsif rising_edge(clk_debounce) then
            -- Detecta a Borda de Descida: botão estava solto (1) e foi apertado (0)
            if start_stop = '0' and sst_anterior = '1' then
                flag_run <= not flag_run; -- Inverte o estado (Pausa vira Roda, Roda vira Pausa)
            end if;
            
            -- Atualiza a memória para o próximo ciclo
            sst_anterior <= start_stop; 
        end if;
    end process proc_toggle;
	 
    -- 2. Lógica Principal do Cronômetro
    proc: process(clock, z)
    begin
        -- Z é ativo em nível baixo (0) devido ao pull-up do kit
        if z = '0' then 
            dir_atual <= ud; -- SÓ ATUALIZA A DIREÇÃO AQUI (O "Detalhe" do roteiro)
            
            if ud = '0' then
                u <= "0000";
                d_4bits <= "0000";
            else
                u <= "1001";       -- Começa em 9
                d_4bits <= "0101"; -- Começa em 5
            end if;
            
        -- Processamento na Borda de Subida do relógio de 1s
        elsif rising_edge(clock) then
            if flag_run = '1' then
                
                -- Usa o 'dir_atual' que foi travado no reset
                if dir_atual = '0' then -- Contagem Ascendente
                    if u < "1001" then
                        u <= u + "0001";
                    else
                        u <= "0000";
                        if d_4bits < "0101" then
                            d_4bits <= d_4bits + "0001";
                        else 
                            d_4bits <= "0000";
                        end if;
                    end if;
                    
                else -- Contagem Descendente
                    if u > "0000" then
                        u <= u - "0001";
                    else
                        u <= "1001";
                        if d_4bits > "0000" then
                            d_4bits <= d_4bits - "0001";
                        else 
                            d_4bits <= "0101";
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process proc;

    -- Pinos de monitoramento
    clk_out <= clock;
    clk_in  <= not clock;

end cronometro_sincrono_arch;