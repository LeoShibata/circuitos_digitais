LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY seq_compr_variavel IS

	GENERIC(bits: natural := 5; seq_to_det: integer := 18);
	PORT (
		clk, seq_in									: IN STD_LOGIC;
		reset										: IN STD_LOGIC;

		resultado_segmento, estado_segmento		: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)	
	);
END seq_compr_variavel;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF seq_compr_variavel IS

SIGNAL saida: STD_LOGIC_VECTOR(6 DOWNTO 0);

CONSTANT seq: STD_LOGIC_VECTOR(bits - 1 DOWNTO 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(seq_to_det, bits));

TYPE estado IS (A, B, C, D, E, F, G);

SIGNAL stat_prs, prx_stat: integer RANGE 0 TO bits;

BEGIN

	somente_clock_reset: PROCESS(clk, reset)
	BEGIN

		IF reset = '0' THEN
			stat_prs <= 0;
		ELSIF clk = '1' AND clk' EVENT THEN
			stat_prs <= prx_stat;
		END IF;
	END PROCESS somente_clock_reset;

	verificar_sequencia: PROCESS(stat_prs, seq_in)

	VARIABLE index_seq: integer;
	BEGIN

		index_seq := bits - 1 - stat_prs;

		IF stat_prs /= bits THEN
			IF seq_in = seq(index_seq) THEN
				prx_stat <= stat_prs + 1;
			ELSE
				prx_stat <= 0;
			END IF;
		ELSE
			prx_stat <= bits;
		END IF;

		saida <= STD_LOGIC_VECTOR(TO_UNSIGNED(stat_prs, estado_segmento'length));

		IF prx_stat = bits THEN
			resultado_segmento <= "0110000";
		ELSE 
			resultado_segmento <= "1111110";
		END IF;

	END PROCESS verificar_sequencia;


	WITH saida SELECT
		estado_segmento <= "1111110" WHEN STD_LOGIC_VECTOR(TO_UNSIGNED(0, estado_segmento'length)),
            "0110000" WHEN STD_LOGIC_VECTOR(TO_UNSIGNED(1, estado_segmento'length)),
            "1101101" WHEN STD_LOGIC_VECTOR(TO_UNSIGNED(2, estado_segmento'length)),
            "1111001" WHEN STD_LOGIC_VECTOR(TO_UNSIGNED(3, estado_segmento'length)),
            "0110011" WHEN STD_LOGIC_VECTOR(TO_UNSIGNED(4, estado_segmento'length)),
            "1011011" WHEN STD_LOGIC_VECTOR(TO_UNSIGNED(5, estado_segmento'length)),
            "1011111" WHEN STD_LOGIC_VECTOR(TO_UNSIGNED(6, estado_segmento'length)),
            "1110000" WHEN STD_LOGIC_VECTOR(TO_UNSIGNED(7, estado_segmento'length)),
            "1111111" WHEN STD_LOGIC_VECTOR(TO_UNSIGNED(8, estado_segmento'length)),
            "1110011" WHEN STD_LOGIC_VECTOR(TO_UNSIGNED(9, estado_segmento'length)),
            "1110111" WHEN STD_LOGIC_VECTOR(TO_UNSIGNED(10, estado_segmento'length)),
            "0011111" WHEN STD_LOGIC_VECTOR(TO_UNSIGNED(11, estado_segmento'length)),
            "1001110" WHEN STD_LOGIC_VECTOR(TO_UNSIGNED(12, estado_segmento'length)),
            "0111101" WHEN STD_LOGIC_VECTOR(TO_UNSIGNED(13, estado_segmento'length)),
            "1111001" WHEN STD_LOGIC_VECTOR(TO_UNSIGNED(14, estado_segmento'length)),
            "0111100" WHEN STD_LOGIC_VECTOR(TO_UNSIGNED(15, estado_segmento'length)),
            "0000000" WHEN OTHERS;

END TypeArchitecture;