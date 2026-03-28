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

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"

-- DATE "03/28/2026 16:39:11"

-- 
-- Device: Altera EPM240T100C5 Package TQFP100
-- 

-- 
-- This VHDL file should be used for ModelSim (VHDL) only
-- 

LIBRARY IEEE;
LIBRARY MAXII;
USE IEEE.STD_LOGIC_1164.ALL;
USE MAXII.MAXII_COMPONENTS.ALL;

ENTITY 	Supervisao_cinto IS
    PORT (
	motorista_presente : IN std_logic;
	cinto_em_uso : IN std_logic;
	ignicao_ligada : IN std_logic;
	alarme : BUFFER std_logic
	);
END Supervisao_cinto;

-- Design Ports Information


ARCHITECTURE structure OF Supervisao_cinto IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_motorista_presente : std_logic;
SIGNAL ww_cinto_em_uso : std_logic;
SIGNAL ww_ignicao_ligada : std_logic;
SIGNAL ww_alarme : std_logic;
SIGNAL \motorista_presente~combout\ : std_logic;
SIGNAL \cinto_em_uso~combout\ : std_logic;
SIGNAL \ignicao_ligada~combout\ : std_logic;
SIGNAL \alarme~0_combout\ : std_logic;

BEGIN

ww_motorista_presente <= motorista_presente;
ww_cinto_em_uso <= cinto_em_uso;
ww_ignicao_ligada <= ignicao_ligada;
alarme <= ww_alarme;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: PIN_30,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\motorista_presente~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_motorista_presente,
	combout => \motorista_presente~combout\);

-- Location: PIN_34,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\cinto_em_uso~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_cinto_em_uso,
	combout => \cinto_em_uso~combout\);

-- Location: PIN_36,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\ignicao_ligada~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_ignicao_ligada,
	combout => \ignicao_ligada~combout\);

-- Location: LC_X3_Y1_N2
\alarme~0\ : maxii_lcell
-- Equation(s):
-- \alarme~0_combout\ = (\motorista_presente~combout\ & (((!\cinto_em_uso~combout\ & \ignicao_ligada~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0a00",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \motorista_presente~combout\,
	datac => \cinto_em_uso~combout\,
	datad => \ignicao_ligada~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \alarme~0_combout\);

-- Location: PIN_75,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\alarme~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \alarme~0_combout\,
	oe => VCC,
	padio => ww_alarme);
END structure;


