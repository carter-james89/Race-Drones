lock throttle to 1.
set position to "na".
set bailstatus to false.
clearscreen.
wait 2.
set finished to false.
set vd1 to 0.

set pitchtrgt to 6.
set turningstatus to false.
set slalom to false.

	set STEERINGMANAGER:PITCHPID:KP to .5. //1
	set STEERINGMANAGER:PITCHPID:KI to 0.05. //.1
	set STEERINGMANAGER:PITCHPID:KD to .5.

	set STEERINGMANAGER:rollPID:KP to 1. //1
	set STEERINGMANAGER:rollPID:KI to .1. //.1
	set STEERINGMANAGER:rollPID:KD to 1. //1


	set STEERINGMANAGER:yawPID:KP to .5. //1
	set STEERINGMANAGER:yawPID:KI to .05. //.1
	set STEERINGMANAGER:yawPID:KD to .5. //1

//set gate to vessel("Gate 1").
set gate to vessel("Gate 1").
set trgtoffset to v(0, 40, 10).
set trgtchange to 275. //300
set trgtdistance to 290. //500
set entryspeed to .3.
set turningspeed to 1.
set burnerdistance to 700.
set entryangle to 90.
set burnentry to false.
set turnburn to false.

if altitude < 80
{
	set currentstatus to "Takeoff".
	ag6 on.
	ag1 on.
	lock throttle to .2.
	
	Print "Spooling Engines".
	lock steering to heading(90, .8).
	wait 5.
	lock throttle to 1.
	ag4 on.
	ag2 on.

	print "START".
//	set starttime to timespan:second.

	brakes off.

	wait until alt:radar > 2.
}

gear off.
ag6 off.

set currentstatus to "turning".

run raceyaw4.

set gate to vessel("Gate 2").
set entryspeed to .3.
set trgtoffset to v(135,0, 10). //-20z
set trgtdistance to 320.
set trgtchange to 180.
set turningspeed to 1.
set entryangle to 90.
run raceyaw4.
	

set gate to vessel("Gate 3").
set trgtoffset to v(-40, 0, 10). //-7z
set trgtdistance to 400.
set trgtchange to 250.
set entryspeed to .3.
set turningspeed to 1.                                                   
set entryangle to -90.
run raceyaw4.

set gate to vessel("Gate 4").
set trgtoffset to v(0, -5, -10).
set trgtdistance to 250.
set trgtchange to 185. //115
set entryspeed to 1.
set turningspeed to 1.
set burnerdistance to 200.
set entryangle to 90.
set burnentry to true.
set turnburn to false.
run raceyaw4.

set gate to vessel("Gate 5").
set trgtoffset to v(0, -100, 0).
set trgtdistance to 230.
set trgtchange to 310.
set entryspeed to .5.
set turningspeed to 1. //for nexttrgt turn
set entryangle to 90.
set burnentry to false.
set turnburn to true.

run raceyaw4.


set gate to vessel("Gate 6").
//for gate 6
set trgtoffset to v(180, 00, 0).
set trgtdistance to 300.
set trgtchange to 280.
set entryspeed to .5.
set entryangle to 90.
set burnentry to false.
set turnburn to true.
//for gate 5
set turningspeed to 1.
set turnburn to false.
run raceyaw4.



set gate to vessel("Gate 7").
set slalom to true.
set trgtoffset to v(0, -25, 0).
set trgtdistance to 300.
set trgtchange to 240.
set entryspeed to 1.
set entryangle to -90.
set burnentry to true.
set turnburn to false.
run raceyaw4.


set gate to vessel("Gate 8").
set trgtoffset to v(0, -25, 0).
set trgtdistance to 300.
set trgtchange to 280.
set entryspeed to 1.
set turningspeed to 1. //for nexttrgt turn
set entryangle to 90.
set burnentry to true.
set turnburn to true.
run raceyaw4.


set gate to vessel("Gate 9").
set trgtoffset to v(0, -30, 0).
set trgtdistance to 500.
set trgtchange to 260.
set entryspeed to 1.
set turningspeed to .1. //for nexttrgt turn
set entryangle to -90.
set slalom to false.
set burnentry to false.
set turnburn to true.
run raceyaw4.

set gate to vessel("Gate 10").
set trgtoffset to v(0, -100, 10).
set trgtdistance to 500.
set trgtchange to 240.
set entryspeed to .1.
set turningspeed to .1.
set entryangle to 90.
set burnentry to false.
set turnburn to true.

run raceyaw4.

set gate to vessel("Gate 11").
set trgtoffset to v(150, 0, -35).
set trgtdistance to 300.
set trgtchange to 220.
set entryspeed to .5.
set turningspeed to 1.
set entryangle to 90.
set slalom to false.
run raceyaw4.

set gate to vessel("Gate 12").
set trgtoffset to v(0, -4, 0).
set trgtdistance to 0.
set trgtchange to 150.
set entryspeed to 1.
set entryangle to 0.
set turningspeed to 1.
set burnentry to true.
set turnburn to true.
run raceyaw4.

//top
set gate to vessel("Gate 13").
set trgtoffset to v(0,-40,0).
set trgtdistance to 0.
set trgtchange to 170.
set entryspeed to 1.
set turningspeed to 1.
set entryangle to 0.
run raceyaw4.

set gate to vessel("Gate 14").
set trgtoffset to v(0, 0, 20).
set trgtdistance to 250.
set trgtchange to 170.
set entryspeed to 1.
set turningspeed to 1.
set entryangle to -85.
set burnentry to true.
set turnburn to true.
run raceyaw4.


set gate to vessel("Gate 15").
set nexttrgt to vessel("Gate 15").
set trgtoffset to v(150, 0, -10).
set trgtdistance to 350.
set trgtchange to 380.
set entryspeed to .5.
set turningspeed to 1.
set entryangle to -90.
set turnburn to true.
set burnentry to false.
run raceyaw4.

//set finshtime to timespan:second.

set gate to vessel("Gate 1").
set trgtoffset to v(200, 0, 20).
set finished to true.
set entryspeed to .1.
set turningspeed to .8.

run raceyaw4.

if alt:radar < 15
{
lock steering to heading(90,0).
}
if alt:radar > 15
{
lock steering to heading(90,-2).
}
ag1 off. 
ag4 off.
ag8 on.
gear on.

wait until alt:radar < 5.

brakes on.

wait until groundspeed <1.

print " ".
Print "Bitchin".


