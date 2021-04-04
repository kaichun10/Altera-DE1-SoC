-------------------------------------------------------------------------------
-- Title : Color-Picker
-- Project : Color-Picker Project
-------------------------------------------------------------------------------
-- File : seven_seg.vhd
-- Author : Kaichun Hu
-- Created : 26 ‎March ‎2021
-- Last modified : 04 ‎April ‎2021
-------------------------------------------------------------------------------
-- Description :
-- Decode input RGB 8-bit signal for 7-Segment LED display
-------------------------------------------------------------------------------
-- GitHub : kaichun10
-- Website : www.kaichunhu.com
-------------------------------------------------------------------------------

LIBRARY ieee;
LIBRARY worklib;
USE ieee.std_logic_1164.ALL;

-- seven segment display for viewing the RGB values in 6-digit hexadecimal
ENTITY seven_seg IS
    PORT (
        -- Raw RGB data input to the 7-Seg module
        data_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

        -- 7-Seg LEDs for displaying:
        -- Digit_ones
        seven_seg_0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        -- Digit_sixteens
        seven_seg_1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END seven_seg;

ARCHITECTURE rtl OF seven_seg IS

    -- Intermediate SIGNAL to avoid the use of BUFFER
    SIGNAL digit_ones : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL digit_sixteens : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

    -- Dividing input to SIGNAL
    digit_ones <= data_in (3 DOWNTO 0);
    digit_sixteens <= data_in (7 DOWNTO 4);

    -- 7-Seg decoder for digit ones
    PROCESS (digit_ones)
    BEGIN
        CASE digit_ones IS
            WHEN "0000" =>
                seven_seg_0 <= "1000000"; -- "0" 
            WHEN "0001" =>
                seven_seg_0 <= "1111001"; -- "1" 
            WHEN "0010" =>
                seven_seg_0 <= "0100100"; -- "2" 
            WHEN "0011" =>
                seven_seg_0 <= "0110000"; -- "3" 
            WHEN "0100" =>
                seven_seg_0 <= "0011001"; -- "4" 
            WHEN "0101" =>
                seven_seg_0 <= "0010010"; -- "5" 
            WHEN "0110" =>
                seven_seg_0 <= "0000010"; -- "6" 
            WHEN "0111" =>
                seven_seg_0 <= "1111000"; -- "7" 
            WHEN "1000" =>
                seven_seg_0 <= "0000000"; -- "8"     
            WHEN "1001" =>
                seven_seg_0 <= "0010000"; -- "9" 
            WHEN "1010" =>
                seven_seg_0 <= "0001000"; -- "A"
            WHEN "1011" =>
                seven_seg_0 <= "0000011"; -- "b"
            WHEN "1100" =>
                seven_seg_0 <= "1000110"; -- "C"
            WHEN "1101" =>
                seven_seg_0 <= "0100001"; -- "d"
            WHEN "1110" =>
                seven_seg_0 <= "0000110"; -- "E"
            WHEN "1111" =>
                seven_seg_0 <= "0001110"; -- "F"
        END CASE;
    END PROCESS;

    -- 7-Seg decoder for digit ones
    PROCESS (digit_sixteens)
    BEGIN
        CASE digit_sixteens IS
            WHEN "0000" =>
                seven_seg_1 <= "1000000"; -- "0" 
            WHEN "0001" =>
                seven_seg_1 <= "1111001"; -- "1" 
            WHEN "0010" =>
                seven_seg_1 <= "0100100"; -- "2" 
            WHEN "0011" =>
                seven_seg_1 <= "0110000"; -- "3" 
            WHEN "0100" =>
                seven_seg_1 <= "0011001"; -- "4" 
            WHEN "0101" =>
                seven_seg_1 <= "0010010"; -- "5" 
            WHEN "0110" =>
                seven_seg_1 <= "0000010"; -- "6" 
            WHEN "0111" =>
                seven_seg_1 <= "1111000"; -- "7" 
            WHEN "1000" =>
                seven_seg_1 <= "0000000"; -- "8"     
            WHEN "1001" =>
                seven_seg_1 <= "0010000"; -- "9" 
            WHEN "1010" =>
                seven_seg_1 <= "0001000"; -- "A"
            WHEN "1011" =>
                seven_seg_1 <= "0000011"; -- "b"
            WHEN "1100" =>
                seven_seg_1 <= "1000110"; -- "C"
            WHEN "1101" =>
                seven_seg_1 <= "0100001"; -- "d"
            WHEN "1110" =>
                seven_seg_1 <= "0000110"; -- "E"
            WHEN "1111" =>
                seven_seg_1 <= "0001110"; -- "F"
        END CASE;
    END PROCESS;
END rtl;