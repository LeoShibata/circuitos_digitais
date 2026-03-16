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

ENTITY Conv_bin_gray IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    bin_i        : IN  std_logic_vector(3 DOWNTO 0); -- input vector example
  ------------------------------------------------------------------------------
  --Insert output ports below
    gray_o        : OUT std_logic_vector(3 DOWNTO 0)  -- output vector example
    );
END Conv_bin_gray;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF Conv_bin_gray IS

BEGIN

gray_o(3) <= bin_i(3);
gray_o(2) <= bin_i(3) XOR bin_i(2);
gray_o(1) <= bin_i(2) XOR bin_i(1);
gray_o(0) <= bin_i(1) XOR bin_i(0);

END TypeArchitecture;
