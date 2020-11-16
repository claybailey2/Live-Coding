(
t=TempoClock.default;
t.tempo_(130/160);
)

(
Pdef('bass').quant = 8;
Pdef('arp').quant = 8;
Pdef('kick').quant = 8;
Pdef('hh').quant = 1;
Pdef('rim').quant = 8;
)

(
MIDIClient.init;MIDIIn.connectAll;
~synths = Array.fill(128,{|i|Synth('playme',['freq',i.midicps]);});
MIDIdef.noteOn('on',{|val,nn|
	~synths[nn].set(
		'gate',1,
		'amp',val.postln.linexp(1,127,0.001,1),
		'trig',1
	)
});
MIDIdef.noteOff('off',{|val,nn|
	~synths[nn].set('gate',0)
})
)

(
Pdef('hh',Pbind(
	'instrument','hh',
	'dur',0.125,
	'velocity',Pwhite(70,90)
)).play;
)

(
Pdef('bass',Pbind(
	'instrument','bass',
	'octave',4,
	'note',Pseq([0,7,7,-3,2,2,-5,2,2,5,7,7],inf),
	'dur',Pseq([2,1,1]/2,inf),
	'amp',0.65
)).play;
)

(
Pdef('arp',Pbind(
	'instrument','arp',
	'dur',0.125,
	'note',Pseq(([0,2,7,9].dup++[4,5,9,12].dup).flat,inf),
	'amp',0.2
)).play;
)

(
Pdef('kick',Pbind(
	'octave',3,
	'instrument','kick',
	'amp',0.4,
	'note',Pseq([0,0,-3,2,-7,-5],inf),
	'dur',Pseq([1.5,0.5,2],inf)
)).play;
)

(
Pdef('rim',Pbind(
	'instrument','rim',
	'dur',Pseq([Rest(1),2,1]/2,inf),
	'amp',0.8
)).play;
)

(
Pdef('arp').clear;
Pdef('kick').clear;
Pdef('rim').clear;
Pdef('hh').clear;
)