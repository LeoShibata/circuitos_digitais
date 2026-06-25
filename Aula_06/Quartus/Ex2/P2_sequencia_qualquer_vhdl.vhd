library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity P2_sequencia_qualquer_vhdl is
    port (
        clk, start      : in  std_logic;
        msd, lsd        : out std_logic_vector(6 downto 0); -- Trocado para OUT
        clk_in, clk_out : out std_logic
    );
end P2_sequencia_qualquer_vhdl;

architecture sequencia_qualquer_arch of P2_sequencia_qualquer_vhdl is
    
    -- Sinais internos
    signal clock, clk_debounce, start_stop : std_logic;
    signal numero            : std_logic_vector(6 downto 0);
    signal letra             : std_logic_vector(6 downto 0);
    signal contador          : std_logic_vector(4 downto 0) := "00000";
    
    -- Sinais de controle para o botão físico
    signal rodando           : std_logic := '0';
    signal start_anterior    : std_logic := '1';
    signal contador_terminou : std_logic := '0';

    -- Declaração dos Componentes
    component divider is
        port(
            clk_in               : in  std_logic;    
            clk_out_1, clk_out_2 : out std_logic
        );
    end component;
    
    component debounce_v1 is
        port(
            clk, button : in  std_logic;  
            result      : out std_logic
        );
    end component;

begin
    -- Instanciação dos componentes
    div : divider port map(clk_in => clk, clk_out_1 => clk_debounce, clk_out_2 => clock);
    deb : debounce_v1 port map(clk => clk_debounce, button => start, result => start_stop);

    -- 1. Processo para capturar o clique do botão (Relógio rápido)
    proc_botao: process(clk_debounce)
    begin
        if rising_edge(clk_debounce) then
            -- Se a sequência terminou, desliga a máquina
            if contador_terminou = '1' then
                rodando <= '0'; 
                
            -- Se detectar a borda de descida (botão pressionado), liga a máquina
            elsif start_stop = '0' and start_anterior = '1' then
                rodando <= '1'; 
            end if;
            
            start_anterior <= start_stop;
        end if;
    end process proc_botao;

    -- 2. Processo da Sequência (Relógio de 1 segundo)
    proc_seq: process(clock)
    begin
        if rising_edge(clock) then
            if rodando = '1' then
                
                -- Executa os 16 estados da sequência
                if contador < "10000" then 
                    contador_terminou <= '0';
                    
                    case contador is
                        -- Sequência DIRETA: 2719851 (Ímpar -> Letra J)
                        when "00000" => numero <= "1101101"; letra <= "0111100"; -- J2
                        when "00001" => numero <= "1110000"; letra <= "0000000"; --  7
                        when "00010" => numero <= "0110000"; letra <= "0111100"; -- J1
                        when "00011" => numero <= "1110011"; letra <= "0000000"; --  9
                        when "00100" => numero <= "1111111"; letra <= "0111100"; -- J8
                        when "00101" => numero <= "1011011"; letra <= "0000000"; --  5
                        when "00110" => numero <= "0110000"; letra <= "0111100"; -- J1
                        when "00111" => numero <= "0000001"; letra <= "0000000"; --  -

                        -- Sequência INVERTIDA: 1589172
                        when "01000" => numero <= "0110000"; letra <= "0111100"; -- J1
                        when "01001" => numero <= "1011011"; letra <= "0000000"; --  5
                        when "01010" => numero <= "1111111"; letra <= "0111100"; -- J8
                        when "01011" => numero <= "1110011"; letra <= "0000000"; --  9
                        when "01100" => numero <= "0110000"; letra <= "0111100"; -- J1
                        when "01101" => numero <= "1110000"; letra <= "0000000"; --  7
                        when "01110" => numero <= "1101101"; letra <= "0111100"; -- J2
                        when "01111" => numero <= "0000001"; letra <= "0000000"; --  -

                        when others  => numero <= "0000001"; letra <= "0000000";
                    end case;
                    
                    contador <= contador + "00001";
                else
                    -- Avisa o relógio rápido que terminou e zera o contador
                    contador_terminou <= '1'; 
                    contador <= "00000";
                end if;
            else
                contador_terminou <= '0';
                contador <= "00000";
            end if;
        end if;
    end process proc_seq;

    -- 3. Atribuição correta aos displays (Garante o repouso)
    -- MSD recebe a letra, LSD recebe o numero
    msd <= letra  when rodando = '1' else "0000000";
    lsd <= numero when rodando = '1' else "0000001";

    -- Pinos de teste do clock
    clk_out <= clock;
    clk_in  <= not clock;

end sequencia_qualquer_arch;