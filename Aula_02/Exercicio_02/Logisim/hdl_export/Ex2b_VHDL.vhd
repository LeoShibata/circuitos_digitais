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

ENTITY Ex2b_VHDL IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    A         : IN  std_logic;                    -- input bit example
    B         : IN  std_logic;                    -- input bit example
    C         : IN  std_logic;                    -- input bit example
  ------------------------------------------------------------------------------
  --Insert output ports below
    Y         : OUT std_logic                      -- output bit example
    );
END Ex2b_VHDL;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF Ex2b_VHDL IS

BEGIN

    Y <= (not (A and B)) and (B and C);

END TypeArchitecture;
