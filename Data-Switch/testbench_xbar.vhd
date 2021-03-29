LIBRARY ieee;
LIBRARY worklib;
USE ieee.std_logic_1164.ALL;

ENTITY testbench_xbar IS
    PORT (
        LED_X1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        LED_X0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        LED_Y1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        LED_Y0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);

        top_LED_clk : OUT STD_LOGIC;
        top_LED_enable : OUT STD_LOGIC;

        switch_x_input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        switch_y_input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);


        ---------------------------------------------------------LED_LastBit_X : OUT STD_LOGIC;
        ---------------------------------------------------------LED_LastBit_Y : OUT STD_LOGIC;

        LED_Writex : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);

        LED_reqx_x : OUT STD_LOGIC;
        LED_reqx_y : OUT STD_LOGIC;

        LED_gntx_x : OUT STD_LOGIC;
        LED_gntx_y : OUT STD_LOGIC;

        --------------------------------------------LED_dataout : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        -----------------------LED_Testing : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);

        switch_x_avail : IN STD_LOGIC;
        switch_y_avail : IN STD_LOGIC;
        toplevel_clock : IN STD_LOGIC;
        top_reset : IN STD_LOGIC
    );
END testbench_xbar;

ARCHITECTURE schematic OF testbench_xbar IS

    COMPONENT stim_xbar
        PORT (
            top_clock : IN STD_LOGIC;
            top_reset : IN STD_LOGIC;
            x_input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            y_input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            x_avail : IN STD_LOGIC;
            y_avail : IN STD_LOGIC;
            LED_clk : OUT STD_LOGIC;
            LED_enable : OUT STD_LOGIC;
            clk : OUT STD_LOGIC;
            r_n : OUT STD_LOGIC;

            stim_xavail : OUT STD_LOGIC;
            stim_xdata : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            stim_yavail : OUT STD_LOGIC;
            stim_ydata : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            stim_xenable : IN STD_LOGIC;
            stim_yenable : IN STD_LOGIC
        );
    END COMPONENT;

    COMPONENT control
        PORT (
            enable : OUT STD_LOGIC;
            reqx : OUT STD_LOGIC;
            reqy : OUT STD_LOGIC;
            write : OUT STD_LOGIC;
            available : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            data_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            gntx : IN STD_LOGIC;
            gnty : IN STD_LOGIC;
            reset : IN STD_LOGIC
            ------------------------------------LED_LastBit : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT output
        PORT (
            data_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            gntx : OUT STD_LOGIC;
            gnty : OUT STD_LOGIC;
            clk : IN STD_LOGIC;
            data_inx : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            data_iny : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            reqx : IN STD_LOGIC;
            reqy : IN STD_LOGIC;
            reset : IN STD_LOGIC;

            LED_Writex : OUT STD_LOGIC;
            LED_reqx : OUT STD_LOGIC;

            LED_gntx : OUT STD_LOGIC;


            ----------------------------------------LED_data_out : OUT STD_LOGIC;
            --LED_Testing : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            writex : IN STD_LOGIC;
            writey : IN STD_LOGIC
        );
    END COMPONENT;

    SIGNAL x_gntx : STD_LOGIC;
    SIGNAL reset : STD_LOGIC;
    SIGNAL y_reqx : STD_LOGIC;
    SIGNAL y_reqy : STD_LOGIC;
    SIGNAL clock : STD_LOGIC;
    SIGNAL ywrite : STD_LOGIC;
    SIGNAL y_gnty : STD_LOGIC;
    SIGNAL y_gntx : STD_LOGIC;
    SIGNAL yavail : STD_LOGIC;
    SIGNAL xenable : STD_LOGIC;
    SIGNAL xdata : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL x_reqx : STD_LOGIC;
    SIGNAL x_reqy : STD_LOGIC;
    SIGNAL xwrite : STD_LOGIC;
    SIGNAL ydata : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL dataoutx : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL dataouty : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL xavail : STD_LOGIC;
    SIGNAL yenable : STD_LOGIC;
    SIGNAL x_gnty : STD_LOGIC;
    -----------------------------SIGNAL top_reset_active : STD_LOGIC;

    --SIGNAL data_outx : STD_LOGIC_VECTOR(3 DOWNTO 0);
    --SIGNAL data_outy : STD_LOGIC_VECTOR(3 DOWNTO 0);

    --FOR ALL : stim_xbar USE ENTITY worklib.stim_xbar(behavior);
    --FOR ALL : control USE ENTITY worklib.control(behavior);
    --FOR ALL : output USE ENTITY worklib.output(behavior);
BEGIN
    ------------------------------top_reset_active <= NOT top_reset_bar;
    -----------------------------------------------------LED_Testing <= dataoutx;
    U1 : stim_xbar
    PORT MAP(
        top_clock => toplevel_clock,
        top_reset => top_reset,
        x_input => switch_x_input,
        y_input => switch_y_input,
        x_avail => switch_x_avail,
        y_avail => switch_y_avail,
        clk => clock,
        LED_clk => top_LED_clk,
        LED_enable => top_LED_enable,

        r_n => reset,
        stim_xavail => xavail,
        stim_xdata(3 DOWNTO 0) => xdata(3 DOWNTO 0),
        stim_yavail => yavail,
        stim_ydata(3 DOWNTO 0) => ydata(3 DOWNTO 0),
        stim_xenable => xenable,
        stim_yenable => yenable
    );

    U2 : control
    PORT MAP(
        enable => yenable,
        reqx => y_reqx,
        reqy => y_reqy,
        write => ywrite,
        available => yavail,
        clk => clock,
        data_in(3 DOWNTO 0) => ydata(3 DOWNTO 0),
        gntx => y_gntx,
        ----------------------------------------LED_LastBit => LED_LastBit_Y,
        gnty => y_gnty,
        reset => reset
    );

    U3 : control
    PORT MAP(
        enable => xenable,
        reqx => x_reqx,
        reqy => x_reqy,
        write => xwrite,
        available => xavail,
        clk => clock,
        data_in(3 DOWNTO 0) => xdata(3 DOWNTO 0),
        gntx => x_gntx,
        gnty => x_gnty,
        --------------------------------------LED_LastBit => LED_LastBit_X,
        reset => reset
    );

    U4 : output
    PORT MAP(
        data_out(3 DOWNTO 0) => dataouty(3 DOWNTO 0),
        gntx => x_gnty,
        gnty => y_gnty,
        clk => clock,
        data_inx(3 DOWNTO 0) => xdata(3 DOWNTO 0),
        data_iny(3 DOWNTO 0) => ydata(3 DOWNTO 0),
        reqx => x_reqy,

        reqy => y_reqy,
        reset => reset,

        LED_Writex => LED_Writex(0),
        LED_reqx => LED_reqx_y,

        LED_gntx =>LED_gntx_y,

        -------------------------------------------LED_data_out => LED_dataout(0),
        --LED_Testing => LED_Testing,
        writex => xwrite,
        writey => ywrite
    );

    U5 : output
    PORT MAP(
        data_out(3 DOWNTO 0) => dataoutx(3 DOWNTO 0),
        gntx => x_gntx,
        gnty => y_gntx,
        clk => clock,
        data_inx(3 DOWNTO 0) => xdata(3 DOWNTO 0),
        data_iny(3 DOWNTO 0) => ydata(3 DOWNTO 0),
        reqx => x_reqx,
        reqy => y_reqx,
        LED_Writex => LED_Writex(1),
        LED_reqx => LED_reqx_x,

        LED_gntx =>LED_gntx_x,

        ----------------------------------------------------------LED_data_out => LED_dataout(1),
        reset => reset,
        writex => xwrite,
        writey => ywrite
    );

    PROCESS (dataoutx)
    BEGIN
        CASE dataoutx IS
            WHEN "0000" =>
                LED_X1 <= "1000000";
                LED_X0 <= "1000000"; -- "0" 
            WHEN "0001" =>
                LED_X1 <= "1000000";
                LED_X0 <= "1111001"; -- "1" 
            WHEN "0010" =>
                LED_X1 <= "1000000";
                LED_X0 <= "0100100"; -- "2" 
            WHEN "0011" =>
                LED_X1 <= "1000000";
                LED_X0 <= "0110000"; -- "3" 
            WHEN "0100" =>
                LED_X1 <= "1000000";
                LED_X0 <= "0011001"; -- "4" 
            WHEN "0101" =>
                LED_X1 <= "1000000";
                LED_X0 <= "0010010"; -- "5" 
            WHEN "0110" =>
                LED_X1 <= "1000000";
                LED_X0 <= "0000010"; -- "6" 
            WHEN "0111" =>
                LED_X1 <= "1000000";
                LED_X0 <= "1111000"; -- "7" 
            WHEN "1000" =>
                LED_X1 <= "1000000";
                LED_X0 <= "0000000"; -- "8"     
            WHEN "1001" =>
                LED_X1 <= "1000000";
                LED_X0 <= "0010000"; -- "9" 
            WHEN "1010" =>
                LED_X1 <= "1111001";
                LED_X0 <= "1000000"; -- a
            WHEN "1011" =>
                LED_X1 <= "1111001";
                LED_X0 <= "1111001"; -- b
            WHEN "1100" =>
                LED_X1 <= "1111001";
                LED_X0 <= "0100100"; -- C
            WHEN "1101" =>
                LED_X1 <= "1111001";
                LED_X0 <= "0110000"; -- d
            WHEN "1110" =>
                LED_X1 <= "1111001";
                LED_X0 <= "0011001"; -- E
            WHEN "1111" =>
                LED_X1 <= "1111001";
                LED_X0 <= "0010010"; -- F
        END CASE;
    END PROCESS;
    PROCESS (dataouty)
    BEGIN
        CASE dataouty IS
            WHEN "0000" =>
                LED_Y1 <= "1000000";
                LED_Y0 <= "1000000"; -- "0" 
            WHEN "0001" =>
                LED_Y1 <= "1000000";
                LED_Y0 <= "1111001"; -- "1" 
            WHEN "0010" =>
                LED_Y1 <= "1000000";
                LED_Y0 <= "0100100"; -- "2" 
            WHEN "0011" =>
                LED_Y1 <= "1000000";
                LED_Y0 <= "0110000"; -- "3" 
            WHEN "0100" =>
                LED_Y1 <= "1000000";
                LED_Y0 <= "0011001"; -- "4" 
            WHEN "0101" =>
                LED_Y1 <= "1000000";
                LED_Y0 <= "0010010"; -- "5" 
            WHEN "0110" =>
                LED_Y1 <= "1000000";
                LED_Y0 <= "0000010"; -- "6" 
            WHEN "0111" =>
                LED_Y1 <= "1000000";
                LED_Y0 <= "1111000"; -- "7" 
            WHEN "1000" =>
                LED_Y1 <= "1000000";
                LED_Y0 <= "0000000"; -- "8"     
            WHEN "1001" =>
                LED_Y1 <= "1000000";
                LED_Y0 <= "0010000"; -- "9" 
            WHEN "1010" =>
                LED_Y1 <= "1111001";
                LED_Y0 <= "1000000"; -- a
            WHEN "1011" =>
                LED_Y1 <= "1111001";
                LED_Y0 <= "1111001"; -- b
            WHEN "1100" =>
                LED_Y1 <= "1111001";
                LED_Y0 <= "0100100"; -- C
            WHEN "1101" =>
                LED_Y1 <= "1111001";
                LED_Y0 <= "0110000"; -- d
            WHEN "1110" =>
                LED_Y1 <= "1111001";
                LED_Y0 <= "0011001"; -- E
            WHEN "1111" =>
                LED_Y1 <= "1111001";
                LED_Y0 <= "0010010"; -- F
        END CASE;
    END PROCESS;

END schematic;