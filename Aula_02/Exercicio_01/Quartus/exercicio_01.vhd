--------------------------------------------------------------------------------
-- Project :
-- File    :
-- Autor   :
-- Date    :
--
--------------------------------------------------------------------------------
-- Description :
--
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Exercicio_01 IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    X        : IN  std_logic;                    -- input bit example
    Y        : IN  std_logic;                    -- input vector example
  ------------------------------------------------------------------------------
  --Insert output ports below
    A1 	   : OUT std_logic;                    -- output bit example
    A2 	   : OUT std_logic;                    -- output bit example
    D1 	   : OUT std_logic;                    -- output bit example
    D2 	   : OUT std_logic                     -- output bit example
    );
END Exercicio_01;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF Exercicio_01 IS

BEGIN

    A1 <= not (X or Y);
    A2 <= (not X) and (not Y);
    D1 <= not (X and Y);
    D2 <= (not X) or (not Y);

END TypeArchitecture;
