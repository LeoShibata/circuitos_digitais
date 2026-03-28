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

ENTITY Supervisao_cinto IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    motorista_presente      : IN  std_logic;        -- sensor motorista
    cinto_em_uso            : IN  std_logic;        -- sensor cinto
    ignicao_ligada          : IN  std_logic;        -- sensor ignição
  ------------------------------------------------------------------------------
  --Insert output ports below
    alarme                  : OUT std_logic         -- saída luz de advertência
    );
END Supervisao_cinto;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF Supervisao_cinto IS

BEGIN

    alarme <= motorista_presente and (not cinto_em_uso) and ignicao_ligada;

END TypeArchitecture;
