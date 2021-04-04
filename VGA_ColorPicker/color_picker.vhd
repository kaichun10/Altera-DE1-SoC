-------------------------------------------------------------------------------
-- Title : Color-Picker
-- Project : Color-Picker Project
-------------------------------------------------------------------------------
-- File : color_picker.vhd
-- Author : Kaichun Hu
-- Created : 26 ‎March ‎2021
-- Last modified : 04 ‎April ‎2021
-------------------------------------------------------------------------------
-- Description :
-- 24 bits VGA color picker from hexadecimal value
-------------------------------------------------------------------------------
-- GitHub : kaichun10
-- Website : www.kaichunhu.com
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY color_picker IS

	PORT (
		--CLK input
		--PUSH button or SWITCH input
		--RESET input
		clk_50 : IN STD_LOGIC;

		-- since input button is Active-High when NOT pressed and Active-Low when pressed down
		-- Active-High when button is pressed down after reverse
		reset_Bar : IN STD_LOGIC;
		load_Bar : IN STD_LOGIC;
		enable_Bar : IN STD_LOGIC;

		-- LED used for debugging
		LED_RAM : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		LED_RAM_DATA_IN : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);

		-- STATE-Switch controlling the RGB state for the FSM
		state_switch : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		-- 8-bit Data input of single color channel from Switch[9:2]
		data_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

		-- 6-Digit Hexadecimal output for displaying the 24-bit RGB color on 7-Segment LED display
		seven_seg_R_0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		seven_seg_R_1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		seven_seg_G_0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		seven_seg_G_1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		seven_seg_B_0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		seven_seg_B_1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);

		-- 8-bit VGA output of RGB channel
		VGA_R : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";
		VGA_G : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";
		VGA_B : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";

		-- VGA CLK synchronous to CLK_50 
		VGA_CLK : OUT STD_LOGIC;

		-- VGA horizontal and vertical synchronous
		VGA_HS : OUT STD_LOGIC;
		VGA_VS : OUT STD_LOGIC;

		-- Set VGA_BLANK_N to constant activelue of 1
		VGA_BLANK_N : OUT STD_LOGIC := '1';
		-- Set VGA_SYNC_N to constant activelue of 0
		VGA_SYNC_N : OUT STD_LOGIC := '0'
	);
END color_picker;
ARCHITECTURE rtl OF color_picker IS

	-- Defining COMPONENT
	COMPONENT controller
		PORT (
			-- CLK_50 from top level entity
			clk : IN STD_LOGIC;
			-- Enable signal for writing data into BRAM
			enable : IN STD_LOGIC;

			-- Input data from switch
			data_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

			-- Control RGB write state
			state_switch : IN STD_LOGIC_VECTOR (1 DOWNTO 0);

			-- Store RGB data into RAM
			-- Write enable
			RAM_WR : OUT STD_LOGIC;
			-- Address to write data into the BRAM
			RAM_ADDR : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			-- 8-bit single color channel output for the BRAM
			RAM_DATA_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);

			-- 7 seg display output for RGB values in hexadecimal
			R_data_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			G_data_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			B_data_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT basic_RAM
		PORT (
			-- CLK (need to synchronous to CLK_50)
			RAM_CLOCK : IN STD_LOGIC;

			-- Enable for writing 
			RAM_WR : IN STD_LOGIC;

			-- LED indicator for displaying write instruction
			LED_RAM : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);

			-- LED indicator for debugging
			LED_RAM_DATA_IN : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);

			-- Address to write data into the BRAM
			RAM_ADDR : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

			-- 8-bit single color channel input for the BRAM
			RAM_DATA_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

			-- RGB data output from the BRAM
			RAM_R_DATA_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			RAM_G_DATA_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			RAM_B_DATA_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT seven_seg
		PORT (
			-- Raw RGB data input to the 7-Seg module
			data_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

			-- 7-Seg LEDs for displaying:
			-- Digit_ones
			seven_seg_0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
			-- Digit_sixteens
			seven_seg_1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
	END COMPONENT;

	-- Using SIGNAL to create intermediate state to avoid the use of BUFFER
	SIGNAL h_pos : STD_LOGIC_VECTOR (10 DOWNTO 0) := "00000000000";
	SIGNAL v_pos : STD_LOGIC_VECTOR (9 DOWNTO 0) := "0000000000";

	-- Defining VGA Output Enable
	SIGNAL VGA_OUPUT : STD_LOGIC_VECTOR (1 DOWNTO 0);

	-- Defining VGA reset load enable 
	-- Defining VGA h_active v_active active
	SIGNAL reset, load, enable, h_active, v_active, active : STD_LOGIC;

	-- Definging RAM Write signal RAM Address 
	-- and Data to be write into BRAM
	SIGNAL RAM_WR : STD_LOGIC;
	SIGNAL RAM_ADDR : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL RAM_DATA_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0);

	-- Input for 7-Seg display decoder
	SIGNAL R_data_out : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL G_data_out : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL B_data_out : STD_LOGIC_VECTOR (7 DOWNTO 0);

	-- RAM Data output to VGA display
	SIGNAL R_RAM_DATA_OUT : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL G_RAM_DATA_OUT : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL B_RAM_DATA_OUT : STD_LOGIC_VECTOR (7 DOWNTO 0);

	-- Create constant values for CASE block
	CONSTANT S0 : STD_LOGIC_VECTOR (1 DOWNTO 0) := "10";
	CONSTANT S1 : STD_LOGIC_VECTOR (1 DOWNTO 0) := "11";

BEGIN

	-- Since PUSH button is active low ( because pull up register being used for PUSH buttons on the FPGA broad)
	-- PUSH button 	-- active low
	-- when using PUSH buttons press down for output

	-- change PUSH buttons input from active low to active high
	-- (i.e. push down for output 1)
	reset <= NOT reset_Bar;
	load <= NOT load_Bar;
	enable <= NOT enable_Bar;

	-- Synchronous 50MHz onboard CLK with VGA CLK
	VGA_CLK <= clk_50;

	-- Defining PORT MAP
	U1 : controller
	PORT MAP(
		clk => clk_50,
		enable => enable,

		-- Input data from switch
		data_in => data_in,
		-- Control RGB write state
		state_switch => state_switch,
		-- Store RGB data into RAM
		RAM_WR => RAM_WR,
		RAM_ADDR => RAM_ADDR,
		RAM_DATA_OUT => RAM_DATA_OUT,

		-- Input for 7-Seg display decoder
		R_data_out => R_data_out,
		G_data_out => G_data_out,
		B_data_out => B_data_out
	);

	U2 : basic_RAM
	PORT MAP(
		-- Synchronous BRAM CLK with onboard 50MHz CLK
		RAM_CLOCK => clk_50,
		RAM_WR => RAM_WR,

		LED_RAM => LED_RAM,
		LED_RAM_DATA_IN => LED_RAM_DATA_IN,

		-- RAM Address
		RAM_ADDR => RAM_ADDR,

		-- Input Data for RAM
		RAM_DATA_IN => RAM_DATA_OUT,

		-- RAM Data output to VGA display
		RAM_R_DATA_OUT => R_RAM_DATA_OUT,
		RAM_G_DATA_OUT => G_RAM_DATA_OUT,
		RAM_B_DATA_OUT => B_RAM_DATA_OUT
	);

	U3 : seven_seg
	PORT MAP(
		-- Input R Data for 7-Seg
		data_in => R_data_out,
		seven_seg_0 => seven_seg_R_0,
		seven_seg_1 => seven_seg_R_1
	);

	U4 : seven_seg
	PORT MAP(
		-- Input G Data for 7-Seg
		data_in => G_data_out,
		seven_seg_0 => seven_seg_G_0,
		seven_seg_1 => seven_seg_G_1
	);

	U5 : seven_seg
	PORT MAP(
		-- Input B Data for 7-Seg
		data_in => B_data_out,
		seven_seg_0 => seven_seg_B_0,
		seven_seg_1 => seven_seg_B_1
	);

	--Increment horizontal position in the active area  
	Hcompt : PROCESS (clk_50)
	BEGIN
		IF rising_edge(clk_50) THEN
			IF reset = '1' THEN
				h_pos <= "00000000000";
			ELSE
				IF h_pos = 1039 THEN
					h_pos <= "00000000000";

				ELSE
					h_pos <= h_pos + 1;

				END IF;
			END IF;
		END IF;
	END PROCESS Hcompt;

	--Increment vertical position in the active area 
	Vcompt : PROCESS (clk_50, h_pos, reset)
	BEGIN
		IF rising_edge(clk_50) THEN
			IF reset = '1' THEN
				v_pos <= "0000000000";
			ELSE
				IF (v_pos = 665 AND h_pos = 1039) THEN
					v_pos <= "0000000000";
				ELSE
					IF h_pos = 1039 THEN
						v_pos <= v_pos + 1;
					END IF;
				END IF;
			END IF;
		END IF;
	END PROCESS Vcompt;

	-- Horizontal synchronous goes low between front porch and back porch
	HSync : PROCESS (h_pos)
	BEGIN
		IF h_pos >= 920 THEN
			VGA_HS <= '0';
		ELSE
			VGA_HS <= '1';
		END IF;
	END PROCESS HSync;

	-- Vertical synchronous goes low between front porch and back porch
	VSync : PROCESS (v_pos)
	BEGIN
		IF v_pos >= 660 THEN
			VGA_VS <= '0';
		ELSE
			VGA_VS <= '1';
		END IF;
	END PROCESS VSync;

	-- Horizontal active area
	HActive : PROCESS (h_pos)
	BEGIN
		IF (h_pos > 63 AND h_pos < 864) THEN
			h_active <= '1';
		ELSE
			h_active <= '0';
		END IF;
	END PROCESS HActive;

	-- Vertical active area
	VActive : PROCESS (v_pos)
	BEGIN
		IF (v_pos > 22 AND v_pos < 623) THEN
			v_active <= '1';
		ELSE
			v_active <= '0';
		END IF;
	END PROCESS VActive;

	-- If both horizontal active and vertical active then active triggered
	active <= h_active AND v_active;

	-- If active is high then wait for RGB signal input
	RGBOutput : PROCESS (active, load)
	BEGIN
		-- Output RGB when in the active area of the screen and input signal (i.e. PUSH buttons) is HIGH
		VGA_OUPUT <= active & load;

		CASE VGA_OUPUT IS
			WHEN S0 =>
				VGA_R <= "00000000";
				VGA_G <= "00000000";
				VGA_B <= "00000000";
			WHEN S1 =>
				-- HIGH-STATE
				VGA_R <= R_RAM_DATA_OUT;
				VGA_G <= G_RAM_DATA_OUT;
				VGA_B <= B_RAM_DATA_OUT;
			WHEN OTHERS =>
				VGA_R <= "00000000";
				VGA_G <= "00000000";
				VGA_B <= "00000000";
		END CASE;
	END PROCESS RGBOutput;
END rtl;