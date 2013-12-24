library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TAP is

port(
TMS: in std_logic; --mode select: sampled at rising edge of TCK to determine the next state
TCK: in std_logic; --synchronizes intenal state machine operators
TRST: in std_logic;
--output signals
CLOCKIR: out std_logic;
UPDATEIR: out std_logic;
SHIFTIR: out std_logic;
TRESET: out std_logic;
TSELECT: out std_logic; --TSELECT: SELECT is a reserved name!
ENABLE: out std_logic;
SHIFTDR: out std_logic;
UPDATEDR: out std_logic;
CLOCKDR: out std_logic;
--optional signals used to set some values
CAPTUREDR: out std_logic;
CAPTUREIR: out std_logic
);
end TAP;

architecture TAP_a of TAP is
--Both edges of TCK are used: TMS and TDI are sampled on rising edge of TCK, while TDO changes on the falling edge.
-- TRST: ACTIVE LOW
-- TRESET: ACTIVE LOW
type states is (TestLogicReset, RunTestIdle, SelectDRScan, SelectIRScan, sCaptureDR, sCaptureIR, sShiftDR, sShiftIR, Exit1DR, Exit1IR, PauseDR, PauseIR, Exit2DR, Exit2IR, sUpdateDR, sUpdateIR);

signal state, next_state: states;
signal bicik :std_logic;
signal sTMS: std_logic;
begin

fsm_reg: process (TRST, TCK)
begin
if (TRST ='0') then
  state<=TestLogicReset;
elsif (TCK'event and TCK='1') then --sampling @ rising edge of TCK
  state<=next_state;
end if;
end process fsm_reg;

fsm:process(TMS, state)

begin

case state is
when TestLogicReset =>
  if (TMS='0') then
    next_state<=RunTestIdle;
  else
    next_state<=TestLogicReset;
  end if;
  
when RunTestIdle =>
  if (TMS='1') then
    next_state<=SelectDRScan;
  else
    next_state<=RunTestIdle;
  end if;
  
when SelectDRScan =>
  if (TMS='1') then
    next_state<=SelectIRScan;
  else
    next_state<=sCaptureDR;
  end if;
  
when SelectIRScan =>
  if (TMS='1') then
    next_state<=TestLogicReset;
  else
    next_state<=sCaptureIR;
  end if;
  
when sCaptureDR =>
  if (TMS='1') then
    next_state<=Exit1DR;
  else
    next_state<=sShiftDR;
  end if;  
  
when sCaptureIR =>
  if (TMS='1') then
    next_state<=Exit1IR;
  else
    next_state<=sShiftIR;
  end if;
  
when sShiftDR =>
  if (TMS='1') then
    next_state<=Exit1DR;
  else
    next_state<=sShiftDR;
  end if;  
  
when sShiftIR =>
  if (TMS='1') then
    next_state<=Exit1IR;
  else
    next_state<=sShiftIR;
  end if;  
  
when Exit1DR =>
  if (TMS='1') then
    next_state<=sUpdateDR;
  else
    next_state<=PauseDR;
  end if;
  
when Exit1IR =>
  if (TMS='1') then
    next_state<=sUpdateIR;
  else
    next_state<=PauseIR;
  end if;  
  
when PauseDR =>
  if (TMS='1') then
    next_state<=Exit2DR;
  else
    next_state<=PauseDR;
  end if;
  
when PauseIR =>
  if (TMS='1') then
    next_state<=Exit2IR;
  else
    next_state<=PauseIR;
  end if;  
  
when Exit2DR =>
  if (TMS='1') then
    next_state<=sUpdateDR;
  else
    next_state<=sShiftDR;
  end if;
  
when Exit2IR =>
  if (TMS='1') then
    next_state<=sUpdateIR;
  else
    next_state<=sShiftIR;
  end if;
  
when sUpdateDR =>
  if (TMS='1') then
    next_state<=SelectDRScan;
  else
    next_state<=RunTestIdle;
  end if;
  
when sUpdateIR =>
  if (TMS='1') then
    next_state<=SelectDRScan;
  else
    next_state<=RunTestIdle;
  end if;
  
when others =>
  next_state<=TestLogicReset;  
end case;

end process fsm;

--Setting/Resetting signals according to current state

CLOCKDR<= TCK when ((state=sShiftDR) OR (state=sCaptureDR)) else '1';
CLOCKIR<= TCK when ((state=sShiftIR) OR (state=sCaptureIR)) else '1';
UPDATEIR<= '1' when (state=sUpdateIR) else '0';
UPDATEDR<= '1' when (state=sUpdateDR) else '0';
ENABLE<= '1' when ((state=sShiftDR) OR (state=sShiftIR)) else '0';
SHIFTDR <= '1' when (state=sShiftDR) else '0';
SHIFTIR <= '1' when (state=sShiftIR) else '0';
TSELECT<= '0' when ((state=sCaptureDR) OR (state=PauseDR) OR (state=SelectDRScan) OR (state=Exit1DR) OR (state=Exit2DR) OR (state=sShiftDR) OR (state= sUpdateDR)) else '1';
TRESET<= '0' when (state=TestLogicReset) else '1'; --to be checked what's going on after settinf TRST high
CAPTUREIR<='1' when (state=sCAPTUREIR) else '0';
CAPTUREDR<='1' when (state=sCAPTUREDR) else '0';

end TAP_a; 

