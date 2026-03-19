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
  SIGNAL bin  : std_logic_vector(3 DOWNTO 0);
  SIGNAL gray : std_logic_vector(3 DOWNTO 0);
BEGIN

  -- Inverte as entradas (se a placa for active-low)
  bin <= NOT bin_i;

  -- Lógica do conversor Gray (Standard MSB = bit 3)
  gray(3) <= bin(3);
  gray(2) <= bin(3) XOR bin(2);
  gray(1) <= bin(2) XOR bin(1);
  gray(0) <= bin(1) XOR bin(0);

  -- Inverte as saídas (se os LEDs forem active-low)
  gray_o <= NOT gray;

END TypeArchitecture;
