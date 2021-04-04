-------------------------------------------------------------------------------
-- Title : Color-Picker
-- Project : Color-Picker Project
-------------------------------------------------------------------------------
-- File : controller.vhd
-- Author : Kaichun Hu
-- Created : 26 ‎March ‎2021
-- Last modified : 04 ‎April ‎2021
-------------------------------------------------------------------------------
-- Description :
-- FSM for output 8-bit RGB color to BRAM
-------------------------------------------------------------------------------
-- GitHub : kaichun10
-- Website : www.kaichunhu.com
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY controller IS
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
END controller;

ARCHITECTURE rtl OF controller IS

    -- Defining 3 states for Moore machine
    TYPE states IS (R_write, G_write, B_write);
    -- Define present and next state
    SIGNAL present_state : states;
    SIGNAL next_state : states;

BEGIN
    PROCESS (clk)
    BEGIN
        IF (clk'event AND clk = '1') THEN
            -- Update the states
            present_state <= next_state;
        ELSE
            NULL;
        END IF;
    END PROCESS;

    PROCESS (clk)
    BEGIN
        IF (clk'event AND clk = '1') THEN
            -- Update the states
            next_state <= present_state;

            -- Entering the FSM module
            CASE present_state IS
                WHEN R_write =>
                    -- Write R channel data
                    -- and update state depending on STATE-Switch value
                    IF state_switch = "00" THEN
                        next_state <= R_write;
                        -- Data to 7 seg output
                        R_data_out <= data_in;
                        -- Write RAM data
                        RAM_WR <= enable;
                        RAM_ADDR <= "00";
                        RAM_DATA_OUT <= data_in;
                    END IF;

                    IF state_switch = "01" THEN
                        next_state <= G_write;
                    END IF;

                    IF state_switch = "10" THEN
                        next_state <= B_write;
                    END IF;

                    -- Remain inside own state
                    IF state_switch = "11" THEN
                        next_state <= R_write;
                    END IF;

                WHEN G_write =>
                    -- Write G channel data
                    -- and update state depending on STATE-Switch value
                    IF state_switch = "00" THEN
                        next_state <= R_write;
                    END IF;

                    IF state_switch = "01" THEN
                        next_state <= G_write;
                        -- Data to 7 seg output
                        G_data_out <= data_in;
                        -- Write RAM data
                        RAM_WR <= enable;
                        RAM_ADDR <= "01";
                        RAM_DATA_OUT <= data_in;

                    END IF;
                    IF state_switch = "10" THEN
                        next_state <= B_write;
                    END IF;

                    -- Remain inside own state
                    IF state_switch = "11" THEN
                        next_state <= G_write;
                    END IF;

                WHEN B_write =>
                    -- Write B channel data
                    -- and update state depending on STATE-Switch value
                    IF state_switch = "00" THEN
                        next_state <= R_write;
                    END IF;

                    IF state_switch = "01" THEN
                        next_state <= G_write;
                    END IF;

                    IF state_switch = "10" THEN
                        next_state <= B_write;
                        -- Data to 7 seg output
                        B_data_out <= data_in;
                        -- Write RAM data
                        RAM_WR <= enable;
                        RAM_ADDR <= "10";
                        RAM_DATA_OUT <= data_in;
                    END IF;

                    -- Remain inside own state
                    IF state_switch = "11" THEN
                        next_state <= B_write;
                    END IF;

                WHEN OTHERS =>
                    -- Set the default state and outputs.
                    next_state <= R_write;
                    R_data_out <= "00000000";
                    G_data_out <= "00000000";
                    B_data_out <= "00000000";

                    next_state <= G_write;
                    -- Data to 7 seg output
                    R_data_out <= "00000000";
                    G_data_out <= "00000000";
                    B_data_out <= "00000000";

                    -- Write RAM data
                    RAM_WR <= '0';
                    RAM_ADDR <= "11";
                    RAM_DATA_OUT <= x"ff"; -- use for debug

            END CASE;
        END IF;
    END PROCESS;
END rtl;