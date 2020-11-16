(
CmdPeriod.run;

t = TempoClock.default;
t.tempo = (120/60); //bps

Pbind(
	'instrument','728kick',
	'dur',Pseq([1],inf),
	'velocity',127,
	'pan',-0.25
).play(t,quant:2);

Pbind(
	'instrument','728clap',
	'dur',Pseq([Rest(),1],inf),
	'velocity',127,
	'pan',0.25
).play(t,quant:2);

Pbind(
	'instrument','728lead',
	'dur',0.5,
	'velocity',Pbrown(40,80,20),
	'pan',0,
	'note',Pseq(16.collect({Scale.minor.degrees.choose}),inf)
).play(t,quant:16);

Pbind(
	'instrument','728lead',
	'dur',4,
	'velocity',60,
	'pan',0,
	'octave',3,
	'note',Pseq([0,-2,-4,7],inf)
).play(t,quant:16);
)