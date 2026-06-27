LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY seq_110010 IS
	PORT (
		clk_automatico, seq_in							: IN STD_LOGIC;
		reset								: IN STD_LOGIC;

		clk_normal, clk_invertido 			: OUT STD_LOGIC;	
		resultado_segmento, estado_segmento	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)	
	);
END seq_110010;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF seq_110010 IS

SIGNAL clk: STD_LOGIC;

component divider is
port(
    clk_in		: in  std_logic;	-- clock in.
    clk_out_1	: out std_logic;	-- clock in dividido 2 x divisor_1
    clk_out_2	: out std_logic		-- clock in dividido por 2 x divisor_1 x divisor_2
);
end component;
component seq_compr_variavel is					-- dff referenciado como dff_vhdl
	GENERIC(bits: natural := 6; seq_to_det: integer := 18);
	PORT (
		clk, seq_in		:	 IN STD_LOGIC;
		reset				: 	 IN STD_LOGIC;

		resultado_segmento, estado_segmento		: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)	
	);
end component;

BEGIN

	clk_normal <= clk;
	clk_invertido <= NOT clk;

	di : divider port map(clk_in => clk_automatico, clk_out_2 => clk);

	start_seq: seq_compr_variavel generic map(
		bits => 6,
		seq_to_det => 18
	)
	port map(
		clk 				=> clk,
		seq_in 				=> seq_in,
		reset				=> reset,
		resultado_segmento 	=> resultado_segmento,
		estado_segmento 	=> estado_segmento
	);

END TypeArchitecture;
