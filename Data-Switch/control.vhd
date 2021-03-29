LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY control IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

        enable : OUT STD_LOGIC;

        reqx : OUT STD_LOGIC;
        reqy : OUT STD_LOGIC;
        gntx : IN STD_LOGIC; -----------------
        gnty : IN STD_LOGIC; -----------------

        write : OUT STD_LOGIC;
        available : IN STD_LOGIC -----------------

        ----------------------------------------------------LED_LastBit : OUT STD_LOGIC

    );
END control;

ARCHITECTURE behavior OF control IS

    -- Possible states.

    TYPE states IS (poll_fifo, setupA, setupB, setup_x, setup_y, data_xfer, data_yfer);

    -- Present state.

    SIGNAL present_state : states;

BEGIN

    -- Main process.

    PROCESS (clk, reset)

    BEGIN
        ---write <= '1';-------------------------------------------------------------------------------------------

        -------------------------------------------------------------------LED_LastBit <= data_in(0);
        -- Activities triggered by asynchronous reset (active low).

        IF (reset = '0') THEN

            -- Set the default state and outputs.

            present_state <= poll_fifo;
            enable <= '0';
            reqx <= '0';
            reqy <= '0';
            write <= '0';

        ELSIF (clk'event AND clk = '1') THEN
            -- Set the default state and outputs.

            present_state <= poll_fifo;
            enable <= '0';
            reqx <= '0';
            reqy <= '0';
            write <= '0';

            CASE present_state IS

                WHEN poll_fifo =>

                    IF available = '1' THEN
                        IF (data_in(0) = '1') THEN
                            present_state <= setupA;
                        ELSE
                            present_state <= setupB;
                        END IF;
                    ELSE
                        present_state <= poll_fifo;
                    END IF;

                WHEN setupA =>
                    reqx <= '1';
                    IF (data_in(0) = '1') THEN
                        present_state <= setup_x;
                    ELSE
                        present_state <= poll_fifo;
                    END IF;

                WHEN setupB =>
                    reqy <= '1';
                    IF (data_in(0) = '0') THEN
                        present_state <= setup_y;
                    ELSE
                        present_state <= poll_fifo;
                    END IF;

                WHEN setup_x =>
                    enable <= '1';
                    IF (gntx = '1') THEN
                        present_state <= data_xfer;
                    ELSE
                        present_state <= setup_x;
                    END IF;

                WHEN setup_y =>
                    enable <= '1';
                    IF (gnty = '1') THEN
                        present_state <= data_yfer;
                    ELSE
                        present_state <= setup_y;
                    END IF;

                WHEN data_xfer =>
                    write <= '1';
                    IF (gntx = '1') THEN
                        present_state <= data_xfer;
                    ELSE
                        present_state <= setup_x;
                    END IF;

                WHEN data_yfer =>
                    write <= '1';
                    IF (gnty = '1') THEN
                        present_state <= data_yfer;
                    ELSE
                        present_state <= setup_y;
                    END IF;

                WHEN OTHERS =>
                    present_state <= poll_fifo;
                    enable <= '0';
                    reqx <= '0';
                    reqy <= '0';
                    write <= '0';
            END CASE;

        END IF;

    END PROCESS;

END behavior;