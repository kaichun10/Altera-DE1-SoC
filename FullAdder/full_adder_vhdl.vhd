LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY full_adder_sch IS 
    PORT
    (
        a :  IN  STD_LOGIC;
        b :  IN  STD_LOGIC;
        c :  IN  STD_LOGIC;
        sum :  OUT  STD_LOGIC;
        carry :  OUT  STD_LOGIC
    );
END full_adder_sch;

ARCHITECTURE bdf_type OF full_adder_sch IS 

COMPONENT half_adder_vhdl
    PORT(a : IN STD_LOGIC;
         b : IN STD_LOGIC;
         sum : OUT STD_LOGIC;
         carry : OUT STD_LOGIC
    );
END COMPONENT;

SIGNAL  SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL  SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL  SYNTHESIZED_WIRE_2 :  STD_LOGIC;


BEGIN 



b2v_inst : half_adder_vhdl
PORT MAP(a => a,
         b => b,
         sum => SYNTHESIZED_WIRE_0,
         carry => SYNTHESIZED_WIRE_1);


b2v_inst1 : half_adder_vhdl
PORT MAP(a => c,
         b => SYNTHESIZED_WIRE_0,
         sum => sum,
         carry => SYNTHESIZED_WIRE_2);


carry <= SYNTHESIZED_WIRE_1 OR SYNTHESIZED_WIRE_2;


END bdf_type;
