LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

-- A 128x8 single-port RAM in VHDL
ENTITY basic_RAM IS
   PORT (
      RAM_CLOCK : IN STD_LOGIC; -- clock input for RAM
      RAM_WR : IN STD_LOGIC; -- Write enable 

      LED_RAM_ADDR : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Address to write/read RAM
      LED_RAM_DATA_IN : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Data to write into RAM

      RAM_ADDR : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Address to write/read RAM
      RAM_DATA_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Data to write into RAM

      RAM_R_DATA_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Data output of RAM
      RAM_G_DATA_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Data output of RAM
      RAM_B_DATA_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- Data output of RAM
   );
END basic_RAM;

ARCHITECTURE rtl OF basic_RAM IS
   -- define the new type for the 128x8 RAM 
   TYPE RAM_ARRAY IS ARRAY (0 TO 3) OF STD_LOGIC_VECTOR (7 DOWNTO 0);
   -- initial values in the RAM
   SIGNAL RAM : RAM_ARRAY := (
      x"55", x"66", x"77", x"67"
   );

   SIGNAL R_DATA_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL G_DATA_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL B_DATA_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0);

   CONSTANT RAM_R_DATA : STD_LOGIC_VECTOR (1 DOWNTO 0) := "00";
   CONSTANT RAM_G_DATA : STD_LOGIC_VECTOR (1 DOWNTO 0) := "01";
   CONSTANT RAM_B_DATA : STD_LOGIC_VECTOR (1 DOWNTO 0) := "10";

   SIGNAL read_address : STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN

   LED_RAM_ADDR (0) <= RAM_WR;
   PROCESS (RAM_CLOCK)
   BEGIN
      IF (RAM_CLOCK'event AND RAM_CLOCK = '1') THEN

         IF (RAM_WR = '1') THEN -- when write enable = 1, 
            -- write input data into RAM at the provided address
            RAM(to_integer(unsigned(RAM_ADDR))) <= RAM_DATA_IN;

         END IF;

         read_address <= RAM_ADDR;
      END IF;
   END PROCESS;

   LED_RAM_DATA_IN <= RAM(to_integer(unsigned(read_address)));

   R_DATA_OUT <= RAM(to_integer(unsigned(RAM_R_DATA)));
   G_DATA_OUT <= RAM(to_integer(unsigned(RAM_G_DATA)));
   B_DATA_OUT <= RAM(to_integer(unsigned(RAM_B_DATA)));

   RAM_R_DATA_OUT <= R_DATA_OUT;
   RAM_G_DATA_OUT <= G_DATA_OUT;
   RAM_B_DATA_OUT <= B_DATA_OUT;
   -- Data to write into RAM
   -- The index of the RAM array type needs to be integer so
   -- converts RAM_ADDR from std_logic_vector -> Unsigned -> Interger using numeric_std library

   -- Data to be read out 
   -- RAM(to_integer(unsigned(RAM_ADDR))) <= RAM_DATA_IN;

   -- LED_RAM_DATA_IN <= RAM(to_integer(unsigned(RAM_R_DATA)));

   -- Data to write into RAM
   -- The index of the RAM array type needs to be integer so
   -- converts RAM_ADDR from std_logic_vector -> Unsigned -> Interger using numeric_std library

   -- RAM_R_DATA_OUT <= RAM(to_integer(unsigned(RAM_R_DATA))) WHEN ((RAM_CLOCK'event AND RAM_CLOCK = '1') AND (RAM_WR = '1'));
   -- RAM_G_DATA_OUT <= RAM(to_integer(unsigned(RAM_G_DATA))) WHEN ((RAM_CLOCK'event AND RAM_CLOCK = '1') AND (RAM_WR = '1'));
   -- RAM_B_DATA_OUT <= RAM(to_integer(unsigned(RAM_B_DATA))) WHEN ((RAM_CLOCK'event AND RAM_CLOCK = '1') AND (RAM_WR = '1'));
END rtl;