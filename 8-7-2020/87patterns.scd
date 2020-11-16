(
t = TempoClock.default;
t.tempo = 110/60;
)

Pdef('bass').quant = 16;
Pdef('arp1').quant = 1;
Pdef('accomp').quant = 16;
Pdef('pad1').quant = 16;
Pdef('snare').quant = 8;
Pdef('click').quant = 2;
Pdef('vocoder').quant = 16;
(
Pdef('bass',Pbind(
	'instrument', 'bass',
	'octave',3,
	'root',-5,
	'note',Pseq([0,2,4,7].stutter(5),inf),
	'legato',0.95,
	'dur',Pseq([1,1,1,0.5,0.5],inf),
	'amp',0.6
)).clear;
)
(
Pdef('arp1',Pbind(
	'instrument','arp1',
	'octave',6,
	'root',-5,
	'dur',0.25,
	'note',Pseq([2,7,11,16],inf),
	'amp',Pseq((0..3).linexp(0,3,0.35,0.05),inf)
)).clear
)
(
Pdef('accomp',Pbind(
	'instrument','accomp',
	'octave',5,
	'root',-5,
	'dur',1,
	'note',Pseq([
		[7,11,16],
		[9,11,14],
		[7,11,16],
		[7,11,14]
	].stutter(4),inf),
	'amp',Pseq(((0..3)++(3..0)).linexp(0,3,0.03,0.1),inf)
)).clear
)
(
Pdef('pad1',Pmono(
	'pad1',
	'octave',4,
	'root',-5,
	'dur',Pseq(([1.5,1,0.5,0.5,0.5]!3++[1,1,0.5,1.5]).flat,inf),
	'degree',Pseq(([5,4,6,5,4]!3++[5,4,2,4]).flat,inf),
	'amp',0.05,
	'trig',1
)).clear
)
(
Pdef('snare',Pbind(
	'instrument','snare',
	'dur',Pseq([Rest(3),5],inf),
	'amp',0.1
)).play
)
(
Pdef('click',Pbind(
	'instrument','click',
	'dur',Pseq([Rest(),1],inf),
	'amp',0.8
)).clear
)
(
Pdef('vocoder',Pmono(
	'vocoder-chord',
	'octave',4,
	'root',-5,
	'dur',4,
	'note',Pseq([0,2,4,7],inf),
	//'note',0,
	'amp',1,
)).clear
)