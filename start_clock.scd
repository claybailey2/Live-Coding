(
var maxNumBus = s.options.numControlBusChannels;
var maxDivision = 96;
var f = {
	~clock = {|bpm = 60|
		var tick = Impulse.kr(bpm/60.0*maxDivision);
		var count = PulseCount.kr(tick);
		Out.kr(maxNumBus-1, count);
	}.play;
	"clock reinit".postln
};
f.();

ServerTree.removeAll;
ServerTree.add(f,s);

~tg={|div|
	Trig1.kr(((In.kr(maxNumBus-1) % (maxDivision / div)).floor < 1),0.01);
};
//@div larger -> shorter pattern length
//outputs a running count. caller might use with % operator.
~tc={|div|
	(In.kr(maxNumBus-1)/(maxDivision / div)).floor;
};
~gate={|div,n,seqs|
	Mix(seqs.collect({|c| (~tc.(div) % n).floor eq: c}) * ~tg.(div));
};
)

