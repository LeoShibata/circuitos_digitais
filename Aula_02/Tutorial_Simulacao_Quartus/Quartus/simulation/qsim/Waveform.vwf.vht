-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "03/28/2026 16:42:26"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          Supervisao_cinto
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY Supervisao_cinto_vhd_vec_tst IS
END Supervisao_cinto_vhd_vec_tst;
ARCHITECTURE Supervisao_cinto_arch OF Supervisao_cinto_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL alarme : STD_LOGIC;
SIGNAL cinto_em_uso : STD_LOGIC;
SIGNAL ignicao_ligada : STD_LOGIC;
SIGNAL motorista_presente : STD_LOGIC;
COMPONENT Supervisao_cinto
	PORT (
	alarme : BUFFER STD_LOGIC;
	cinto_em_uso : IN STD_LOGIC;
	ignicao_ligada : IN STD_LOGIC;
	motorista_presente : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : Supervisao_cinto
	PORT MAP (
-- list connections between master ports and signals
	alarme => alarme,
	cinto_em_uso => cinto_em_uso,
	ignicao_ligada => ignicao_ligada,
	motorista_presente => motorista_presente
	);

-- cinto_em_uso
t_prcs_cinto_em_uso: PROCESS
BEGIN
LOOP
	cinto_em_uso <= '0';
	WAIT FOR 50000 ps;
	cinto_em_uso <= '1';
	WAIT FOR 50000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_cinto_em_uso;

-- ignicao_ligada
t_prcs_ignicao_ligada: PROCESS
BEGIN
LOOP
	ignicao_ligada <= '0';
	WAIT FOR 100000 ps;
	ignicao_ligada <= '1';
	WAIT FOR 100000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_ignicao_ligada;

-- motorista_presente
t_prcs_motorista_presente: PROCESS
BEGIN
	FOR i IN 1 TO 2
	LOOP
		motorista_presente <= '0';
		WAIT FOR 200000 ps;
		motorista_presente <= '1';
		WAIT FOR 200000 ps;
	END LOOP;
	motorista_presente <= '0';
WAIT;
END PROCESS t_prcs_motorista_presente;
END Supervisao_cinto_arch;
