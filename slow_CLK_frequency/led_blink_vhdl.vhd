library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity led_blink_vhdl is
  port (
    i_clock      : in  std_logic;
    i_enable     : in  std_logic;
    i_switch_1   : in  std_logic;
    i_switch_10   : in  std_logic;
	 i_switch_20   : in  std_logic;
    i_switch_30   : in  std_logic;
	 i_switch_40   : in  std_logic;
    i_switch_50   : in  std_logic;
    o_led_drive  : out std_logic;
	 seg1: out std_logic_vector(6 downto 0);
	 seg2: out std_logic_vector(6 downto 0)
    );
end led_blink_vhdl;
 
architecture rtl of led_blink_vhdl is
 
  -- Constants to create the frequencies needed:
  -- Formula is: (25 MHz / 100 Hz * 50% duty cycle)
  -- So for 100 Hz: 25,000,000 / 100 * 0.5 = 125,000
  
  -- DE1 Soc CLOCK_50 PIN_AF14 50 MHz clock input 3.3V
  -- Formula: ( 50MHZ / 100Hz ) * 50% duty cycle
  -- 1Hz 
  constant c_CNT_50HZ  : natural := 	500000;
  constant c_CNT_40HZ  : natural := 	625000;
  constant c_CNT_30HZ  : natural := 	833333; --(833333.333 Q: how to round up?)
  constant c_CNT_20HZ  : natural :=		1250000;
  constant c_CNT_10HZ  : natural :=		2500000;
  constant c_CNT_1HZ   : natural :=		25000000;
 
 
  -- These signals will be the counters:
  signal r_CNT_50HZ  : natural range 0 to c_CNT_50HZ;
  signal r_CNT_40HZ  : natural range 0 to c_CNT_40HZ;
  signal r_CNT_30HZ  : natural range 0 to c_CNT_30HZ;
  signal r_CNT_20HZ  : natural range 0 to c_CNT_20HZ;
  signal r_CNT_10HZ  : natural range 0 to c_CNT_10HZ;
  signal r_CNT_1HZ   : natural range 0 to c_CNT_1HZ;
   
  -- These signals will toggle at the frequencies needed:
  signal r_TOGGLE_50HZ  : std_logic := '0';
  signal r_TOGGLE_40HZ  : std_logic := '0';
  signal r_TOGGLE_30HZ  : std_logic := '0';
  signal r_TOGGLE_20HZ  : std_logic := '0';
  signal r_TOGGLE_10HZ  : std_logic := '0';
  signal r_TOGGLE_1HZ   : std_logic := '0';
  signal r_TOGGLE_0HZ   : std_logic := '0';
  
  
  signal select_seg1: unsigned(6 downto 0):= "0000000";
  signal select_seg2: unsigned(6 downto 0):= "0000000";
 
  -- One bit select wire.
  signal w_LED_SELECT : std_logic;
   
begin
 
  -- All processes toggle a specific signal at a different frequency.
  -- They all run continuously even if the switches are
  -- not selecting their particular output.
 
  
   p_50_HZ : process (i_clock) is
  begin
    if rising_edge(i_clock) then
      if r_CNT_50HZ = c_CNT_50HZ-1 then  -- -1, since counter starts at 0
        r_TOGGLE_50HZ <= not r_TOGGLE_50HZ;
        r_CNT_50HZ    <= 0;
      else
        r_CNT_50HZ <= r_CNT_50HZ + 1;
      end if;
    end if;
  end process p_50_HZ;
 
  p_40_HZ : process (i_clock) is
  begin
    if rising_edge(i_clock) then
      if r_CNT_40HZ = c_CNT_40HZ-1 then  -- -1, since counter starts at 0
        r_TOGGLE_40HZ <= not r_TOGGLE_40HZ;
        r_CNT_40HZ    <= 0;
      else
        r_CNT_40HZ <= r_CNT_40HZ + 1;
      end if;
    end if;
  end process p_40_HZ;
 
  p_30_HZ : process (i_clock) is
  begin
    if rising_edge(i_clock) then
      if r_CNT_30HZ = c_CNT_30HZ-1 then  -- -1, since counter starts at 0
        r_TOGGLE_30HZ <= not r_TOGGLE_30HZ;
        r_CNT_30HZ    <= 0;
      else
        r_CNT_30HZ <= r_CNT_30HZ + 1;
      end if;
    end if;
  end process p_30_HZ;
  
  p_20_HZ : process (i_clock) is
  begin
    if rising_edge(i_clock) then
      if r_CNT_20HZ = c_CNT_20HZ-1 then  -- -1, since counter starts at 0
        r_TOGGLE_20HZ <= not r_TOGGLE_20HZ;
        r_CNT_20HZ    <= 0;
      else
        r_CNT_20HZ <= r_CNT_20HZ + 1;
      end if;
    end if;
  end process p_20_HZ;
  
  p_10_HZ : process (i_clock) is
  begin
    if rising_edge(i_clock) then
      if r_CNT_10HZ = c_CNT_10HZ-1 then  -- -1, since counter starts at 0
        r_TOGGLE_10HZ <= not r_TOGGLE_10HZ;
        r_CNT_10HZ    <= 0;
      else
        r_CNT_10HZ <= r_CNT_10HZ + 1;
      end if;
    end if;
  end process p_10_HZ;
 
 
   
  p_1_HZ : process (i_clock) is
  begin
    if rising_edge(i_clock) then
      if r_CNT_1HZ = c_CNT_1HZ-1 then  -- -1, since counter starts at 0
        r_TOGGLE_1HZ <= not r_TOGGLE_1HZ;
        r_CNT_1HZ    <= 0;
      else
        r_CNT_1HZ <= r_CNT_1HZ + 1;
      end if;
    end if;
  end process p_1_HZ;
  
  
 
   
  -- Create a multiplexor based on switch inputs
  w_LED_SELECT <= r_TOGGLE_50HZ  when (i_switch_1 = '0' and i_switch_10 = '0' and i_switch_20 = '0' and i_switch_30 = '0' and i_switch_40 = '0' and i_switch_50 = '1') else
						r_TOGGLE_40HZ  when (i_switch_1 = '0' and i_switch_10 = '0' and i_switch_20 = '0' and i_switch_30 = '0' and i_switch_40 = '1' and i_switch_50 = '0') else
						r_TOGGLE_30HZ  when (i_switch_1 = '0' and i_switch_10 = '0' and i_switch_20 = '0' and i_switch_30 = '1' and i_switch_40 = '0' and i_switch_50 = '0') else
						r_TOGGLE_20HZ  when (i_switch_1 = '0' and i_switch_10 = '0' and i_switch_20 = '1' and i_switch_30 = '0' and i_switch_40 = '0' and i_switch_50 = '0') else
						r_TOGGLE_10HZ  when (i_switch_1 = '0' and i_switch_10 = '1' and i_switch_20 = '0' and i_switch_30 = '0' and i_switch_40 = '0' and i_switch_50 = '0') else
                  r_TOGGLE_1HZ   when (i_switch_1 = '1' and i_switch_10 = '0' and i_switch_20 = '0' and i_switch_30 = '0' and i_switch_40 = '0' and i_switch_50 = '0') else
						r_TOGGLE_0HZ;
 
   
  -- Only allow o_led_drive to drive when i_enable is high (and gate).
  -- Q: how to check high / low triggering
  o_led_drive <= w_LED_SELECT and i_enable;
  
  select_seg1 <= 	"1000000" when (i_switch_1 = '0' or i_switch_10 = '1' or i_switch_20 = '1' or i_switch_30 = '1' or i_switch_40 = '1' or i_switch_50 = '1') else
						"1111001" when (i_switch_1 = '1') else
						"1111111";
								
  seg1(6 downto 0) <= std_logic_vector(select_seg1) when (i_enable = '1') else
  "1111111";
  
  select_seg2 <= "0010010" when (i_switch_1 = '0' and i_switch_10 = '0' and i_switch_20 = '0' and i_switch_30 = '0' and i_switch_40 = '0' and i_switch_50 = '1') else
							 "0011001" when (i_switch_1 = '0' and i_switch_10 = '0' and i_switch_20 = '0' and i_switch_30 = '0' and i_switch_40 = '1' and i_switch_50 = '0') else
							 "0110000" when (i_switch_1 = '0' and i_switch_10 = '0' and i_switch_20 = '0' and i_switch_30 = '1' and i_switch_40 = '0' and i_switch_50 = '0') else
							 "0100100" when (i_switch_1 = '0' and i_switch_10 = '0' and i_switch_20 = '1' and i_switch_30 = '0' and i_switch_40 = '0' and i_switch_50 = '0') else
							 "1111001" when (i_switch_1 = '0' and i_switch_10 = '1' and i_switch_20 = '0' and i_switch_30 = '0' and i_switch_40 = '0' and i_switch_50 = '0') else
							 "1111111";
  seg2(6 downto 0) <= std_logic_vector(select_seg2) when (i_enable = '1') else
  "1111111";
  
end rtl;