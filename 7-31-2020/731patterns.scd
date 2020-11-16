(
t = TempoClock.default;
t.tempo = 90/60; //bps
)
(
Pdef('back',Pmono('back',
	'degree',Pseq([[0,5,7],[3,7,9]],inf),
	'dur',8,
)).play
)
(
Pdef('calc',Pmono('calculator',
	'degree',Pseq([5,0],inf),
	'dur',8)
).play;
)
~scale = [0,1,2,4,5];
~scale = ~scale++(~scale+7)++[14];
(
Pdef('vapor',Pbind(
	'instrument','vapor',
	'degree',Pseq(Array.fill(6,{2.collect({~scale.choose})}),inf),
	'dur',Pseq([ 0.75, 0.75, 0.75, 0.75, 0.5,0.25, 0.25 ],inf)
)).play;
)

Pdef('back').fadeTime = 2;
Pdef('back').quant = 16;
Pdef('calc').fadeTime = 2;
Pdef('calc').quant = 16;
Pdef('vapor').fadeTime = 2;
Pdef('vapor').quant = 16;

Pdef.clear
