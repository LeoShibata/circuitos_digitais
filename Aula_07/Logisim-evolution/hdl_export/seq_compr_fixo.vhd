library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seq_compr_fixo is
	generic(iseq: integer := 18);
	port(
		rst, seq_in, clock	:	in	std_logic;
		res_out, est_out	:	out	std_logic_vector(3 downto 0)
	);
end seq_compr_fixo;

architecture detetor of seq_compr_fixo is

type estado is (A, B, C, D, E, F, G);
	constant seq: std_logic_vector(5 downto 0):= "010010";
	signal estado_prs, prx_estado: estado;
	attribute enum_encoding: string;
	attribute enum_encoding of estado: type is "sequential"; 

begin
	seq_proc: process(clock, rst)
	begin
		if rst = '1' then estado_prs <= A;
		elsif clock = '1' and clock'event then
			estado_prs <= prx_estado;
		end if;
	end process seq_proc;
	comb_proc: process(estado_prs, seq_in)
	variable idx: integer;
	begin
		case estado_prs is
			when A =>
				if seq_in = seq(5) then 	prx_estado <= B;
				else					prx_estado <= A;
				end if;
			when B =>
				if seq_in = seq(4) then 	prx_estado <= C;
				else					prx_estado <= A;
				end if;
			when C =>
				if seq_in = seq(3) then 	prx_estado <= D;
				else					prx_estado <= A;
				end if;
			when D =>
				if seq_in = seq(2) then 	prx_estado <= E;
				else					prx_estado <= A;
				end if;
			when E =>
				if seq_in = seq(1) then 	prx_estado <= F;
				else					prx_estado <= A;
				end if;
			when F =>
				if seq_in = seq(0) then 	prx_estado <= G;
				else					prx_estado <= A;
				end if;
			when G =>					prx_estado <= G;
		end case;
		idx := estado'pos(estado_prs);
		est_out <= std_logic_vector(to_unsigned(idx, est_out'length));
		case estado_prs is
			when G		=> res_out <= X"1";
			when others	=> res_out <= X"0";
		end case;
	end process comb_proc;
end detetor;