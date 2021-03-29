LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY output IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;

        data_inx : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        data_iny : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

        data_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);

        gntx : OUT STD_LOGIC; -----------------
        gnty : OUT STD_LOGIC; -----------------

        reqx : IN STD_LOGIC;
        reqy : IN STD_LOGIC;
        writex : IN STD_LOGIC;
        writey : IN STD_LOGIC;

        LED_Writex : OUT STD_LOGIC;
        ---------------------------------------------LED_Testing : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        LED_reqx : OUT STD_LOGIC;

        LED_gntx : OUT STD_LOGIC

    );
END output;

ARCHITECTURE behavior OF output IS

    -- Possible states.

    TYPE states IS (poll_x, poll_y, grant_x, grant_y);

    -- Present state.

    SIGNAL present_state : states;
    -------------------------------------------------------
    -------------------------------------------------------
    -------------------------------------------------------
    SIGNAL Signal_LED_data_out : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Signal_gntx : STD_LOGIC;
    SIGNAL Signal_gnty : STD_LOGIC;

    -------------------------------------------------------
    -------------------------------------------------------
    -------------------------------------------------------
BEGIN
    --LED_Testing <= data_inx;
    LED_Writex <= writex;
    LED_reqx <= reqx;
    LED_gntx <= Signal_gntx;

    -- Main process.

    PROCESS (clk, reset)

    BEGIN

        -- Activities triggered by asynchronous reset (active low).

        IF (reset = '0') THEN

            -- Set the default state and outputs.

            present_state <= poll_x;
            gntx <= '0';
            gnty <= '0';
            data_out <= "0000";

        ELSIF (clk'event AND clk = '1') THEN

            -- Set the default state and outputs.

            present_state <= poll_x;
            gntx <= '0';
            gnty <= '0';
            data_out <= "0000";

            CASE present_state IS

                WHEN poll_x =>

                    IF (reqx = '1') THEN
                        present_state <= grant_x;
                    ELSE
                        present_state <= poll_y;
                    END IF;

                WHEN poll_y =>

                    IF (reqy = '1') THEN
                        present_state <= grant_y;
                    ELSE
                        present_state <= poll_x;
                    END IF;

                WHEN grant_x =>

                    IF (writex = '1') THEN
                        data_out <= data_inx;
                        -------------------------Signal_LED_data_out <= data_inx;
                    END IF;

                    IF (reqx = '1') THEN
                        present_state <= grant_x;
                    ELSE
                        present_state <= poll_y;
                    END IF;

                    gntx <= '1';
                    Signal_gntx <='1';

                WHEN grant_y =>

                    IF (writey = '1') THEN
                        data_out <= data_iny;
                        -------------------------Signal_LED_data_out <= data_iny;

                    END IF;

                    IF (reqy = '1') THEN
                        present_state <= grant_y;
                    ELSE
                        present_state <= poll_x;
                    END IF;

                    gnty <= '1';
                    Signal_gnty <='1';

                WHEN OTHERS =>

                    -- Set the default state and outputs.

                    present_state <= poll_x;
                    gntx <= '0';
                    gnty <= '0';
                    data_out <= "0000";

            END CASE;

        END IF;

    END PROCESS;

END behavior;