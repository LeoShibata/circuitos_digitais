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
-- Generated on "04/17/2026 09:20:44"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          dec_7s
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY dec_7s_vhd_vec_tst IS
END dec_7s_vhd_vec_tst;
ARCHITECTURE dec_7s_arch OF dec_7s_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL c_7s : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL cnt_i : STD_LOGIC_VECTOR(3 DOWNTO 0);
COMPONENT dec_7s
	PORT (
	c_7s : BUFFER STD_LOGIC_VECTOR(6 DOWNTO 0);
	cnt_i : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : dec_7s
	PORT MAP (
-- list connections between master ports and signals
	c_7s => c_7s,
	cnt_i => cnt_i
	);
-- cnt_i[3]
t_prcs_cnt_i_3: PROCESS
BEGIN
LOOP
	cnt_i(3) <= '0';
	WAIT FOR 50000 ps;
	cnt_i(3) <= '1';
	WAIT FOR 50000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_cnt_i_3;
-- cnt_i[2]
t_prcs_cnt_i_2: PROCESS
BEGIN
LOOP
	cnt_i(2) <= '0';
	WAIT FOR 50000 ps;
	cnt_i(2) <= '1';
	WAIT FOR 50000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_cnt_i_2;
-- cnt_i[1]
t_prcs_cnt_i_1: PROCESS
BEGIN
LOOP
	cnt_i(1) <= '0';
	WAIT FOR 50000 ps;
	cnt_i(1) <= '1';
	WAIT FOR 50000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_cnt_i_1;
-- cnt_i[0]
t_prcs_cnt_i_0: PROCESS
BEGIN
LOOP
	cnt_i(0) <= '0';
	WAIT FOR 50000 ps;
	cnt_i(0) <= '1';
	WAIT FOR 50000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_cnt_i_0;
END dec_7s_arch;
