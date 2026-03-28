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

ENTITY Ex2a_VHDL IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    A        : IN  std_logic;                    -- input bit example
    B        : IN  std_logic;                    -- input vector example
    C        : IN  std_logic;                    -- input vector example
    D        : IN  std_logic;                    -- input vector example
  ------------------------------------------------------------------------------
  --Insert output ports below
    X        : OUT std_logic                    -- output bit example
    );
END Ex2a_VHDL;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF Ex2a_VHDL IS

BEGIN

    X <= (A nor B) and (C and D);
   
END TypeArchitecture;
