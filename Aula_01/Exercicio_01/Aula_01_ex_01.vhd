--------------------------------------------------------------------------------
-- Project : Aula_01_ex_01_2s21
-- File    :
-- Autor   : prof.Gortan
-- Date    : 19/09/21
--
--------------------------------------------------------------------------------
-- Description : Exerc�cio com portas para familiarizar o estudante com o
--               Logisim-evolution e com o Quartus
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Aula_01_ex_01 IS
  PORT (
  ------------------------------------------------------------------------------
  --Entradas:
    A       : IN  std_logic;   -- Entrada A
    B       : IN  std_logic;   -- Entrada B
  ------------------------------------------------------------------------------
  --Sa�das:
    AND_OUT  : OUT std_logic;   -- A and B
    OR_OUT   : OUT std_logic;   -- A OR B
    NAND_OUT : OUT std_logic;   -- A nand B
    NOR_OUT  : OUT std_logic;   -- A nor B
    XOR_OUT  : OUT std_logic;   -- A xor B
    XNOR_OUT : OUT std_logic;   -- A xnor B
    NOT_A    : OUT std_logic;   -- not A
    NOT_B    : OUT std_logic    -- not B
   );
END Aula_01_ex_01;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF Aula_01_ex_01 IS

BEGIN
	AND_OUT  <= A and B;
	OR_OUT   <= A or B;
	NAND_OUT <= A nand B;
	NOR_OUT  <= A nor B;
	XOR_OUT  <= A xor B;
	XNOR_OUT <= A xnor B;
	NOT_A    <= not A;
	NOT_B    <= not B;
END TypeArchitecture;
