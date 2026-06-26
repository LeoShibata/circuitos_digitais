library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seq_compr_vari is
	generic(
		  bits: natural := 5; 
		  seq_to_det: integer := 18
	);
	port(
		rst, seq_in, clock	:	in	std_logic;
		res_out, est_out	:	out std_logic_vector(6 downto 0)
	);
end seq_compr_vari;

architecture detetor of seq_compr_vari is
	signal saida: std_logic_vector(6 downto 0);
	constant seq: std_logic_vector(bits-1 downto 0) := std_logic_vector(to_unsigned(seq_to_det, bits));
	signal stat_prs, prx_stat: integer range 0 to bits;
begin
	seq_proc: process(clock, rst)
	begin
		if rst = '0' then stat_prs <= 0;
		elsif clock = '1' and clock 'event then
			stat_prs <= prx_stat;
		end if;
	end process seq_proc;
	comb_proc: process(stat_prs, seq_in)
	variable idx_seq: integer;
	begin
		idx_seq := bits - 1 - stat_prs;
		if stat_prs /= bits then
			if seq_in = seq(idx_seq) then
				prx_stat <= stat_prs + 1;
			else
				prx_stat <= 0;
			end if;
		else
			prx_stat <= bits;
		end if;
		saida <= std_logic_vector(to_unsigned(stat_prs, est_out'length));
		if prx_stat = bits then
			res_out <= "0110000";
		else
			res_out <= "1111110";
		end if;
	end process comb_proc;
	with saida select
		est_out <= 	"1111110" when std_logic_vector(to_unsigned(0, est_out'length)),
					"0110000" when std_logic_vector(to_unsigned(1, est_out'length)),
					"1101101" when std_logic_vector(to_unsigned(2, est_out'length)),
					"1111001" when std_logic_vector(to_unsigned(3, est_out'length)),
					"0110011" when std_logic_vector(to_unsigned(4, est_out'length)),
					"1011011" when std_logic_vector(to_unsigned(5, est_out'length)),
					"1011111" when std_logic_vector(to_unsigned(6, est_out'length)),
					"1110000" when std_logic_vector(to_unsigned(7, est_out'length)),
					"1111111" when std_logic_vector(to_unsigned(8, est_out'length)),
					"1110011" when std_logic_vector(to_unsigned(9, est_out'length)),
					"1110111" when std_logic_vector(to_unsigned(10, est_out'length)),
					"0011111" when std_logic_vector(to_unsigned(11, est_out'length)),
					"1001110" when std_logic_vector(to_unsigned(12, est_out'length)),
					"0111101" when std_logic_vector(to_unsigned(13, est_out'length)),
					"1111001" when std_logic_vector(to_unsigned(14, est_out'length)),
					"0111100" when std_logic_vector(to_unsigned(15, est_out'length)),
					"0000000" when others;
end detetor; 