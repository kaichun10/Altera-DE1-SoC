-------------------------------------------------------------------------------
-- Title : Color-Picker
-- Project : Color-Picker Project
-------------------------------------------------------------------------------
-- File : basic_RAM.vhd
-- Author : Kaichun Hu
-- Created : 26 ‎March ‎2021
-- Last modified : 04 ‎April ‎2021
-------------------------------------------------------------------------------
-- Description :
-- Defining simple BRAM for taking 8-bit RGB data and outputing 24-bit RGB data
-------------------------------------------------------------------------------
-- GitHub : kaichun10
-- Website : www.kaichunhu.com
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

-- simple BRAM in VHDL
ENTITY basic_RAM IS
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
END basic_RAM;

ARCHITECTURE rtl OF basic_RAM IS

   -- Define the array of the BRAM and use 8-bit STD_LOGIC_VECTOR for RGB values
   TYPE RAM_ARRAY IS ARRAY (0 TO 3) OF STD_LOGIC_VECTOR (7 DOWNTO 0);

   -- Initialise 8-bit values for BRAM
   SIGNAL RAM : RAM_ARRAY := (OTHERS => (OTHERS => '0'));

   -- Address of 8-bit RGB color
   CONSTANT RAM_R_DATA : STD_LOGIC_VECTOR (1 DOWNTO 0) := "00";
   CONSTANT RAM_G_DATA : STD_LOGIC_VECTOR (1 DOWNTO 0) := "01";
   CONSTANT RAM_B_DATA : STD_LOGIC_VECTOR (1 DOWNTO 0) := "10";

BEGIN

   -- Displaying the Write signal
   LED_RAM(0) <= RAM_WR;

   -- Make sure to synchronous RAM_Clock with clk_50 from top-level module
   -- Took many hours to debug the clk error
   PROCESS (RAM_CLOCK)
   BEGIN
      -- Synchronous BRAM module
      IF (RAM_CLOCK'event AND RAM_CLOCK = '1') THEN

         -- Write to RAM when write = 1
         IF (RAM_WR = '1') THEN

            -- Write 8-bit to RAM_ADDR
            RAM(to_integer(unsigned(RAM_ADDR))) <= RAM_DATA_IN;
         END IF;

         -- Readout 24-bit all together and output to VGA module
         -- Make sure to use the following 3 lines inside PROCESS block to avoid read error
         -- Since this is a simple BRAM
         -- Only works when assigning inside the PROCESS block
         RAM_R_DATA_OUT <= RAM(to_integer(unsigned(RAM_R_DATA)));
         RAM_G_DATA_OUT <= RAM(to_integer(unsigned(RAM_G_DATA)));
         RAM_B_DATA_OUT <= RAM(to_integer(unsigned(RAM_B_DATA)));

      END IF;
   END PROCESS;
END rtl;