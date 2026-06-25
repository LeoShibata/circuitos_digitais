library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity P2_sequencia_qualquer_vhdl is
	port (
		clk, start     :	in  std_logic;
		msd, lsd       :	out std_logic_vector(6 downto 0)                
    );
end P2_sequencia_qualquer_vhdl;

architecture sequencia_qualquer_arch of P2_sequencia_qualquer_vhdl is
	signal numero   :   std_logic_vector(6 downto 0);
	signal letra    :   std_logic_vector(6 downto 0) := "0000000";
	signal contador :   std_logic_vector(4 downto 0) := "00000";
begin
	ra: process(clk, start)
	begin
		if start = '1' then
			if clk = '1' and clk' event then
				if contador < "10001" then
					letra <= "1101111";
					case contador is
						when "00000" => numero <= "1101101"; letra <= "1100111"; -- 2
						when "00001" => numero <= "0110000"; letra <= "0000000"; -- 1
						when "00010" => numero <= "1111001"; letra <= "1100111"; -- 3 
						when "00011" => numero <= "1111110"; letra <= "0000000"; -- 0
						when "00100" => numero <= "1110000"; letra <= "1100111"; -- 7
						when "00101" => numero <= "1111110"; letra <= "0000000"; -- 0
						when "00110" => numero <= "1111110"; letra <= "1100111"; -- 0
						when "00111" => numero <= "0000001"; letra <= "0000000"; -- traço
						when "01000" => numero <= "1111110"; letra <= "1100111"; -- 0
						when "01001" => numero <= "1111110"; letra <= "0000000"; -- 0
						when "01010" => numero <= "1110000"; letra <= "1100111"; -- 7
						when "01011" => numero <= "1111110"; letra <= "0000000"; -- 0
						when "01100" => numero <= "1111001"; letra <= "1100111"; -- 3
						when "01101" => numero <= "0110000"; letra <= "0000000"; -- 1
						when "01110" => numero <= "1101101"; letra <= "1100111"; -- 2
						when "01111" => numero <= "0000001"; letra <= "0000000"; -- traço
						when others  => numero <= "0000001"; letra <= "0000000"; -- traço
					end case;
					contador <= contador + "00001";
				end if;
			end if;
		else
			numero <="0000001";
			letra <="0000000";
			contador <= "00000";
		end if;
		msd(0) <= numero(0);
		msd(1) <= numero(1);
		msd(2) <= numero(2);
		msd(3) <= numero(3);
		msd(4) <= numero(4);
		msd(5) <= numero(5);
		msd(6) <= numero(6);
		lsd(0) <= letra(0);
		lsd(1) <= letra(1);
		lsd(2) <= letra(2);
		lsd(3) <= letra(3);
		lsd(4) <= letra(4);
		lsd(5) <= letra(5);
		lsd(6) <= letra(6);	
	end process ra;
end sequencia_qualquer_arch;