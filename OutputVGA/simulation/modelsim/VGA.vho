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

-- DATE "02/23/2021 16:10:53"

-- 
-- Device: Altera 5CSEMA5F31C6 Package FBGA896
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	VGA IS
    PORT (
	clk_50 : IN std_logic;
	push_R_Bar : IN std_logic;
	push_G_Bar : IN std_logic;
	push_B_Bar : IN std_logic;
	reset_Bar : IN std_logic;
	VGA_R : OUT std_logic_vector(7 DOWNTO 0);
	VGA_G : OUT std_logic_vector(7 DOWNTO 0);
	VGA_B : OUT std_logic_vector(7 DOWNTO 0);
	VGA_CLK : OUT std_logic;
	VGA_BLANK_N : OUT std_logic;
	VGA_HS : OUT std_logic;
	VGA_VS : OUT std_logic;
	VGA_SYNC_N : OUT std_logic
	);
END VGA;

-- Design Ports Information
-- VGA_R[0]	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_R[1]	=>  Location: PIN_C13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_R[2]	=>  Location: PIN_E13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_R[3]	=>  Location: PIN_B12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_R[4]	=>  Location: PIN_C12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_R[5]	=>  Location: PIN_D12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_R[6]	=>  Location: PIN_E12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_R[7]	=>  Location: PIN_F13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_G[0]	=>  Location: PIN_J9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_G[1]	=>  Location: PIN_J10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_G[2]	=>  Location: PIN_H12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_G[3]	=>  Location: PIN_G10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_G[4]	=>  Location: PIN_G11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_G[5]	=>  Location: PIN_G12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_G[6]	=>  Location: PIN_F11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_G[7]	=>  Location: PIN_E11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_B[0]	=>  Location: PIN_B13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_B[1]	=>  Location: PIN_G13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_B[2]	=>  Location: PIN_H13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_B[3]	=>  Location: PIN_F14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_B[4]	=>  Location: PIN_H14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_B[5]	=>  Location: PIN_F15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_B[6]	=>  Location: PIN_G15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_B[7]	=>  Location: PIN_J14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_CLK	=>  Location: PIN_A11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_BLANK_N	=>  Location: PIN_F10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_HS	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_VS	=>  Location: PIN_D11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VGA_SYNC_N	=>  Location: PIN_C10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- push_R_Bar	=>  Location: PIN_W15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- push_G_Bar	=>  Location: PIN_AA15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- push_B_Bar	=>  Location: PIN_AA14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk_50	=>  Location: PIN_AF14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset_Bar	=>  Location: PIN_Y16,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF VGA IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk_50 : std_logic;
SIGNAL ww_push_R_Bar : std_logic;
SIGNAL ww_push_G_Bar : std_logic;
SIGNAL ww_push_B_Bar : std_logic;
SIGNAL ww_reset_Bar : std_logic;
SIGNAL ww_VGA_R : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_VGA_G : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_VGA_B : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_VGA_CLK : std_logic;
SIGNAL ww_VGA_BLANK_N : std_logic;
SIGNAL ww_VGA_HS : std_logic;
SIGNAL ww_VGA_VS : std_logic;
SIGNAL ww_VGA_SYNC_N : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \clk_50~input_o\ : std_logic;
SIGNAL \clk_50~inputCLKENA0_outclk\ : std_logic;
SIGNAL \Add1~33_sumout\ : std_logic;
SIGNAL \reset_Bar~input_o\ : std_logic;
SIGNAL \Add0~41_sumout\ : std_logic;
SIGNAL \Add0~26\ : std_logic;
SIGNAL \Add0~29_sumout\ : std_logic;
SIGNAL \Add0~30\ : std_logic;
SIGNAL \Add0~13_sumout\ : std_logic;
SIGNAL \Add0~14\ : std_logic;
SIGNAL \Add0~9_sumout\ : std_logic;
SIGNAL \Add0~10\ : std_logic;
SIGNAL \Add0~5_sumout\ : std_logic;
SIGNAL \Add0~6\ : std_logic;
SIGNAL \Add0~21_sumout\ : std_logic;
SIGNAL \Add0~22\ : std_logic;
SIGNAL \Add0~17_sumout\ : std_logic;
SIGNAL \Equal1~1_combout\ : std_logic;
SIGNAL \h_pos[10]~0_combout\ : std_logic;
SIGNAL \Add0~42\ : std_logic;
SIGNAL \Add0~33_sumout\ : std_logic;
SIGNAL \Add0~34\ : std_logic;
SIGNAL \Add0~37_sumout\ : std_logic;
SIGNAL \Add0~38\ : std_logic;
SIGNAL \Add0~25_sumout\ : std_logic;
SIGNAL \Add0~18\ : std_logic;
SIGNAL \Add0~1_sumout\ : std_logic;
SIGNAL \Equal1~0_combout\ : std_logic;
SIGNAL \Vcompt~1_combout\ : std_logic;
SIGNAL \Add1~10\ : std_logic;
SIGNAL \Add1~1_sumout\ : std_logic;
SIGNAL \Vcompt~0_combout\ : std_logic;
SIGNAL \v_pos[9]~0_combout\ : std_logic;
SIGNAL \Add1~34\ : std_logic;
SIGNAL \Add1~29_sumout\ : std_logic;
SIGNAL \Add1~30\ : std_logic;
SIGNAL \Add1~25_sumout\ : std_logic;
SIGNAL \Add1~26\ : std_logic;
SIGNAL \Add1~37_sumout\ : std_logic;
SIGNAL \Add1~38\ : std_logic;
SIGNAL \Add1~21_sumout\ : std_logic;
SIGNAL \Add1~22\ : std_logic;
SIGNAL \Add1~17_sumout\ : std_logic;
SIGNAL \Add1~18\ : std_logic;
SIGNAL \Add1~13_sumout\ : std_logic;
SIGNAL \Add1~14\ : std_logic;
SIGNAL \Add1~5_sumout\ : std_logic;
SIGNAL \Add1~6\ : std_logic;
SIGNAL \Add1~9_sumout\ : std_logic;
SIGNAL \LessThan5~0_combout\ : std_logic;
SIGNAL \b_sel[1]~0_combout\ : std_logic;
SIGNAL \b_sel[1]~1_combout\ : std_logic;
SIGNAL \LessThan4~0_combout\ : std_logic;
SIGNAL \LessThan4~1_combout\ : std_logic;
SIGNAL \LessThan4~2_combout\ : std_logic;
SIGNAL \push_R_Bar~input_o\ : std_logic;
SIGNAL \Mux7~0_combout\ : std_logic;
SIGNAL \push_G_Bar~input_o\ : std_logic;
SIGNAL \Mux15~0_combout\ : std_logic;
SIGNAL \push_B_Bar~input_o\ : std_logic;
SIGNAL \Mux23~0_combout\ : std_logic;
SIGNAL \LessThan0~0_combout\ : std_logic;
SIGNAL \LessThan0~1_combout\ : std_logic;
SIGNAL \LessThan1~0_combout\ : std_logic;
SIGNAL \LessThan1~1_combout\ : std_logic;
SIGNAL v_pos : std_logic_vector(9 DOWNTO 0);
SIGNAL h_pos : std_logic_vector(10 DOWNTO 0);
SIGNAL ALT_INV_h_pos : std_logic_vector(10 DOWNTO 0);
SIGNAL ALT_INV_v_pos : std_logic_vector(9 DOWNTO 0);
SIGNAL \ALT_INV_reset_Bar~input_o\ : std_logic;
SIGNAL \ALT_INV_push_B_Bar~input_o\ : std_logic;
SIGNAL \ALT_INV_push_G_Bar~input_o\ : std_logic;
SIGNAL \ALT_INV_push_R_Bar~input_o\ : std_logic;
SIGNAL \ALT_INV_Vcompt~1_combout\ : std_logic;
SIGNAL \ALT_INV_Equal1~1_combout\ : std_logic;
SIGNAL \ALT_INV_Equal1~0_combout\ : std_logic;
SIGNAL \ALT_INV_Vcompt~0_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan1~0_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~0_combout\ : std_logic;
SIGNAL \ALT_INV_b_sel[1]~1_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan4~2_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan4~1_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan4~0_combout\ : std_logic;
SIGNAL \ALT_INV_b_sel[1]~0_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan5~0_combout\ : std_logic;

BEGIN

ww_clk_50 <= clk_50;
ww_push_R_Bar <= push_R_Bar;
ww_push_G_Bar <= push_G_Bar;
ww_push_B_Bar <= push_B_Bar;
ww_reset_Bar <= reset_Bar;
VGA_R <= ww_VGA_R;
VGA_G <= ww_VGA_G;
VGA_B <= ww_VGA_B;
VGA_CLK <= ww_VGA_CLK;
VGA_BLANK_N <= ww_VGA_BLANK_N;
VGA_HS <= ww_VGA_HS;
VGA_VS <= ww_VGA_VS;
VGA_SYNC_N <= ww_VGA_SYNC_N;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
ALT_INV_h_pos(4) <= NOT h_pos(4);
ALT_INV_h_pos(3) <= NOT h_pos(3);
ALT_INV_h_pos(8) <= NOT h_pos(8);
ALT_INV_h_pos(9) <= NOT h_pos(9);
ALT_INV_h_pos(5) <= NOT h_pos(5);
ALT_INV_h_pos(6) <= NOT h_pos(6);
ALT_INV_h_pos(7) <= NOT h_pos(7);
ALT_INV_h_pos(10) <= NOT h_pos(10);
ALT_INV_v_pos(3) <= NOT v_pos(3);
ALT_INV_v_pos(0) <= NOT v_pos(0);
ALT_INV_v_pos(1) <= NOT v_pos(1);
ALT_INV_v_pos(2) <= NOT v_pos(2);
ALT_INV_v_pos(4) <= NOT v_pos(4);
ALT_INV_v_pos(5) <= NOT v_pos(5);
ALT_INV_v_pos(6) <= NOT v_pos(6);
ALT_INV_v_pos(8) <= NOT v_pos(8);
ALT_INV_v_pos(7) <= NOT v_pos(7);
ALT_INV_v_pos(9) <= NOT v_pos(9);
\ALT_INV_reset_Bar~input_o\ <= NOT \reset_Bar~input_o\;
\ALT_INV_push_B_Bar~input_o\ <= NOT \push_B_Bar~input_o\;
\ALT_INV_push_G_Bar~input_o\ <= NOT \push_G_Bar~input_o\;
\ALT_INV_push_R_Bar~input_o\ <= NOT \push_R_Bar~input_o\;
\ALT_INV_Vcompt~1_combout\ <= NOT \Vcompt~1_combout\;
\ALT_INV_Equal1~1_combout\ <= NOT \Equal1~1_combout\;
\ALT_INV_Equal1~0_combout\ <= NOT \Equal1~0_combout\;
\ALT_INV_Vcompt~0_combout\ <= NOT \Vcompt~0_combout\;
\ALT_INV_LessThan1~0_combout\ <= NOT \LessThan1~0_combout\;
\ALT_INV_LessThan0~0_combout\ <= NOT \LessThan0~0_combout\;
\ALT_INV_b_sel[1]~1_combout\ <= NOT \b_sel[1]~1_combout\;
\ALT_INV_LessThan4~2_combout\ <= NOT \LessThan4~2_combout\;
\ALT_INV_LessThan4~1_combout\ <= NOT \LessThan4~1_combout\;
\ALT_INV_LessThan4~0_combout\ <= NOT \LessThan4~0_combout\;
\ALT_INV_b_sel[1]~0_combout\ <= NOT \b_sel[1]~0_combout\;
\ALT_INV_LessThan5~0_combout\ <= NOT \LessThan5~0_combout\;
ALT_INV_h_pos(0) <= NOT h_pos(0);
ALT_INV_h_pos(2) <= NOT h_pos(2);
ALT_INV_h_pos(1) <= NOT h_pos(1);

-- Location: IOOBUF_X40_Y81_N53
\VGA_R[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux7~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_R(0));

-- Location: IOOBUF_X38_Y81_N2
\VGA_R[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux7~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_R(1));

-- Location: IOOBUF_X26_Y81_N59
\VGA_R[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux7~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_R(2));

-- Location: IOOBUF_X38_Y81_N19
\VGA_R[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux7~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_R(3));

-- Location: IOOBUF_X36_Y81_N36
\VGA_R[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux7~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_R(4));

-- Location: IOOBUF_X22_Y81_N19
\VGA_R[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux7~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_R(5));

-- Location: IOOBUF_X22_Y81_N2
\VGA_R[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux7~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_R(6));

-- Location: IOOBUF_X26_Y81_N42
\VGA_R[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux7~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_R(7));

-- Location: IOOBUF_X4_Y81_N19
\VGA_G[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux15~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_G(0));

-- Location: IOOBUF_X4_Y81_N2
\VGA_G[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux15~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_G(1));

-- Location: IOOBUF_X20_Y81_N19
\VGA_G[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux15~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_G(2));

-- Location: IOOBUF_X6_Y81_N2
\VGA_G[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux15~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_G(3));

-- Location: IOOBUF_X10_Y81_N59
\VGA_G[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux15~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_G(4));

-- Location: IOOBUF_X10_Y81_N42
\VGA_G[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux15~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_G(5));

-- Location: IOOBUF_X18_Y81_N42
\VGA_G[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux15~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_G(6));

-- Location: IOOBUF_X18_Y81_N59
\VGA_G[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux15~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_G(7));

-- Location: IOOBUF_X40_Y81_N36
\VGA_B[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux23~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_B(0));

-- Location: IOOBUF_X28_Y81_N19
\VGA_B[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux23~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_B(1));

-- Location: IOOBUF_X20_Y81_N2
\VGA_B[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux23~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_B(2));

-- Location: IOOBUF_X36_Y81_N19
\VGA_B[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux23~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_B(3));

-- Location: IOOBUF_X28_Y81_N2
\VGA_B[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux23~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_B(4));

-- Location: IOOBUF_X36_Y81_N2
\VGA_B[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux23~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_B(5));

-- Location: IOOBUF_X40_Y81_N19
\VGA_B[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux23~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_B(6));

-- Location: IOOBUF_X32_Y81_N19
\VGA_B[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux23~0_combout\,
	devoe => ww_devoe,
	o => ww_VGA_B(7));

-- Location: IOOBUF_X38_Y81_N36
\VGA_CLK~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \clk_50~inputCLKENA0_outclk\,
	devoe => ww_devoe,
	o => ww_VGA_CLK);

-- Location: IOOBUF_X6_Y81_N19
\VGA_BLANK_N~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => ww_VGA_BLANK_N);

-- Location: IOOBUF_X36_Y81_N53
\VGA_HS~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \LessThan0~1_combout\,
	devoe => ww_devoe,
	o => ww_VGA_HS);

-- Location: IOOBUF_X34_Y81_N42
\VGA_VS~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \LessThan1~1_combout\,
	devoe => ww_devoe,
	o => ww_VGA_VS);

-- Location: IOOBUF_X28_Y81_N36
\VGA_SYNC_N~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_VGA_SYNC_N);

-- Location: IOIBUF_X32_Y0_N1
\clk_50~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk_50,
	o => \clk_50~input_o\);

-- Location: CLKCTRL_G6
\clk_50~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \clk_50~input_o\,
	outclk => \clk_50~inputCLKENA0_outclk\);

-- Location: MLABCELL_X39_Y80_N0
\Add1~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~33_sumout\ = SUM(( v_pos(0) ) + ( VCC ) + ( !VCC ))
-- \Add1~34\ = CARRY(( v_pos(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_v_pos(0),
	cin => GND,
	sumout => \Add1~33_sumout\,
	cout => \Add1~34\);

-- Location: IOIBUF_X40_Y0_N18
\reset_Bar~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset_Bar,
	o => \reset_Bar~input_o\);

-- Location: LABCELL_X40_Y80_N0
\Add0~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~41_sumout\ = SUM(( h_pos(0) ) + ( VCC ) + ( !VCC ))
-- \Add0~42\ = CARRY(( h_pos(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_h_pos(0),
	cin => GND,
	sumout => \Add0~41_sumout\,
	cout => \Add0~42\);

-- Location: LABCELL_X40_Y80_N9
\Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~25_sumout\ = SUM(( h_pos(3) ) + ( GND ) + ( \Add0~38\ ))
-- \Add0~26\ = CARRY(( h_pos(3) ) + ( GND ) + ( \Add0~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_h_pos(3),
	cin => \Add0~38\,
	sumout => \Add0~25_sumout\,
	cout => \Add0~26\);

-- Location: LABCELL_X40_Y80_N12
\Add0~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~29_sumout\ = SUM(( h_pos(4) ) + ( GND ) + ( \Add0~26\ ))
-- \Add0~30\ = CARRY(( h_pos(4) ) + ( GND ) + ( \Add0~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_h_pos(4),
	cin => \Add0~26\,
	sumout => \Add0~29_sumout\,
	cout => \Add0~30\);

-- Location: FF_X40_Y80_N14
\h_pos[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add0~29_sumout\,
	sclr => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => h_pos(4));

-- Location: LABCELL_X40_Y80_N15
\Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~13_sumout\ = SUM(( h_pos(5) ) + ( GND ) + ( \Add0~30\ ))
-- \Add0~14\ = CARRY(( h_pos(5) ) + ( GND ) + ( \Add0~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_h_pos(5),
	cin => \Add0~30\,
	sumout => \Add0~13_sumout\,
	cout => \Add0~14\);

-- Location: FF_X40_Y80_N17
\h_pos[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add0~13_sumout\,
	sclr => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => h_pos(5));

-- Location: LABCELL_X40_Y80_N18
\Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~9_sumout\ = SUM(( h_pos(6) ) + ( GND ) + ( \Add0~14\ ))
-- \Add0~10\ = CARRY(( h_pos(6) ) + ( GND ) + ( \Add0~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_h_pos(6),
	cin => \Add0~14\,
	sumout => \Add0~9_sumout\,
	cout => \Add0~10\);

-- Location: FF_X40_Y80_N20
\h_pos[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add0~9_sumout\,
	sclr => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => h_pos(6));

-- Location: LABCELL_X40_Y80_N21
\Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~5_sumout\ = SUM(( h_pos(7) ) + ( GND ) + ( \Add0~10\ ))
-- \Add0~6\ = CARRY(( h_pos(7) ) + ( GND ) + ( \Add0~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_h_pos(7),
	cin => \Add0~10\,
	sumout => \Add0~5_sumout\,
	cout => \Add0~6\);

-- Location: FF_X40_Y80_N23
\h_pos[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add0~5_sumout\,
	sclr => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => h_pos(7));

-- Location: LABCELL_X40_Y80_N24
\Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~21_sumout\ = SUM(( h_pos(8) ) + ( GND ) + ( \Add0~6\ ))
-- \Add0~22\ = CARRY(( h_pos(8) ) + ( GND ) + ( \Add0~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_h_pos(8),
	cin => \Add0~6\,
	sumout => \Add0~21_sumout\,
	cout => \Add0~22\);

-- Location: FF_X40_Y80_N26
\h_pos[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add0~21_sumout\,
	sclr => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => h_pos(8));

-- Location: LABCELL_X40_Y80_N27
\Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~17_sumout\ = SUM(( h_pos(9) ) + ( GND ) + ( \Add0~22\ ))
-- \Add0~18\ = CARRY(( h_pos(9) ) + ( GND ) + ( \Add0~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_h_pos(9),
	cin => \Add0~22\,
	sumout => \Add0~17_sumout\,
	cout => \Add0~18\);

-- Location: FF_X40_Y80_N29
\h_pos[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add0~17_sumout\,
	sclr => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => h_pos(9));

-- Location: LABCELL_X40_Y80_N42
\Equal1~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal1~1_combout\ = ( !h_pos(6) & ( (!h_pos(9) & (!h_pos(8) & (h_pos(0) & !h_pos(7)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000100000000000000010000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_h_pos(9),
	datab => ALT_INV_h_pos(8),
	datac => ALT_INV_h_pos(0),
	datad => ALT_INV_h_pos(7),
	dataf => ALT_INV_h_pos(6),
	combout => \Equal1~1_combout\);

-- Location: LABCELL_X40_Y80_N48
\h_pos[10]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \h_pos[10]~0_combout\ = ( \Equal1~1_combout\ & ( (!\reset_Bar~input_o\) # ((h_pos(1) & \Equal1~0_combout\)) ) ) # ( !\Equal1~1_combout\ & ( !\reset_Bar~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1100110011001100110011001100110011001100110011111100110011001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_reset_Bar~input_o\,
	datac => ALT_INV_h_pos(1),
	datad => \ALT_INV_Equal1~0_combout\,
	dataf => \ALT_INV_Equal1~1_combout\,
	combout => \h_pos[10]~0_combout\);

-- Location: FF_X40_Y80_N2
\h_pos[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add0~41_sumout\,
	sclr => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => h_pos(0));

-- Location: LABCELL_X40_Y80_N3
\Add0~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~33_sumout\ = SUM(( h_pos(1) ) + ( GND ) + ( \Add0~42\ ))
-- \Add0~34\ = CARRY(( h_pos(1) ) + ( GND ) + ( \Add0~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_h_pos(1),
	cin => \Add0~42\,
	sumout => \Add0~33_sumout\,
	cout => \Add0~34\);

-- Location: FF_X40_Y80_N5
\h_pos[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add0~33_sumout\,
	sclr => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => h_pos(1));

-- Location: LABCELL_X40_Y80_N6
\Add0~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~37_sumout\ = SUM(( h_pos(2) ) + ( GND ) + ( \Add0~34\ ))
-- \Add0~38\ = CARRY(( h_pos(2) ) + ( GND ) + ( \Add0~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_h_pos(2),
	cin => \Add0~34\,
	sumout => \Add0~37_sumout\,
	cout => \Add0~38\);

-- Location: FF_X40_Y80_N8
\h_pos[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add0~37_sumout\,
	sclr => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => h_pos(2));

-- Location: FF_X40_Y80_N11
\h_pos[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add0~25_sumout\,
	sclr => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => h_pos(3));

-- Location: LABCELL_X40_Y80_N30
\Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~1_sumout\ = SUM(( h_pos(10) ) + ( GND ) + ( \Add0~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_h_pos(10),
	cin => \Add0~18\,
	sumout => \Add0~1_sumout\);

-- Location: FF_X40_Y80_N32
\h_pos[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add0~1_sumout\,
	sclr => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => h_pos(10));

-- Location: LABCELL_X40_Y80_N54
\Equal1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal1~0_combout\ = ( !h_pos(5) & ( h_pos(10) & ( (h_pos(3) & (!h_pos(4) & h_pos(2))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000001100000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_h_pos(3),
	datac => ALT_INV_h_pos(4),
	datad => ALT_INV_h_pos(2),
	datae => ALT_INV_h_pos(5),
	dataf => ALT_INV_h_pos(10),
	combout => \Equal1~0_combout\);

-- Location: MLABCELL_X39_Y80_N36
\Vcompt~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Vcompt~1_combout\ = ( !v_pos(5) & ( (!v_pos(6) & (v_pos(4) & (!v_pos(8) & v_pos(3)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000100000000000000010000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_v_pos(6),
	datab => ALT_INV_v_pos(4),
	datac => ALT_INV_v_pos(8),
	datad => ALT_INV_v_pos(3),
	dataf => ALT_INV_v_pos(5),
	combout => \Vcompt~1_combout\);

-- Location: MLABCELL_X39_Y80_N24
\Add1~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~9_sumout\ = SUM(( v_pos(8) ) + ( GND ) + ( \Add1~6\ ))
-- \Add1~10\ = CARRY(( v_pos(8) ) + ( GND ) + ( \Add1~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_v_pos(8),
	cin => \Add1~6\,
	sumout => \Add1~9_sumout\,
	cout => \Add1~10\);

-- Location: MLABCELL_X39_Y80_N27
\Add1~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~1_sumout\ = SUM(( v_pos(9) ) + ( GND ) + ( \Add1~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_v_pos(9),
	cin => \Add1~10\,
	sumout => \Add1~1_sumout\);

-- Location: FF_X39_Y80_N29
\v_pos[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add1~1_sumout\,
	sclr => \v_pos[9]~0_combout\,
	ena => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => v_pos(9));

-- Location: MLABCELL_X39_Y80_N48
\Vcompt~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Vcompt~0_combout\ = ( v_pos(9) & ( (v_pos(0) & (!v_pos(2) & (!v_pos(1) & v_pos(7)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000010000000000000001000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_v_pos(0),
	datab => ALT_INV_v_pos(2),
	datac => ALT_INV_v_pos(1),
	datad => ALT_INV_v_pos(7),
	dataf => ALT_INV_v_pos(9),
	combout => \Vcompt~0_combout\);

-- Location: MLABCELL_X39_Y80_N30
\v_pos[9]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \v_pos[9]~0_combout\ = ( \Equal1~1_combout\ & ( \Vcompt~0_combout\ & ( (!\reset_Bar~input_o\) # ((\Equal1~0_combout\ & (\Vcompt~1_combout\ & h_pos(1)))) ) ) ) # ( !\Equal1~1_combout\ & ( \Vcompt~0_combout\ & ( !\reset_Bar~input_o\ ) ) ) # ( 
-- \Equal1~1_combout\ & ( !\Vcompt~0_combout\ & ( !\reset_Bar~input_o\ ) ) ) # ( !\Equal1~1_combout\ & ( !\Vcompt~0_combout\ & ( !\reset_Bar~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_reset_Bar~input_o\,
	datab => \ALT_INV_Equal1~0_combout\,
	datac => \ALT_INV_Vcompt~1_combout\,
	datad => ALT_INV_h_pos(1),
	datae => \ALT_INV_Equal1~1_combout\,
	dataf => \ALT_INV_Vcompt~0_combout\,
	combout => \v_pos[9]~0_combout\);

-- Location: FF_X39_Y80_N2
\v_pos[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add1~33_sumout\,
	sclr => \v_pos[9]~0_combout\,
	ena => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => v_pos(0));

-- Location: MLABCELL_X39_Y80_N3
\Add1~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~29_sumout\ = SUM(( v_pos(1) ) + ( GND ) + ( \Add1~34\ ))
-- \Add1~30\ = CARRY(( v_pos(1) ) + ( GND ) + ( \Add1~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_v_pos(1),
	cin => \Add1~34\,
	sumout => \Add1~29_sumout\,
	cout => \Add1~30\);

-- Location: FF_X39_Y80_N5
\v_pos[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add1~29_sumout\,
	sclr => \v_pos[9]~0_combout\,
	ena => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => v_pos(1));

-- Location: MLABCELL_X39_Y80_N6
\Add1~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~25_sumout\ = SUM(( v_pos(2) ) + ( GND ) + ( \Add1~30\ ))
-- \Add1~26\ = CARRY(( v_pos(2) ) + ( GND ) + ( \Add1~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_v_pos(2),
	cin => \Add1~30\,
	sumout => \Add1~25_sumout\,
	cout => \Add1~26\);

-- Location: FF_X39_Y80_N8
\v_pos[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add1~25_sumout\,
	sclr => \v_pos[9]~0_combout\,
	ena => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => v_pos(2));

-- Location: MLABCELL_X39_Y80_N9
\Add1~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~37_sumout\ = SUM(( v_pos(3) ) + ( GND ) + ( \Add1~26\ ))
-- \Add1~38\ = CARRY(( v_pos(3) ) + ( GND ) + ( \Add1~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_v_pos(3),
	cin => \Add1~26\,
	sumout => \Add1~37_sumout\,
	cout => \Add1~38\);

-- Location: FF_X39_Y80_N11
\v_pos[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add1~37_sumout\,
	sclr => \v_pos[9]~0_combout\,
	ena => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => v_pos(3));

-- Location: MLABCELL_X39_Y80_N12
\Add1~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~21_sumout\ = SUM(( v_pos(4) ) + ( GND ) + ( \Add1~38\ ))
-- \Add1~22\ = CARRY(( v_pos(4) ) + ( GND ) + ( \Add1~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_v_pos(4),
	cin => \Add1~38\,
	sumout => \Add1~21_sumout\,
	cout => \Add1~22\);

-- Location: FF_X39_Y80_N14
\v_pos[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add1~21_sumout\,
	sclr => \v_pos[9]~0_combout\,
	ena => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => v_pos(4));

-- Location: MLABCELL_X39_Y80_N15
\Add1~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~17_sumout\ = SUM(( v_pos(5) ) + ( GND ) + ( \Add1~22\ ))
-- \Add1~18\ = CARRY(( v_pos(5) ) + ( GND ) + ( \Add1~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_v_pos(5),
	cin => \Add1~22\,
	sumout => \Add1~17_sumout\,
	cout => \Add1~18\);

-- Location: FF_X39_Y80_N17
\v_pos[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add1~17_sumout\,
	sclr => \v_pos[9]~0_combout\,
	ena => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => v_pos(5));

-- Location: MLABCELL_X39_Y80_N18
\Add1~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~13_sumout\ = SUM(( v_pos(6) ) + ( GND ) + ( \Add1~18\ ))
-- \Add1~14\ = CARRY(( v_pos(6) ) + ( GND ) + ( \Add1~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_v_pos(6),
	cin => \Add1~18\,
	sumout => \Add1~13_sumout\,
	cout => \Add1~14\);

-- Location: FF_X39_Y80_N20
\v_pos[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add1~13_sumout\,
	sclr => \v_pos[9]~0_combout\,
	ena => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => v_pos(6));

-- Location: MLABCELL_X39_Y80_N21
\Add1~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~5_sumout\ = SUM(( v_pos(7) ) + ( GND ) + ( \Add1~14\ ))
-- \Add1~6\ = CARRY(( v_pos(7) ) + ( GND ) + ( \Add1~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_v_pos(7),
	cin => \Add1~14\,
	sumout => \Add1~5_sumout\,
	cout => \Add1~6\);

-- Location: FF_X39_Y80_N23
\v_pos[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add1~5_sumout\,
	sclr => \v_pos[9]~0_combout\,
	ena => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => v_pos(7));

-- Location: FF_X39_Y80_N26
\v_pos[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50~inputCLKENA0_outclk\,
	d => \Add1~9_sumout\,
	sclr => \v_pos[9]~0_combout\,
	ena => \h_pos[10]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => v_pos(8));

-- Location: LABCELL_X37_Y80_N3
\LessThan5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan5~0_combout\ = ( v_pos(3) & ( v_pos(2) & ( (!v_pos(4) & ((!v_pos(0)) # (!v_pos(1)))) ) ) ) # ( !v_pos(3) & ( v_pos(2) & ( !v_pos(4) ) ) ) # ( v_pos(3) & ( !v_pos(2) & ( !v_pos(4) ) ) ) # ( !v_pos(3) & ( !v_pos(2) & ( !v_pos(4) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000011110000111100001111000011110000111100001111000010100000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_v_pos(0),
	datac => ALT_INV_v_pos(4),
	datad => ALT_INV_v_pos(1),
	datae => ALT_INV_v_pos(3),
	dataf => ALT_INV_v_pos(2),
	combout => \LessThan5~0_combout\);

-- Location: MLABCELL_X39_Y80_N45
\b_sel[1]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \b_sel[1]~0_combout\ = ( v_pos(6) & ( (!v_pos(8) & (!v_pos(7) & ((!v_pos(5)) # (\LessThan5~0_combout\)))) ) ) # ( !v_pos(6) & ( (!v_pos(8) & !v_pos(7)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101000000000101010100000000010001010000000001000101000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_v_pos(8),
	datab => ALT_INV_v_pos(5),
	datac => \ALT_INV_LessThan5~0_combout\,
	datad => ALT_INV_v_pos(7),
	dataf => ALT_INV_v_pos(6),
	combout => \b_sel[1]~0_combout\);

-- Location: LABCELL_X40_Y80_N36
\b_sel[1]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \b_sel[1]~1_combout\ = ( h_pos(9) & ( h_pos(8) & ( (!h_pos(10) & (!h_pos(7) & ((!h_pos(6)) # (!h_pos(5))))) ) ) ) # ( !h_pos(9) & ( h_pos(8) & ( !h_pos(10) ) ) ) # ( h_pos(9) & ( !h_pos(8) & ( !h_pos(10) ) ) ) # ( !h_pos(9) & ( !h_pos(8) & ( (!h_pos(10) & 
-- ((h_pos(7)) # (h_pos(6)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100110001001100110011001100110011001100110011001100000010000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_h_pos(6),
	datab => ALT_INV_h_pos(10),
	datac => ALT_INV_h_pos(7),
	datad => ALT_INV_h_pos(5),
	datae => ALT_INV_h_pos(9),
	dataf => ALT_INV_h_pos(8),
	combout => \b_sel[1]~1_combout\);

-- Location: LABCELL_X37_Y80_N6
\LessThan4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan4~0_combout\ = ( v_pos(1) & ( v_pos(2) & ( (v_pos(4) & v_pos(0)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000001100000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_v_pos(4),
	datac => ALT_INV_v_pos(0),
	datae => ALT_INV_v_pos(1),
	dataf => ALT_INV_v_pos(2),
	combout => \LessThan4~0_combout\);

-- Location: MLABCELL_X39_Y80_N39
\LessThan4~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan4~1_combout\ = ( !v_pos(9) & ( (!v_pos(7) & ((!v_pos(4)) # (!v_pos(3)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111110000000000111111000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_v_pos(4),
	datac => ALT_INV_v_pos(3),
	datad => ALT_INV_v_pos(7),
	dataf => ALT_INV_v_pos(9),
	combout => \LessThan4~1_combout\);

-- Location: MLABCELL_X39_Y80_N42
\LessThan4~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan4~2_combout\ = ( \LessThan4~1_combout\ & ( (!v_pos(8) & (!v_pos(5) & (!v_pos(6) & !\LessThan4~0_combout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000010000000000000001000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_v_pos(8),
	datab => ALT_INV_v_pos(5),
	datac => ALT_INV_v_pos(6),
	datad => \ALT_INV_LessThan4~0_combout\,
	dataf => \ALT_INV_LessThan4~1_combout\,
	combout => \LessThan4~2_combout\);

-- Location: IOIBUF_X40_Y0_N1
\push_R_Bar~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_push_R_Bar,
	o => \push_R_Bar~input_o\);

-- Location: LABCELL_X37_Y80_N27
\Mux7~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux7~0_combout\ = ( !\LessThan4~2_combout\ & ( !\push_R_Bar~input_o\ & ( (\b_sel[1]~1_combout\ & ((!v_pos(9)) # (\b_sel[1]~0_combout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011000100110001000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_b_sel[1]~0_combout\,
	datab => \ALT_INV_b_sel[1]~1_combout\,
	datac => ALT_INV_v_pos(9),
	datae => \ALT_INV_LessThan4~2_combout\,
	dataf => \ALT_INV_push_R_Bar~input_o\,
	combout => \Mux7~0_combout\);

-- Location: IOIBUF_X36_Y0_N18
\push_G_Bar~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_push_G_Bar,
	o => \push_G_Bar~input_o\);

-- Location: LABCELL_X37_Y80_N30
\Mux15~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux15~0_combout\ = ( \b_sel[1]~1_combout\ & ( v_pos(9) & ( (!\push_G_Bar~input_o\ & (\b_sel[1]~0_combout\ & !\LessThan4~2_combout\)) ) ) ) # ( \b_sel[1]~1_combout\ & ( !v_pos(9) & ( (!\push_G_Bar~input_o\ & !\LessThan4~2_combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011000000000000000000000000000000110000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_push_G_Bar~input_o\,
	datac => \ALT_INV_b_sel[1]~0_combout\,
	datad => \ALT_INV_LessThan4~2_combout\,
	datae => \ALT_INV_b_sel[1]~1_combout\,
	dataf => ALT_INV_v_pos(9),
	combout => \Mux15~0_combout\);

-- Location: IOIBUF_X36_Y0_N1
\push_B_Bar~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_push_B_Bar,
	o => \push_B_Bar~input_o\);

-- Location: LABCELL_X37_Y80_N36
\Mux23~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux23~0_combout\ = ( \b_sel[1]~1_combout\ & ( v_pos(9) & ( (\b_sel[1]~0_combout\ & (!\LessThan4~2_combout\ & !\push_B_Bar~input_o\)) ) ) ) # ( \b_sel[1]~1_combout\ & ( !v_pos(9) & ( (!\LessThan4~2_combout\ & !\push_B_Bar~input_o\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110000001100000000000000000000000100000001000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_b_sel[1]~0_combout\,
	datab => \ALT_INV_LessThan4~2_combout\,
	datac => \ALT_INV_push_B_Bar~input_o\,
	datae => \ALT_INV_b_sel[1]~1_combout\,
	dataf => ALT_INV_v_pos(9),
	combout => \Mux23~0_combout\);

-- Location: LABCELL_X40_Y80_N51
\LessThan0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~0_combout\ = ( !h_pos(5) & ( (!h_pos(6) & ((!h_pos(3)) # (!h_pos(4)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010100000101010101010000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_h_pos(6),
	datac => ALT_INV_h_pos(3),
	datad => ALT_INV_h_pos(4),
	dataf => ALT_INV_h_pos(5),
	combout => \LessThan0~0_combout\);

-- Location: LABCELL_X40_Y80_N45
\LessThan0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~1_combout\ = ( \LessThan0~0_combout\ & ( !h_pos(10) ) ) # ( !\LessThan0~0_combout\ & ( (!h_pos(10) & ((!h_pos(9)) # ((!h_pos(8)) # (!h_pos(7))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000011100000111100001110000011110000111100001111000011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_h_pos(9),
	datab => ALT_INV_h_pos(8),
	datac => ALT_INV_h_pos(10),
	datad => ALT_INV_h_pos(7),
	dataf => \ALT_INV_LessThan0~0_combout\,
	combout => \LessThan0~1_combout\);

-- Location: MLABCELL_X39_Y80_N51
\LessThan1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan1~0_combout\ = ( v_pos(3) & ( v_pos(4) ) ) # ( !v_pos(3) & ( (v_pos(2) & v_pos(4)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000001100000011000000110000001100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_v_pos(2),
	datac => ALT_INV_v_pos(4),
	dataf => ALT_INV_v_pos(3),
	combout => \LessThan1~0_combout\);

-- Location: MLABCELL_X39_Y80_N54
\LessThan1~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan1~1_combout\ = ( v_pos(7) & ( \LessThan1~0_combout\ & ( !v_pos(9) ) ) ) # ( !v_pos(7) & ( \LessThan1~0_combout\ & ( (!v_pos(8)) # (!v_pos(9)) ) ) ) # ( v_pos(7) & ( !\LessThan1~0_combout\ & ( (!v_pos(9)) # ((!v_pos(6) & (!v_pos(5) & !v_pos(8)))) 
-- ) ) ) # ( !v_pos(7) & ( !\LessThan1~0_combout\ & ( (!v_pos(8)) # (!v_pos(9)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111110000111111111000000011111111111100001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_v_pos(6),
	datab => ALT_INV_v_pos(5),
	datac => ALT_INV_v_pos(8),
	datad => ALT_INV_v_pos(9),
	datae => ALT_INV_v_pos(7),
	dataf => \ALT_INV_LessThan1~0_combout\,
	combout => \LessThan1~1_combout\);

-- Location: LABCELL_X73_Y34_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


