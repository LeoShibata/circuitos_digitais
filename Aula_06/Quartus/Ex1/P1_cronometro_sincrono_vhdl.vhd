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
    
    -- Inicializando os sinais para ligar a placa pausada e em 00 (Ascendente)
    signal flag_run     : std_logic := '0'; 
    signal sst_anterior : std_logic := '1'; 
    signal ud_anterior  : std_logic := '1'; -- Memória do estado anterior do botão UD
    signal u            : std_logic_vector(3 downto 0) := "0000"; 
    signal d_4bits      : std_logic_vector(3 downto 0) := "0000"; 
    signal dir_atual    : std_logic := '0'; -- 0 = Ascendente, 1 = Descendente
    
    signal clock, clk_debounce, start_stop : std_logic;

begin

    -- 1. Instanciando os Componentes
    div : divider 
        port map(clk_in => clk, clk_out_1 => clk_debounce, clk_out_2 => clock);
        
    deb : debounce_v1 
        port map(clk => clk_debounce, button => sst, result => start_stop);
        
    decod_unidade : bin_to_7seg 
        port map(bin => u, seg => qu_7s);
        
    decod_dezena : bin_to_7seg 
        port map(bin => d_4bits, seg => qd_7s);

    -- Processo para os Botões (Start/Stop e Mudança de Direção)
    proc_toggle: process(clk_debounce)
    begin
        if rising_edge(clk_debounce) then
            
            -- 1. Regra do Start/Stop (Inverte a flag de contagem)
            if start_stop = '0' and sst_anterior = '1' then
                flag_run <= not flag_run;
            end if;
            sst_anterior <= start_stop; 

            -- 2. Regra da Mudança de Sentido (Só funciona se Z estiver acionado)
            if z = '0' then
                -- Detecta o clique no botão UD (Borda de descida)
                if ud = '0' and ud_anterior = '1' then
                    dir_atual <= not dir_atual; -- Inverte o sentido
                end if;
            end if;
            ud_anterior <= ud;
            
        end if;
    end process proc_toggle;
     
    -- 2. Lógica Principal do Cronômetro
    proc: process(clock, z)
    begin
        -- Z pressionado: Congela o contador e reseta os mostradores baseados na direção
        if z = '0' then 
            
            -- Olha para a memória (dir_atual) e reseta de acordo
            if dir_atual = '0' then
                u <= "0000";
                d_4bits <= "0000";
            else
                u <= "1001";       -- 9
                d_4bits <= "0101"; -- 5
            end if;
            
        -- Quando Z é solto, retoma a contagem    
        elsif rising_edge(clock) then
            if flag_run = '1' then
                
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