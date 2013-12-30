LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY JTAGTop_tb IS
END JTAGTop_tb;

ARCHITECTURE JTAGTop_tb_a OF JTAGTop_tb IS 

component JTAGTop is
port(
TDI: in std_logic;
NDI: in std_logic;
TMS: in std_logic;
MODE: in std_logic;
TCK: in std_logic;
TDO: out std_logic;
NDO: out std_logic;
reset: in std_logic
);
end component;
          
signal sTDI,sNDI,sTMS,sTCK,sTDO,sNDO,sMODE,sreset : std_logic;
BEGIN

scantest: JTAGTop port map (TDI=>sTDI, NDI=>sNDI, TMS=>sTMS, MODE=>sMODE, TCK=>sTCK, TDO=>sTDO, NDO=>sNDO, reset=>sreset);

clock: process
begin
  sTCK<='1';
  wait for 5 ps;
  sTCK<='0';
  wait for 5 ps;
end process clock;


tb: process
begin
  sMODE<='1';
  sNDI<='Z';
  sTDI<='0';
  sreset<='0';
  sTMS<='1';
wait for 10 ps;
  sreset<='1';
  sTMS<='0';
wait for 10 ps;
  sTMS<='1';
wait for 20 ps;
  sTMS<='0';  
--tutaj jestesmy w stanie SHIFTIR
  sTDI<='1';
wait for 10 ps;
  sTDI<='0';
wait for 10 ps;
  sTDI<='1';
wait for 10 ps;
  sTDI<='0';
wait for 10 ps;
-- wyjscie ze stanu wczytywania
  sTMS<='1';
wait for 20 ps;
  sTMS<='0';
wait for 40 ps;
assert false severity failure;

end process tb;


END JTAGTop_tb_a;

-- uwaga co do koncowej aplikacji: zrobic nastepujace stany: wysylanie sekwencji do przejscia w SHIFTIR, przesylanie danych w czasie SHIFTIR, przejscie do SHIFTDR, bycie w stanie SHIFTDR.
-- mozna dodac tam stany posrednie, ale te beda najwazniejsze (pozwalaja na hardkodowanie sekwencji TDI dla SHIFTIR i SHIFTDR, podczas gdy w innych stanach wysylana jest caly czas ta sama sekwencja,
-- to jest kod dla TMS oznaczajacy przejscie do innego stanu TAPa
-- bardzo madra jest ta uwaga, przeniose ja do top modulu.