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

-- DATE "04/17/2026 09:20:45"

-- 
-- Device: Altera EPM240T100C5 Package TQFP100
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY IEEE;
LIBRARY MAXII;
USE IEEE.STD_LOGIC_1164.ALL;
USE MAXII.MAXII_COMPONENTS.ALL;

ENTITY 	dec_7s IS
    PORT (
	cnt_i : IN std_logic_vector(3 DOWNTO 0);
	c_7s : BUFFER std_logic_vector(6 DOWNTO 0)
	);
END dec_7s;

-- Design Ports Information


ARCHITECTURE structure OF dec_7s IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_cnt_i : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_c_7s : std_logic_vector(6 DOWNTO 0);
SIGNAL \Mux6~0_combout\ : std_logic;
SIGNAL \Mux5~0_combout\ : std_logic;
SIGNAL \Mux4~0_combout\ : std_logic;
SIGNAL \Mux3~0_combout\ : std_logic;
SIGNAL \Mux2~0_combout\ : std_logic;
SIGNAL \Mux1~0_combout\ : std_logic;
SIGNAL \Mux0~0_combout\ : std_logic;
SIGNAL \cnt_i~combout\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux1~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux2~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux3~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux4~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux5~0_combout\ : std_logic;

BEGIN

ww_cnt_i <= cnt_i;
c_7s <= ww_c_7s;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_Mux0~0_combout\ <= NOT \Mux0~0_combout\;
\ALT_INV_Mux1~0_combout\ <= NOT \Mux1~0_combout\;
\ALT_INV_Mux2~0_combout\ <= NOT \Mux2~0_combout\;
\ALT_INV_Mux3~0_combout\ <= NOT \Mux3~0_combout\;
\ALT_INV_Mux4~0_combout\ <= NOT \Mux4~0_combout\;
\ALT_INV_Mux5~0_combout\ <= NOT \Mux5~0_combout\;

-- Location: PIN_53,	 I/O Standard: 3.3V Schmitt Trigger Input,	 Current Strength: Default
\cnt_i[0]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_cnt_i(0),
	combout => \cnt_i~combout\(0));

-- Location: PIN_51,	 I/O Standard: 3.3V Schmitt Trigger Input,	 Current Strength: Default
\cnt_i[1]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_cnt_i(1),
	combout => \cnt_i~combout\(1));

-- Location: PIN_50,	 I/O Standard: 3.3V Schmitt Trigger Input,	 Current Strength: Default
\cnt_i[3]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_cnt_i(3),
	combout => \cnt_i~combout\(3));

-- Location: PIN_52,	 I/O Standard: 3.3V Schmitt Trigger Input,	 Current Strength: Default
\cnt_i[2]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_cnt_i(2),
	combout => \cnt_i~combout\(2));

-- Location: LC_X4_Y2_N6
\Mux6~0\ : maxii_lcell
-- Equation(s):
-- \Mux6~0_combout\ = (\cnt_i~combout\(2) & ((\cnt_i~combout\(0) & (!\cnt_i~combout\(1))) # (!\cnt_i~combout\(0) & ((!\cnt_i~combout\(3)))))) # (!\cnt_i~combout\(2) & (((\cnt_i~combout\(1)) # (\cnt_i~combout\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "27fc",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \cnt_i~combout\(0),
	datab => \cnt_i~combout\(1),
	datac => \cnt_i~combout\(3),
	datad => \cnt_i~combout\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Mux6~0_combout\);

-- Location: LC_X4_Y2_N4
\Mux5~0\ : maxii_lcell
-- Equation(s):
-- \Mux5~0_combout\ = (\cnt_i~combout\(0) & ((\cnt_i~combout\(3) & ((\cnt_i~combout\(2)))) # (!\cnt_i~combout\(3) & ((\cnt_i~combout\(1)) # (!\cnt_i~combout\(2)))))) # (!\cnt_i~combout\(0) & (\cnt_i~combout\(1) & (\cnt_i~combout\(3) $ 
-- (!\cnt_i~combout\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "e80e",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \cnt_i~combout\(0),
	datab => \cnt_i~combout\(1),
	datac => \cnt_i~combout\(3),
	datad => \cnt_i~combout\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Mux5~0_combout\);

-- Location: LC_X4_Y2_N7
\Mux4~0\ : maxii_lcell
-- Equation(s):
-- \Mux4~0_combout\ = (\cnt_i~combout\(0) & (((!\cnt_i~combout\(1) & !\cnt_i~combout\(2))) # (!\cnt_i~combout\(3)))) # (!\cnt_i~combout\(0) & (\cnt_i~combout\(2) & (\cnt_i~combout\(1) $ (!\cnt_i~combout\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "4b2a",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \cnt_i~combout\(0),
	datab => \cnt_i~combout\(1),
	datac => \cnt_i~combout\(3),
	datad => \cnt_i~combout\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Mux4~0_combout\);

-- Location: LC_X4_Y2_N8
\Mux3~0\ : maxii_lcell
-- Equation(s):
-- \Mux3~0_combout\ = (\cnt_i~combout\(0) & (!\cnt_i~combout\(3) & (\cnt_i~combout\(1) $ (!\cnt_i~combout\(2))))) # (!\cnt_i~combout\(0) & ((\cnt_i~combout\(1) & (\cnt_i~combout\(3))) # (!\cnt_i~combout\(1) & (!\cnt_i~combout\(3) & \cnt_i~combout\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "4942",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \cnt_i~combout\(0),
	datab => \cnt_i~combout\(1),
	datac => \cnt_i~combout\(3),
	datad => \cnt_i~combout\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Mux3~0_combout\);

-- Location: LC_X4_Y2_N9
\Mux2~0\ : maxii_lcell
-- Equation(s):
-- \Mux2~0_combout\ = (!\cnt_i~combout\(0) & ((\cnt_i~combout\(1) & (!\cnt_i~combout\(3) & !\cnt_i~combout\(2))) # (!\cnt_i~combout\(1) & (\cnt_i~combout\(3) & \cnt_i~combout\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1004",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \cnt_i~combout\(0),
	datab => \cnt_i~combout\(1),
	datac => \cnt_i~combout\(3),
	datad => \cnt_i~combout\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Mux2~0_combout\);

-- Location: LC_X4_Y2_N2
\Mux1~0\ : maxii_lcell
-- Equation(s):
-- \Mux1~0_combout\ = (\cnt_i~combout\(0) & ((\cnt_i~combout\(1) & (\cnt_i~combout\(3) & !\cnt_i~combout\(2))) # (!\cnt_i~combout\(1) & (!\cnt_i~combout\(3) & \cnt_i~combout\(2))))) # (!\cnt_i~combout\(0) & (\cnt_i~combout\(2) & (\cnt_i~combout\(1) $ 
-- (\cnt_i~combout\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1680",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \cnt_i~combout\(0),
	datab => \cnt_i~combout\(1),
	datac => \cnt_i~combout\(3),
	datad => \cnt_i~combout\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Mux1~0_combout\);

-- Location: LC_X4_Y2_N5
\Mux0~0\ : maxii_lcell
-- Equation(s):
-- \Mux0~0_combout\ = (\cnt_i~combout\(0) & (\cnt_i~combout\(3) $ (((!\cnt_i~combout\(1) & !\cnt_i~combout\(2)))))) # (!\cnt_i~combout\(0) & (\cnt_i~combout\(2) & (\cnt_i~combout\(1) $ (!\cnt_i~combout\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "e182",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \cnt_i~combout\(0),
	datab => \cnt_i~combout\(1),
	datac => \cnt_i~combout\(3),
	datad => \cnt_i~combout\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Mux0~0_combout\);

-- Location: PIN_47,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\c_7s[0]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \Mux6~0_combout\,
	oe => VCC,
	padio => ww_c_7s(0));

-- Location: PIN_43,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\c_7s[1]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \ALT_INV_Mux5~0_combout\,
	oe => VCC,
	padio => ww_c_7s(1));

-- Location: PIN_41,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\c_7s[2]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \ALT_INV_Mux4~0_combout\,
	oe => VCC,
	padio => ww_c_7s(2));

-- Location: PIN_39,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\c_7s[3]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \ALT_INV_Mux3~0_combout\,
	oe => VCC,
	padio => ww_c_7s(3));

-- Location: PIN_37,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\c_7s[4]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \ALT_INV_Mux2~0_combout\,
	oe => VCC,
	padio => ww_c_7s(4));

-- Location: PIN_35,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\c_7s[5]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \ALT_INV_Mux1~0_combout\,
	oe => VCC,
	padio => ww_c_7s(5));

-- Location: PIN_33,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\c_7s[6]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \ALT_INV_Mux0~0_combout\,
	oe => VCC,
	padio => ww_c_7s(6));
END structure;


