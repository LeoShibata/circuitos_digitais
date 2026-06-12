library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity P1_cronometro_sincrono_vhdl is
	port(
		clk, z, ud, sst	:	in std_logic;                    
        qu_7s, qd_7s	: 	out std_logic_vector(6 downto 0);
        clk_in, clk_out	: 	out std_logic
	);
end P1_cronometro_sincrono_vhdl;

architecture cronometro_sincrono_arch of P1_cronometro_sincrono_vhdl is
	signal clock, clk_debounce, start_stop: std_logic;
	signal u, qu: std_logic_vector(3 downto 0);
	signal d, qd: std_logic_vector(2 downto 0);
	component divider is
		port(
			clk_in					:	in std_logic;	
			clk_out_1, clk_out_2	:	out std_logic
		);
	end component;
	component debounce_v1 is
		port(
			clk, button	:	in std_logic;  
			result		: 	out std_logic
		);
	end component;
begin
    div : divider port map(clk_in => clk, clk_out_1 => clk_debounce, clk_out_2 => clock);
    deb : debounce_v1 port map(clk => clk_debounce, button => sst, result => start_stop);
    proc: process(clock, z)
    begin
        if z = '0' then
            if ud = '0' then
                u <= "0000";
                d <= "000";
            else
                u <= "1001";
                d <= "101";
            end if;
        elsif start_stop = '1' then
            if clock = '1'  and clock' event then
                if ud = '0' then
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
                qu(0) <= u(0);
                qu(1) <= u(1);
                qu(2) <= u(2);
                qu(3) <= u(3);
                qd(0) <= d(0);
                qd(1) <= d(1);
                qd(2) <= d(2);
            end if;
        end if;
    end process proc;
    clk_out <= clock;
    clk_in <= not clock;
	with qu select
        qu_7s <=	"1111110" when "0000",
					"0110000" when "0001",
					"1101101" when "0010",
					"1111001" when "0011",
					"0110011" when "0100",
					"1011011" when "0101",
					"1011111" when "0110",
					"1110000" when "0111",
					"1111111" when "1000",
					"1110011" when "1001",
					"1110111" when "1010",
					"0011111" when "1011",
					"1001110" when "1100",
					"0111101" when "1101",
					"1111001" when "1110",
					"0111100" when "1111",
					"0000000" when others;
	with qd select
        qd_7s <= 	"1111110" when "000",
					"0110000" when "001",
					"1101101" when "010",
					"1111001" when "011",
					"0110011" when "100",
					"1011011" when "101",
					"1011111" when "110",
					"1110000" when "111",
					"0000000" when others;
end cronometro_sincrono_arch;