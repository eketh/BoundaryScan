
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--***************************************************************************************************************************************************************************************************
-- 28 XII 2013, 18:00
-- uwaga co do koncowej aplikacji: zrobic nastepujace stany: wysylanie sekwencji do przejscia w SHIFTIR, przesylanie danych w czasie SHIFTIR, przejscie do SHIFTDR, bycie w stanie SHIFTDR.
-- mozna dodac tam stany posrednie, ale te beda najwazniejsze (pozwalaja na hardkodowanie sekwencji TDI dla SHIFTIR i SHIFTDR, podczas gdy w innych stanach wysylana jest caly czas ta sama sekwencja,
-- to jest kod dla TMS oznaczajacy przejscie do innego stanu TAPa.
-- w skrocie: stan to_SHIFTIR (stala sekwencja @ TMS), SHIFTIR (dana sekwencja TDI o dowolnej dlugosci), to_SHIFTDR (stala sekwencja @ TMS), SHIFTDR (ponownie TDI j/w), to_work (do RunTestIdle), work.
-- na przyklad.
--***************************************************************************************************************************************************************************************************

entity JTAGTop is
port(
TDI: in std_logic;
NDI: in std_logic;
TMS: in std_logic;
TCK: in std_logic;
MODE : in std_logic;
TDO: out std_logic;
NDO: out std_logic;
reset: in std_logic
);
end JTAGTop;

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

--****************************************************************************************************************************
component bscell is
port(
  reset			:		in  std_logic;
  TDI				: 	   in  std_logic;
  NDI				:    	in  std_logic;
  CLOCKDR		:  	in  std_logic;
  MODE			: 		in  std_logic;
  SHIFTDR      :     in  std_logic;
  UPDATEDR		:	   in  std_logic;
  TDO				:	   out std_logic;
  NDO				:	   out std_logic
);
end component;
--****************************************************************************************************************************

signal sMODE, sNDI, sTDI, sTMS, sTCK, TRST, CLOCKIR, UPDATEIR, SHIFTIR, TRESET, TSELECT, ENABLE, sSHIFTDR, sUPDATEDR, sCLOCKDR, CAPTUREDR, CAPTUREIR: std_logic;
signal sTDO: std_logic_vector(4 downto 0);
signal sNDO: std_logic_vector (3 downto 0);

begin

bscanTAP: TAP port map (TMS=>sTMS, TCK=>sTCK, TRST=>TRST, CLOCKIR=>CLOCKIR, UPDATEIR => UPDATEIR, SHIFTIR =>SHIFTIR,TRESET=>TRESET, TSELECT=>TSELECT, ENABLE=>ENABLE, SHIFTDR=>sSHIFTDR, UPDATEDR=>sUPDATEDR, CLOCKDR=>sCLOCKDR, CAPTUREDR=>CAPTUREDR, CAPTUREIR=>CAPTUREIR);
bsid: JTAGIDRegister port map (TDI=>sTDI, TCK=>sTCK, TDO=>sTDO(0), TRST=>TRST, SHIFTIR=>SHIFTIR, CLOCKIR=>CLOCKIR, UPDATEIR=>UPDATEIR, TRESET=> TRESET, SHIFTDR=>sSHIFTDR, CLOCKDR=>sCLOCKDR, UPDATEDR=>sUPDATEDR, CAPTUREDR=>CAPTUREDR, CAPTUREIR=>CAPTUREIR);

-- boundary scan cells:
bsc_one:bscell port map (reset=>TRST, TDI=>sTDO(0), NDI=>sNDI, SHIFTDR=>sSHIFTDR, CLOCKDR=>sCLOCKDR, MODE=>sMODE, UPDATEDR=>sUPDATEDR, TDO=>sTDO(1), NDO=>sNDO(0));
bsc_two:bscell port map (reset=>TRST, TDI=>sTDO(1), NDI=>sNDO(0), SHIFTDR=>sSHIFTDR, CLOCKDR=>sCLOCKDR, MODE=>sMODE, UPDATEDR=>sUPDATEDR, TDO=>sTDO(2), NDO=>sNDO(1));
bsc_three: bscell port map(reset=>TRST, TDI=>sTDO(2), NDI=>sNDO(1), SHIFTDR=>sSHIFTDR, CLOCKDR=>sCLOCKDR, MODE=>sMODE, UPDATEDR=>sUPDATEDR, TDO=>sTDO(3), NDO=>sNDO(2));
bsc_four: bscell port map (reset=>TRST, TDI=>sTDO(3), NDI=>sNDO(2), SHIFTDR=>sSHIFTDR, CLOCKDR=>sCLOCKDR, MODE=>sMODE, UPDATEDR=>sUPDATEDR, TDO=>sTDO(4), NDO=>sNDO(3));
--mapping TAP ports
sTDI<=TDI;
TDO<=sTDO(4);
sTMS<=TMS;
sTCK<=TCK;
TRST<=reset;
sMODE<=MODE;
end Top_a;
