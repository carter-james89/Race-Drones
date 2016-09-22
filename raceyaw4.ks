set done to false.
//lock rotation to target:facing.
//lock offset to trgtoffset*rotation.
//lock trgt to target:position + offset.

lock rotation to gate:facing.
lock offset to trgtoffset*rotation.
lock trgt to gate:position + offset.


until done = true
{

if rcs = true
{
set vd1 to 0.
set vd1 to vecdrawargs(v(0,0,0),trgt*30,green,"leader",1,true).  //works for leader
}
if rcs = false and vd1 <> 0
{
	set vd1 to 0.
}

set rolldif to steeringmanager:rollerror.
set pitchdif to steeringmanager:pitcherror.

//sprint
if abs(pitchdif) < pitchtrgt and currentstatus = "turning"
{
	set currentstatus to "sprint".
}


//if I am sprinting, and distance is > entry distance	
if trgt:mag > trgtdistance + trgtchange and currentstatus = "sprint"
{
	lock throttle to 1.
	lock steering to lookdirup(trgt, up:vector).
	set rolltrgt to "up".
}

//if I am sprinting, and distance is in entry distance	
if trgt:mag < (trgtdistance + trgtchange) and currentstatus = "sprint"
{
	set currentstatus to "Entry Turn".
	if ag6 = true
	{
		ag6 off.
	}

	lock trgtdir to lookdirup(trgt, up:vector).

	lock rollvector to angleaxis(entryangle,trgtdir:forevector)*trgtdir.

	lock steering to rollvector.

	lock throttle to entryspeed.		
}

//turning
if abs(pitchdif) > pitchtrgt and (currentstatus = "sprint" or currentstatus = "Entry Turn")
{
	set currentstatus to "turning".

	lock throttle to turningspeed.
	//lock steering to lookdirup(trgt,target:position).

	lock steering to angleaxis(entryangle,trgtdir:forevector)*trgt.
	set rolltrgt to "target".
	
	if ag3 = false and ship:oxidizer = 0
	{
		ag3 on.
	}
}


//if I am sprinting and steeringmanager is set in turning
if currentstatus = "sprint" and (STEERINGMANAGER:PITCHPID:KP <> .8) and slalom = false
{
	set STEERINGMANAGER:PITCHPID:KP to .8. //1
	set STEERINGMANAGER:PITCHPID:KI to 0.05. //.1
	set STEERINGMANAGER:PITCHPID:KD to .5.

	set STEERINGMANAGER:rollPID:KP to 1. //1
	set STEERINGMANAGER:rollPID:KI to .1. //.1
	set STEERINGMANAGER:rollPID:KD to 1. //1


	set STEERINGMANAGER:yawPID:KP to .5. //1
	set STEERINGMANAGER:yawPID:KI to .05. //.1
	set STEERINGMANAGER:yawPID:KD to .5. //1
}

if currentstatus = "sprint" and (STEERINGMANAGER:PITCHPID:KP <> 5) and slalom = true
{
	set STEERINGMANAGER:PITCHPID:KP to 5. //1
	set STEERINGMANAGER:PITCHPID:KI to 0.1. //.1
	set STEERINGMANAGER:PITCHPID:KD to 4.

	set STEERINGMANAGER:rollPID:KP to 20. //1
	set STEERINGMANAGER:rollPID:KI to 5. //.1
	set STEERINGMANAGER:rollPID:KD to 10. //1


	set STEERINGMANAGER:yawPID:KP to 5. //1
	set STEERINGMANAGER:yawPID:KI to .1. //.1
	set STEERINGMANAGER:yawPID:KD to 4. //1
}

//if I am sprinting and steeringmanager is set in turning or entry
if currentstatus = "Turning" and STEERINGMANAGER:PITCHPID:KP <> 14
{
	set STEERINGMANAGER:PITCHPID:KP to 14. //1
	set STEERINGMANAGER:PITCHPID:KI to 0.1. //.1
	set STEERINGMANAGER:PITCHPID:KD to 6.

	set STEERINGMANAGER:yawPID:KP to 25. //1
	set STEERINGMANAGER:yawPID:KI to 10. //.1
	set STEERINGMANAGER:yawPID:KD to 15. //1	
}

if currentstatus = "Entry Turn" and STEERINGMANAGER:rollPID:KP <> 16
{
	set STEERINGMANAGER:rollPID:KP to 16. //1
	set STEERINGMANAGER:rollPID:KI to .1. //.1
	set STEERINGMANAGER:rollPID:KD to 7. //1
}

if currentstatus = "sprint" and abs(rolldif) > 1 and STEERINGMANAGER:rollPID:KP <> 15
{
	set STEERINGMANAGER:rollPID:KP to 15. //1
	set STEERINGMANAGER:rollPID:KI to 1. //.1
	set STEERINGMANAGER:rollPID:KD to 6. //1
}
if currentstatus = "sprint" and abs(rolldif) < 1 and STEERINGMANAGER:rollPID:KP <> 1
{
	set STEERINGMANAGER:rollPID:KP to 1. //1
	set STEERINGMANAGER:rollPID:KI to .1. //.1
	set STEERINGMANAGER:rollPID:KD to 1. //1
	
	if ag6 = false
	{
		ag6 on.
	}

	if finished = true
	{
		set done to true.
	}
}

//turn the airbrakes on in entry turn, only if in correct roll position
if currentstatus = "entry turn" and abs(rolldif) > 1 and ag8 = true
{
	ag8 off.
}
if currentstatus = "entry turn" and abs(rolldif) < 1 and ag8 = false
{
	ag8 on.
}
//turn the brakes off when pointing close to the target
if currentstatus = "turning" and ag8 = false and abs(pitchdif) > 80
{
	ag8 on.
}
if currentstatus = "turning" and ag8 = true and abs(pitchdif) < 80
{
	ag8 off.
}
if currentstatus = "sprint" and ag8 = true 
{
	ag8 off.
}

if currentstatus = "entry turn" and ag2 = true
{
	ag2 off.
}
if currentstatus <> "entry turn" and ag2 = false
{
	ag2 on.
}

if ag4 = false and currentstatus = "sprint"
{
	ag4 on.
}
if slalom = true and ag4 = false
{
	ag4 on.
}
if slalom = false
{
	if currentstatus = "entry turn" and burnentry = false and ag4 = true
	{
		ag4 off.
	}
	if currentstatus = "entry turn" and burnentry = true and ag4 = false
	{
		ag4 on.
	}
	if currentstatus = "turning" and turnburn = true and ag4 = false
	{
		ag4 on.
	}
	if currentstatus = "turning" and turnburn = false and ag4 = true
	{
		ag4 off.
	}		
}

clearscreen.
//print "Target: " + target.
print "curstatus: " + currentstatus.
print "Entry Spd: " + entryspeed.
print "Turning SPd: " + turningspeed.
print " ".
print "Distance:        " + trgt:mag.
print " u".
//print timespan:second - starttime.

if trgt:mag < trgtchange
{
	set done to true.
}
wait .2.

}