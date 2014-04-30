
I
 Attempting to get a license: %s
78*common2
ImplementationZ17-78
G
Failed to get a license: %s
295*common2
ImplementationZ17-301
Ð
¹WARNING: No 'Implementation' license found. This message may be safely ignored if a Vivado WebPACK or device-locked license, common for board kits, will be used during implementation.

4*vivadoZ15-19
D
 Attempting to get a license: %s
78*common2
	SynthesisZ17-78
B
Failed to get a license: %s
295*common2
	SynthesisZ17-301
q
+Loading parts and site information from %s
36*device2-
+C:/Xilinx/Vivado/2013.2/data/parts/arch.xmlZ21-36
~
!Parsing RTL primitives file [%s]
14*netlist2C
AC:/Xilinx/Vivado/2013.2/data/parts/xilinx/rtl/prims/rtl_prims.xmlZ29-14
‡
*Finished parsing RTL primitives file [%s]
11*netlist2C
AC:/Xilinx/Vivado/2013.2/data/parts/xilinx/rtl/prims/rtl_prims.xmlZ29-11
l
$Using Tcl App repository from '%s'.
323*common2-
+C:/Xilinx/Vivado/2013.2/data/XilinxTclStoreZ17-362
ˆ
)Updating Tcl app persistent manifest '%s'325*common2D
BC:/Users/Natalia/AppData/Roaming/Xilinx/Vivado/tclapp/manifest.tclZ17-364
Y
Command: %s
53*	vivadotcl21
/synth_design -top STM_SWD -part xc7k70tfbg676-1Z4-113
/

Starting synthesis...

3*	vivadotclZ4-3
d
Internal error : %s
24*device27
5compareArch passed invalid architecture name: virtex7Z21-24
q
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2	
xc7k70tZ17-347
a
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2	
xc7k70tZ17-349
ƒ
%s*synth2t
rstarting synthesize : Time (s): cpu = 00:00:03 ; elapsed = 00:00:05 . Memory (MB): peak = 168.746 ; gain = 81.762

k
synthesizing module '%s'638*oasys2	
STM_SWD2#
C:/sw_repo/Soft/WIP/STMTest.vhd2
588@Z8-638
‚
%done synthesizing module '%s' (%s#%s)256*oasys2	
STM_SWD2
12
12#
C:/sw_repo/Soft/WIP/STMTest.vhd2
588@Z8-256
„
%s*synth2u
sfinished synthesize : Time (s): cpu = 00:00:05 ; elapsed = 00:00:07 . Memory (MB): peak = 201.500 ; gain = 114.516

‡
%s*synth2x
vStart RTL Optimization : Time (s): cpu = 00:00:05 ; elapsed = 00:00:07 . Memory (MB): peak = 201.500 ; gain = 114.516

…
%s*synth2v
tFinished Compilation : Time (s): cpu = 00:00:05 ; elapsed = 00:00:07 . Memory (MB): peak = 201.500 ; gain = 114.516

{
!inferring latch for variable '%s'327*oasys2
a_trigger_reg2#
C:/sw_repo/Soft/WIP/STMTest.vhd2
1208@Z8-327
)
%s*synth2
Report RTL Partitions: 

;
%s*synth2,
*-----+-------------+-----------+---------

;
%s*synth2,
*     |RTL Partition|Replication|Instances

;
%s*synth2,
*-----+-------------+-----------+---------

;
%s*synth2,
*-----+-------------+-----------+---------

Š
Loading clock regions from %s
13*device2S
QC:/Xilinx/Vivado/2013.2/data\parts/xilinx/kintex7/kintex7/xc7k70t/ClockRegion.xmlZ21-13
‹
Loading clock buffers from %s
11*device2T
RC:/Xilinx/Vivado/2013.2/data\parts/xilinx/kintex7/kintex7/xc7k70t/ClockBuffers.xmlZ21-11
ˆ
&Loading clock placement rules from %s
318*place2H
FC:/Xilinx/Vivado/2013.2/data/parts/xilinx/kintex7/ClockPlacerRules.xmlZ30-318
†
)Loading package pin functions from %s...
17*device2D
BC:/Xilinx/Vivado/2013.2/data\parts/xilinx/kintex7/PinFunctions.xmlZ21-17
‡
Loading package from %s
16*device2V
TC:/Xilinx/Vivado/2013.2/data\parts/xilinx/kintex7/kintex7/xc7k70t/fbg676/Package.xmlZ21-16
{
Loading io standards from %s
15*device2E
CC:/Xilinx/Vivado/2013.2/data\./parts/xilinx/kintex7/IOStandards.xmlZ21-15
‡
+Loading device configuration modes from %s
14*device2C
AC:/Xilinx/Vivado/2013.2/data\parts/xilinx/kintex7/ConfigModes.xmlZ21-14
y
%s*synth2j
hPart Resources:
DSPs: 240 (col length:80)
BRAMs: 270 (col length: RAMB8 0 RAMB16 0 RAMB18 80 RAMB36 40)

Ÿ
%s*synth2
ŒFinished Loading Part and Timing Information : Time (s): cpu = 00:00:28 ; elapsed = 00:00:31 . Memory (MB): peak = 477.914 ; gain = 390.930

0
%s*synth2!
Detailed RTL Component Info : 


%s*synth2
+---Adders : 

?
%s*synth20
.	   2 Input     23 Bit       Adders := 1     

?
%s*synth20
.	   2 Input      8 Bit       Adders := 2     

"
%s*synth2
+---Registers : 

?
%s*synth20
.	               23 Bit    Registers := 1     

?
%s*synth20
.	                8 Bit    Registers := 1     

?
%s*synth20
.	                2 Bit    Registers := 1     

?
%s*synth20
.	                1 Bit    Registers := 3     


%s*synth2
+---Muxes : 

?
%s*synth20
.	   2 Input     23 Bit        Muxes := 1     

?
%s*synth20
.	   2 Input      8 Bit        Muxes := 1     

?
%s*synth20
.	   2 Input      2 Bit        Muxes := 1     

?
%s*synth20
.	   4 Input      2 Bit        Muxes := 1     

?
%s*synth20
.	   3 Input      1 Bit        Muxes := 2     

?
%s*synth20
.	   2 Input      1 Bit        Muxes := 3     

4
%s*synth2%
#Hierarchical RTL Component report 

!
%s*synth2
Module STM_SWD 

0
%s*synth2!
Detailed RTL Component Info : 


%s*synth2
+---Adders : 

?
%s*synth20
.	   2 Input     23 Bit       Adders := 1     

?
%s*synth20
.	   2 Input      8 Bit       Adders := 2     

"
%s*synth2
+---Registers : 

?
%s*synth20
.	               23 Bit    Registers := 1     

?
%s*synth20
.	                8 Bit    Registers := 1     

?
%s*synth20
.	                2 Bit    Registers := 1     

?
%s*synth20
.	                1 Bit    Registers := 3     


%s*synth2
+---Muxes : 

?
%s*synth20
.	   2 Input     23 Bit        Muxes := 1     

?
%s*synth20
.	   2 Input      8 Bit        Muxes := 1     

?
%s*synth20
.	   4 Input      2 Bit        Muxes := 1     

?
%s*synth20
.	   2 Input      2 Bit        Muxes := 1     

?
%s*synth20
.	   3 Input      1 Bit        Muxes := 2     

?
%s*synth20
.	   2 Input      1 Bit        Muxes := 3     

—
%s*synth2‡
„Finished Cross Boundary Optimization : Time (s): cpu = 00:00:28 ; elapsed = 00:00:31 . Memory (MB): peak = 478.188 ; gain = 391.203


%s*synth2€
~---------------------------------------------------------------------------------
Start RAM, DSP and Shift Register Reporting

c
%s*synth2T
R---------------------------------------------------------------------------------

”
%s*synth2„
---------------------------------------------------------------------------------
Finished RAM, DSP and Shift Register Reporting

c
%s*synth2T
R---------------------------------------------------------------------------------

‹
%s*synth2|
zFinished Area Optimization : Time (s): cpu = 00:00:28 ; elapsed = 00:00:31 . Memory (MB): peak = 507.828 ; gain = 420.844


%s*synth2~
|Finished Timing Optimization : Time (s): cpu = 00:00:28 ; elapsed = 00:00:31 . Memory (MB): peak = 507.828 ; gain = 420.844

1
%s*synth2"
 Start control sets optimization

r
%s*synth2c
aFinished control sets optimization. Modified 8 flops. Number of control sets: before: 3 after: 2

Œ
%s*synth2}
{Finished Technology Mapping : Time (s): cpu = 00:00:28 ; elapsed = 00:00:31 . Memory (MB): peak = 507.828 ; gain = 420.844

†
%s*synth2w
uFinished IO Insertion : Time (s): cpu = 00:00:29 ; elapsed = 00:00:33 . Memory (MB): peak = 507.828 ; gain = 420.844

(
%s*synth2
Report Check Netlist: 

R
%s*synth2C
A-----+-----------------+------+--------+------+-----------------

R
%s*synth2C
A     |Item             |Errors|Warnings|Status|Description      

R
%s*synth2C
A-----+-----------------+------+--------+------+-----------------

R
%s*synth2C
A1    |multi_driven_nets|     0|       0|Passed|Multi driven nets

R
%s*synth2C
A-----+-----------------+------+--------+------+-----------------

˜
%s*synth2ˆ
…Finished Renaming Generated Instances : Time (s): cpu = 00:00:29 ; elapsed = 00:00:33 . Memory (MB): peak = 507.828 ; gain = 420.844

•
%s*synth2…
‚Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:29 ; elapsed = 00:00:33 . Memory (MB): peak = 507.828 ; gain = 420.844


%s*synth2€
~---------------------------------------------------------------------------------
Start RAM, DSP and Shift Register Reporting

c
%s*synth2T
R---------------------------------------------------------------------------------

”
%s*synth2„
---------------------------------------------------------------------------------
Finished RAM, DSP and Shift Register Reporting

c
%s*synth2T
R---------------------------------------------------------------------------------

%
%s*synth2
Report BlackBoxes: 

/
%s*synth2 
-----+-------------+---------

/
%s*synth2 
     |BlackBox name|Instances

/
%s*synth2 
-----+-------------+---------

/
%s*synth2 
-----+-------------+---------

%
%s*synth2
Report Cell Usage: 

$
%s*synth2
-----+------+-----

$
%s*synth2
     |Cell  |Count

$
%s*synth2
-----+------+-----

$
%s*synth2
1    |BUFG  |    2

$
%s*synth2
2    |CARRY4|   10

$
%s*synth2
3    |LUT1  |   15

$
%s*synth2
4    |LUT2  |    7

$
%s*synth2
5    |LUT3  |   15

$
%s*synth2
6    |LUT4  |    6

$
%s*synth2
7    |LUT5  |   14

$
%s*synth2
8    |LUT6  |   27

$
%s*synth2
9    |FDCE  |   34

$
%s*synth2
10   |FDPE  |    2

$
%s*synth2
11   |LD    |    1

$
%s*synth2
12   |IBUF  |    5

$
%s*synth2
13   |OBUF  |    9

$
%s*synth2
-----+------+-----

)
%s*synth2
Report Instance Areas: 

-
%s*synth2
-----+--------+------+-----

-
%s*synth2
     |Instance|Module|Cells

-
%s*synth2
-----+--------+------+-----

-
%s*synth2
1    |top     |      |  147

-
%s*synth2
-----+--------+------+-----

”
%s*synth2„
Finished Writing Synthesis Report : Time (s): cpu = 00:00:29 ; elapsed = 00:00:33 . Memory (MB): peak = 507.828 ; gain = 420.844

W
%s*synth2H
FSynthesis finished with 0 errors, 0 critical warnings and 1 warnings.

‘
%s*synth2
Synthesis Optimization Complete : Time (s): cpu = 00:00:29 ; elapsed = 00:00:33 . Memory (MB): peak = 507.828 ; gain = 420.844

J
-Analyzing %s Unisim elements for replacement
17*netlist2
6Z29-17
O
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28
1
Pushed %s inverter(s).
98*opt2
0Z31-138
M
 Attempting to get a license: %s
78*common2
Internal_bitstreamZ17-78
K
Failed to get a license: %s
295*common2
Internal_bitstreamZ17-301
ƒ
!Unisim Transformation Summary:
%s111*project2G
E  A total of 1 instances were transformed.
  LD => LDCE: 1 instances
Z1-111
1
%Phase 0 | Netlist Checksum: ac5d24f7
*common
u
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
102
22
02
0Z4-41
C
%s completed successfully
29*	vivadotcl2
synth_designZ4-42
¢
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
synth_design: 2

00:00:332

00:00:372	
768.9732	
632.156Z17-268

sreport_utilization: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.047 . Memory (MB): peak = 768.973 ; gain = 0.000
*common
S
Exiting %s at %s...
206*common2
Vivado2
Sun Apr 27 12:22:18 2014Z17-206