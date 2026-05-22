--------------------------------------------------------------------------------
-- UTFPR - Universidade Tecnol�gica Federal do Paraná - Curitiba - PR
-- Projeto : Divisor de frequência em cadeia
-- Arquivo : chain_divider.vhd
-- Autor   : prof. Gortan
-- Data    : Abril 2020
--
--------------------------------------------------------------------------------
-- Descrição :
-- divisor de frequência genérico com divisão em cadeia
-- no exemplo (configuráve via generic) temos:
-- período de clk_out_1 = 10 x período de clk_in
-- período de clk_out_2 = 3 x período de clk_out_1 = 30 x período de clk_in
-- clk_out_1 e clk_out_2 estão sincronizados com clk_in
--------------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;

entity divider is
  generic(divisor_1: integer := 250000;
		  divisor_2: integer := 100);
  port(
    clk_in		: in  std_logic;	-- clock in.
    clk_out_1	: out std_logic;	-- clock in dividido 2 x divisor_1
	clk_out_2	: out std_logic		-- clock in dividido por 2 x divisor_1 x divisor_2
    );
end divider;
--------------------------------------------------------------------------------
architecture divisor of divider is
signal temp_1, temp_2: std_logic :='0';
begin

	P_div:process (clk_in)                                              
	variable count_1:integer range 0 to divisor_1;
	variable count_2:integer range 0 to divisor_2;
	begin                                                                
		if clk_in'event and clk_in = '1' then
			count_1 := count_1 + 1;
			if (count_1 = divisor_1) then
				temp_1 <= not temp_1;
				count_1 := 0;
				count_2 := count_2 + 1;
				if(count_2 = divisor_2) then
					count_2 := 0;
					temp_2 <= not temp_2;
				end if;
			end if;
		 end if; 
	end process P_div;
	clk_out_1 <= temp_1;
	clk_out_2 <= temp_2;

end divisor;
