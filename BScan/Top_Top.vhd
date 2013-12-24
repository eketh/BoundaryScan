----------------------------------------------------------------------------------
-- TOP module:
-- Connected TAPs of both JTAG and Cortex-M4
-- (JTAGTop and CortexTop)
-- (c) Natalia Pyka, 17 XI 2013
-- In both cases, TAP modules are the same. What differs are the instruction/data registers!!!
--
--
-- OPEN ISSUES TO BE DISCUSSED WITH DR BUDZYN:
--
-- * Should I make generics and somehow "in-generificate" instruction codes?
-- TROUBLE: you cannot make a generic std_logic_vector with width dependent of other generic :(
-- * Or should there be an extra array passing these codes to all the modules?
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_Top is
port(
TDI: in std_logic;
TMS: in std_logic;
TCK: in std_logic;
TDO: out std_logic;
reset: in std_logic
);
end Top;

architecture Top_Top_a of Top_Top is

component  CortexTop is
port(
TDI: in std_logic;
TMS: in std_logic;
TCK: in std_logic;
TDO: out std_logic;
reset: in std_logic
);
end component;

component JTAGTop is
port(
TDI: in std_logic;
TMS: in std_logic;
TCK: in std_logic;
TDO: out std_logic;
reset: in std_logic
);
end component;

signal sTDO_jtag, sTDI, sTDO, sTCK, sTMS, sreset: std_logic;

begin

Top_bscan: JTAGTop port map ( TDI=>sTDI, TMS=>sTMS, TCK=>sTCK, TDO=>sTDO_jtag, reset=>sreset);
Top_cortex: CortexTop port map ( TDI=>sTDO_jtag, TMS=>sTMS, TCK=>sTCK, TDO=>sTDO, reset=>sreset);

TDO<=sTDO;
sTDI<=TDI;
sTMS<=TMS;
sreset<=reset;
sTCK<=TCK;

-- optional: TCK as clk with prescaler (so that it would work slowly enough to see it on a scope).
-- to be considered in further design

end Top_Top_a;

