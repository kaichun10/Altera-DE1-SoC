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

		-- since input button 
		reset_Bar : IN STD_LOGIC;
		load_Bar : IN STD_LOGIC;
		enable_Bar : IN STD_LOGIC;

		LED_RAM : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Address to write/read RAM ------------------------
		LED_RAM_DATA_IN : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Data to write into RAM ------------------------

		state_switch : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		data_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

		seven_seg_R_0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		seven_seg_R_1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		seven_seg_G_0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		seven_seg_G_1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		seven_seg_B_0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		seven_seg_B_1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);

		-- VGA output
		VGA_R : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";
		VGA_G : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";
		VGA_B : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";

		VGA_CLK : OUT STD_LOGIC;

		VGA_HS : OUT STD_LOGIC;
		VGA_VS : OUT STD_LOGIC;

		VGA_BLANK_N : OUT STD_LOGIC := '1'; --set VGA_BLANK_N to constant activelue of 1
		VGA_SYNC_N : OUT STD_LOGIC := '0' --set VGA_SYNC_N to constant activelue of 0
	);
END color_picker;
ARCHITECTURE rtl OF color_picker IS

	COMPONENT controller
		PORT (
			clk : IN STD_LOGIC;
			enable : IN STD_LOGIC;

			-- Input data from switch
			data_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

			-- Control RGB write state
			state_switch : IN STD_LOGIC_VECTOR (1 DOWNTO 0);

			-- Store RGB data into RAM
			RAM_WR : OUT STD_LOGIC; -- Write enable 
			RAM_ADDR : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Address to write/read RAM
			RAM_DATA_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Data to write into RAM

			-- 7 seg display output for RGB values in hexadecimal
			R_data_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			G_data_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			B_data_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT basic_RAM
		PORT (
			RAM_CLOCK : IN STD_LOGIC; -- clock input for RAM
			RAM_WR : IN STD_LOGIC; -- Write enable 

			LED_RAM : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Address to write/read RAM ------------------------
			LED_RAM_DATA_IN : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Data to write into RAM ------------------------

			RAM_ADDR : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Address to write/read RAM

			RAM_DATA_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Data to write into RAM

			RAM_R_DATA_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Data output of RAM
			RAM_G_DATA_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Data output of RAM
			RAM_B_DATA_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- Data output of RAM
		);
	END COMPONENT;

	COMPONENT seven_seg
		PORT (
			data_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

			seven_seg_0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); -- digit_ones
			seven_seg_1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) -- digit_sixteens
		);
	END COMPONENT;

	-- Using SIGNAL to create intermediate state to avoid the use of BUFFER
	SIGNAL h_pos : STD_LOGIC_VECTOR (10 DOWNTO 0) := "00000000000";
	SIGNAL v_pos : STD_LOGIC_VECTOR (9 DOWNTO 0) := "0000000000";
	SIGNAL VGA_OUPUT : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL reset, load, enable, h_active, v_active, active : STD_LOGIC;
	SIGNAL toplevel_clock : STD_LOGIC;

	SIGNAL RAM_WR : STD_LOGIC;
	SIGNAL RAM_ADDR : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL RAM_DATA_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0);

	-- 7 seg display output for RGB values in hexadecimal
	SIGNAL R_data_out : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL G_data_out : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL B_data_out : STD_LOGIC_VECTOR (7 DOWNTO 0);

	-- RAM Data Output to 7 seg display output
	SIGNAL R_RAM_DATA_OUT : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL G_RAM_DATA_OUT : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL B_RAM_DATA_OUT : STD_LOGIC_VECTOR (7 DOWNTO 0);

	-- create 4 constant values for CASE block
	CONSTANT S0 : STD_LOGIC_VECTOR (1 DOWNTO 0) := "10";
	CONSTANT S1 : STD_LOGIC_VECTOR (1 DOWNTO 0) := "11";

BEGIN

	-- since PUSH button is active low (pull up register being used for PUSH buttons on the FPGA broad)
	-- PUSH button 	-- active low
	-- SWITCH 		-- active high
	-- when using PUSH buttons press down for output
	-- when using SWITCH set RESET switch high and pull down SW[3:0] for output 

	-- change PUSH buttons input from active low to active high
	-- (i.e. push down for output 1)
	-- (SWITCH pull down for output 1)
	reset <= NOT reset_Bar;
	load <= NOT load_Bar;
	enable <= NOT enable_Bar;
	-- Synchronous 50MHz onboard CLK with VGA CLK
	VGA_CLK <= clk_50;

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

		-- 7 seg display output for RGB values in hexadecimal
		R_data_out => R_data_out,
		G_data_out => G_data_out,
		B_data_out => B_data_out
	);

	U2 : basic_RAM
	PORT MAP(
		RAM_CLOCK => clk_50,
		RAM_WR => RAM_WR,

		LED_RAM => LED_RAM, -- Address to write/read RAM ------------------------
		LED_RAM_DATA_IN => LED_RAM_DATA_IN, -- Data to write into RAM ------------------------

		RAM_ADDR => RAM_ADDR,

		RAM_DATA_IN => RAM_DATA_OUT,

		RAM_R_DATA_OUT => R_RAM_DATA_OUT,
		RAM_G_DATA_OUT => G_RAM_DATA_OUT,
		RAM_B_DATA_OUT => B_RAM_DATA_OUT
	);

	U3 : seven_seg
	PORT MAP(
		data_in => R_data_out,

		seven_seg_0 => seven_seg_R_0,
		seven_seg_1 => seven_seg_R_1
	);

	U4 : seven_seg
	PORT MAP(
		data_in => G_data_out,

		seven_seg_0 => seven_seg_G_0,
		seven_seg_1 => seven_seg_G_1
	);

	U5 : seven_seg
	PORT MAP(
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

	-- if both horizontal active and vertical active then active triggered
	active <= h_active AND v_active;

	-- if active is high then wait for RGB signal input
	RGBOutput : PROCESS (active, load)
	BEGIN
		-- output RGB when in the active area of the screen and input signal (i.e. PUSH buttons / SWITCH) is HIGH
		VGA_OUPUT <= active & load;

		CASE VGA_OUPUT IS
			WHEN S0 =>
				VGA_R <= "00000000";
				VGA_G <= "00000000";
				VGA_B <= "00000000";
			WHEN S1 =>
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