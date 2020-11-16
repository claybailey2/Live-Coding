(
t=TempoClock.default;
t.tempo=140/60;
)
(
Pdef('bass').quant = 16;
Pdef('keys').quant = 16;
Pdef('lead').quant = 16;
Pdef('hh').quant=16;
)
(
~bassDurs = [1.5]++(0.5!4)++(1!2)++(0.5!5);
~bassNotes = ((([0]++(7!5))!2)++((([0]++(7!5))!2)-3)).flat;
Pdef('bass',Pbind('instrument','bass',
	'dur',Pseq(~bassDurs,inf),
	'root',-5,
	'note',Pseq(~bassNotes,inf),
	'octave',3,
	'legato',0.5
)).play;
)
(
~keysDurs = [Rest(),0.5,0.25,Rest(1.25),0.5,Rest(0.5)];
~keysNotes = ([2,4,7]!12)++([2,5,7]!12);
Pdef('keys',Pbind('instrument','keys',
	'dur',Pseq(~keysDurs,inf),
	'root',-5,
	'degree',Pseq(~keysNotes,inf)
)).play;
)
(
~leadNotes = ((6 collect: {[0,1,2,4,5].choose}) ++
(7 collect: {[2,4,5,6b,7,].choose})).flat;
~leadDurs = (([2,1,1]!3)++[2.5,0.5,0.5,0.5]).flat;
Pdef('lead',Pbind('instrument','lead',
	'octave',6,
	'root',-5,
	'dur',Pseq(~leadDurs,inf),
	'degree',Pseq(~leadNotes,inf),
)).play;
)
(
Pdef('hh',Pbind('instrument','hh',
	'dur',2
)).play;
)
Pdef.clear