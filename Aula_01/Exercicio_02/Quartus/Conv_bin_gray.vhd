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
	signal bin_s  : std_logic_vector(3 DOWNTO 0);
	signal gray_s : std_logic_vector(3 DOWNTO 0);
BEGIN

	bin_s <= NOT bin_i;

	gray_s(3) <= bin_s(3);
	gray_s(2) <= bin_s(3) XOR bin_s(2);
	gray_s(1) <= bin_s(2) XOR bin_s(1);
	gray_s(0) <= bin_s(1) XOR bin_s(0);
	
	gray_o <= gray_s;

END TypeArchitecture;
