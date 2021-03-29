LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; -- for internal counter etc.

ENTITY stim_xbar IS
  PORT (
    top_clock : IN STD_LOGIC;
    top_reset : IN STD_LOGIC;
    x_input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    y_input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    x_avail : IN STD_LOGIC;
    y_avail : IN STD_LOGIC;

    clk : OUT STD_LOGIC;
    r_n : OUT STD_LOGIC;
    stim_xdata : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    stim_ydata : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);

    stim_xavail : OUT STD_LOGIC;
    stim_yavail : OUT STD_LOGIC;

    LED_clk : OUT STD_LOGIC;
    LED_enable : OUT STD_LOGIC;
    stim_xenable : IN STD_LOGIC;
    stim_yenable : IN STD_LOGIC
  );
END stim_xbar;

ARCHITECTURE behavior OF stim_xbar IS

  CONSTANT c_CNT_10HZ : NATURAL := 2500000;
  SIGNAL r_CNT_10HZ : NATURAL RANGE 0 TO c_CNT_10HZ;
  SIGNAL r_TOGGLE_10HZ : STD_LOGIC := '0';

BEGIN -- behavior

  p_10_HZ : PROCESS (top_clock) IS
  BEGIN
    IF rising_edge(top_clock) THEN
      IF r_CNT_10HZ = c_CNT_10HZ - 1 THEN -- -1, since counter starts at 0
        r_TOGGLE_10HZ <= NOT r_TOGGLE_10HZ;
        r_CNT_10HZ <= 0;
      ELSE
        r_CNT_10HZ <= r_CNT_10HZ + 1;
      END IF;
    END IF;
  END PROCESS p_10_HZ;

  stim_xavail <= x_avail; -- requests transfer, and flag back down
  stim_yavail <= y_avail; -- requests transfer, and flag back down
  stim_xdata(3 DOWNTO 0) <= x_input(3 DOWNTO 0) WHEN (stim_xenable = '1');-- header word pushed when system
  stim_ydata(3 DOWNTO 0) <= y_input(3 DOWNTO 0) WHEN (stim_yenable = '1');

  clk <= r_TOGGLE_10HZ;
  r_n <= top_reset;
  LED_enable <= stim_xenable;
  LED_clk <= r_TOGGLE_10HZ;

END behavior;