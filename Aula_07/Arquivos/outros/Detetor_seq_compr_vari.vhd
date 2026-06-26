library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Detetor_seq_compr_vari is
	port(
		rst, seq_in, clock	:	in std_logic;
		clk_in, clk_out		:	out std_logic;
		res_out, est_out	:	out std_logic_vector(6 downto 0)
	);
end Detetor_seq_compr_vari;

architecture detetor of Detetor_seq_compr_vari is
signal clk:	std_logic;
component divider is
port(
    clk_in					: in  std_logic;
    clk_out_1, clk_out_2	: out std_logic
);
end component;
component seq_compr_vari is
	generic(bits: natural := 6; seq_to_det: integer := 18);
	port(
		rst, seq_in, clock	:	in std_logic;
		res_out, est_out	:	out std_logic_vector(6 downto 0)
	);
end component;

begin
	clk_out <= clk;
	clk_in <= not clk;
	div : divider port map(clk_in => clock, clk_out_2 => clk);
	det: seq_compr_vari	generic map(	bits			=> 6,
									seq_to_det	=> 18)
						port map(		rst			=> rst,
									seq_in		=> seq_in,
									clock		=> clock,
									res_out		=> res_out,
									est_out		=> est_out);
end detetor;