(
t = TempoClock.default;
t.tempo = 120/60;
)
(
~droneBus = Bus.audio(s,2);

Pdef('drone',Pbind('instrument','drone',
	'dur',4,
	'out',~droneBus,
	'fund',Pseq([19,24,27,26],inf).midicps,
	'legato',1,
	'amp',0.8
)).play;

Pdef('filter',Pmono('filter-rise', 'in',~droneBus,
	'dur',Pseq(
		(1!4)++
		1++(0.5!2)++(1!2)++
		(1!2)++(0.25!4)++((1/3)!3)++
		(0.5!2)++1++((1/3)!3)++((1/6)!6)
,inf),
	'trig',1);
).play;
)
(
Pdef('kick',Pmono('kick','dur',1,'trig',1)).play;
)
(//
~snareBus = Bus.audio(s,2);

Pdef('snare',Pmono('snare',
	'dur',Pseq([Rest(),1],inf),
	'trig',1,
	'out',~snareBus
)).play;

Pdef('snareVerb',Pmono('verb',
	'in',~snareBus,
	'amp',0.8
)).play;
)
(
Pdef('hh',Pmono('hh',
	'dur',Pseq([Rest(0.5),0.25,0.25],inf),
	'trig',1)
).play;
)
(
Pdef('crash',Pmono('crash',
	'dur',16,
	'trig',1)
).play;
)
(
Pdef('arp',Pmono('arp',
	'dur',0.25,
	'root',7,
	'note',Pseq([0,4,7,11],inf),
	'amp',0.05,
	'trig',1
)).play;
)
(
Pdef('tom',Pbind('instrument','tom',
	'dur',Pseq([Rest(0.5),0.5,0.5,0.5],inf),
	'trig',1,
	'amp',0.2,
	'freq',Pseq([200,430,290]/2,inf)
)).play;
)
Pdef('drone').quant = 4;
Pdef('filter').quant = 16;
Pdef('kick').quant = 4;
Pdef('snare').quant = 4;
Pdef('hh').quant = 4;
Pdef('crash').quant = 16;
Pdef('arp').quant = 1;
Pdef('tom').quant = 4;

Pdef.clear
