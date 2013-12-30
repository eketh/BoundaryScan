
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity JTAGTop is
port(
TDI: in std_logic;
TMS: in std_logic;
TCK: in std_logic;
TDO: out std_logic;
reset: in std_logic
);
end JATGTop;

architecture Top_a of JTAGTop is

--TAP.vhd - Test Access Port
component TAP is
port(
  TMS      : in std_logic;
  TCK      : in std_logic;
  TRST     : in std_logic;
  CLOCKIR  : out std_logic;
  UPDATEIR : out std_logic;
  SHIFTIR  : out std_logic;
  TRESET   : out std_logic;
  TSELECT  : out std_logic;
  ENABLE   : out std_logic;
  SHIFTDR  : out std_logic;
  UPDATEDR : out std_logic;
  CLOCKDR  : out std_logic;
--optional auxiliary signals: capture state (no idea how to substitute it)
  CAPTUREDR: out std_logic;
  CAPTUREIR: out std_logic
);
end component;

component JTAGIDRegister is
port(
  TDI      : in std_logic;
  TDO      : out std_logic;
  TRST     : in std_logic;
  TCK      : in std_logic;
  SHIFTIR  : in std_logic;
  CLOCKIR  : in std_logic;
  UPDATEIR : in std_logic;
  TRESET   : in std_logic; 
  SHIFTDR  : in std_logic;
  CLOCKDR  : in std_logic;
  UPDATEDR : in std_logic;
--optional auxiliary signals: capture state
  CAPTUREDR: in std_logic;
  CAPTUREIR: in std_logic
);
end component;

signal sTDI, sTDO, sTMS, sTCK, TRST, CLOCKIR, UPDATEIR, SHIFTIR, TRESET, TSELECT, ENABLE, SHIFTDR, UPDATEDR, CLOCKDR, CAPTUREDR, CAPTUREIR: std_logic;

begin

bscanTAP: TAP port map (TMS=>sTMS, TCK=>sTCK, TRST=>TRST, CLOCKIR=>CLOCKIR, UPDATEIR => UPDATEIR, SHIFTIR =>SHIFTIR,TRESET=>TRESET, TSELECT=>TSELECT, ENABLE=>ENABLE, SHIFTDR=>SHIFTDR, UPDATEDR=>UPDATEDR, CLOCKDR=> CLOCKDR, CAPTUREDR=>CAPTUREDR, CAPTUREIR=>CAPTUREIR);

bsid: JTAGIDRegister port map (TDI=>sTDI, TCK=>sTCK, TDO=>sTDO, TRST=>TRST, SHIFTIR=>SHIFTIR, CLOCKIR=>CLOCKIR, UPDATEIR=>UPDATEIR, TRESET=> TRESET, SHIFTDR=>SHIFTDR, CLOCKDR=>CLOCKDR, UPDATEDR=>UPDATEDR, CAPTUREDR=>CAPTUREDR, CAPTUREIR=>CAPTUREIR);

--mapping TAP ports
sTDI<=TDI;
TDO<=sTDO;
sTMS<=TMS;
sTCK<=TCK;
TRST<=reset;

end Top_a;
