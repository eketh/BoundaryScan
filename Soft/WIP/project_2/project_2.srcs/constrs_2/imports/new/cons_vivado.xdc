set_property LOC R17 [get_ports reset];
set_property LOC B8 [get_ports clk];
set_property LOC N17 [get_ports trigger];
set_property IOSTANDARD LVCMOS33 [get_ports trigger];

set_property LOC L14 [get_ports test];
set_property LOC F4 [get_ports test_out];

set_property LOC J13 [get_ports TCK];
set_property LOC M18 [get_ports TMS];

set_property LOC K14 [get_ports SWD_out];
set_property LOC P18 [get_ports nTRST];

set_property LOC J15 [get_ports reset_led];
set_property LOC K15 [get_ports state_led1];
set_property LOC R4 [get_ports state_led2];
set_property LOC J14 [get_ports state_led3];

#NET "reset" LOC = "R17"; #| IOSTANDARD = LVTTL | PULLUP ; #L13;
#NET "clk" LOC = "B8" |IOSTANDARD = LVCMOS33;
#NET "trigger" LOC = "N17"; #| IOSTANDARD = LVTTL | PULLUP ;
#NET "button" LOC = "L13"; #| IOSTANDARD = LVTTL | PULLUP ;

#NET "test" LOC = "L14" | IOSTANDARD = LVTTL | PULLUP ;
#NET "test_out" LOC = "F4" | IOSTANDARD = LVTTL |SLEW= SLOW | DRIVE= 8 ;

#TAP
#NET "TCK" LOC = "J13" | IOSTANDARD = LVTTL | SLEW = SLOW | DRIVE = 6 |PULLUP ;
#NET "TMS" LOC = "M18" | IOSTANDARD = LVTTL | SLEW = SLOW | DRIVE = 6 ;
#NET "SWD_out" LOC = "K14" | IOSTANDARD = LVTTL | SLEW = SLOW | DRIVE = 6 ;#TDI
#NET "TDI_jtag" LOC = "E7" | IOSTANDARD = LVTTL | SLEW = SLOW | DRIVE = 6 ;#TDO
#NET "nTRST" LOC = "P18" | IOSTANDARD = LVTTL | SLEW = SLOW | DRIVE = 6 ;

#diody
#NET "TDO_led" LOC = "E9" | IOSTANDARD = LVTTL |SLEW= SLOW | DRIVE= 8 ;
#NET "reset_led" LOC = "J15" | IOSTANDARD = LVTTL |SLEW= SLOW | DRIVE= 8 ;
#NET "state_led1" LOC = "K15" | IOSTANDARD = LVTTL |SLEW= SLOW | DRIVE= 8 ;
#NET "state_led2" LOC = "R4" | IOSTANDARD = LVTTL |SLEW= SLOW | DRIVE= 8 ;
#NET "state_led3" LOC = "J14" | IOSTANDARD = LVTTL |SLEW= SLOW | DRIVE= 8 ;