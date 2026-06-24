library ieee;
use ieee.std_logic_1164.all;

package pacote_cronometro is

    -- Declaração do Divisor de Clock
    component divider is
        port(
            clk_in               : in  std_logic;    
            clk_out_1, clk_out_2 : out std_logic
        );
    end component;

    -- Declaração do Anti-repique (Debounce)
    component debounce_v1 is
        port(
            clk, button : in  std_logic;  
            result      : out std_logic
        );
    end component;

    -- Declaração do Decodificador 7 Segmentos
    component bin_to_7seg is
        port(
            bin : in  std_logic_vector(3 downto 0);
            seg : out std_logic_vector(6 downto 0)
        );
    end component;

end package pacote_cronometro;