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

ENTITY Ex2c_VHDL IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    A        : IN  std_logic;                    -- input bit example
    B        : IN  std_logic;                    -- input bit example
    C        : IN  std_logic;                    -- input bit example
    D        : IN  std_logic;                    -- input bit example
  ------------------------------------------------------------------------------
  --Insert output ports below
    Z        : OUT std_logic                    -- output bit example
    );
END Ex2c_VHDL;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF Ex2c_VHDL IS

    signal u : std_logic; 
    signal v : std_logic; 
    signal t : std_logic;

BEGIN

    u <= (not A) and (not B) and (not C);
    v <= A and (not B) and (not C);
    t <= (not A) and (not B) and D;
    Z <= u or v or t;
    
END TypeArchitecture;
