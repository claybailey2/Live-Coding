~clock.set('bpm',152);
Ndef.clear

Ndef('bass').play.fadeTime_(2);
Ndef('snare').play.fadeTime_(2);
Ndef('arp').play.fadeTime_(2);
Ndef('pad').play.fadeTime_(2);
Ndef('hh').play.fadeTime_(2);


(
Ndef('bass',{
	var gate = ~gate.(2, 32, [0,6,9,14,16,23,29,30,31]) ;
	var env = EnvGen.kr(Env.perc,gate);
	Pan2.ar(SinOsc.ar(69,mul:env*0.9));
});
)

(
Ndef('snare',{
	var gate = Trig1.kr((~tc.(1/2) % 2).floor,0.01);
	var env = EnvGen.kr(Env.perc(0.007,0.05),gate);
	Pan2.ar(WhiteNoise.ar(0.1) + PMOsc.ar(55.midicps,55.midicps*5.14,4,mul: 0.5),level: env) * 0.2;
});
)

(
Ndef('arp',{
	var gate = ~tg.(2);
	var note = Select.kr((~tc.(2) % 8).floor,[ 55, 58, 60, 62, 65, 67, 70, 72 ]);
	Pan2.ar(LPF.ar(Mix(Saw.ar(note.midicps),Saw.ar(note.midicps+10)),LFNoise1.kr(150,1000,note.midicps*11)), LFTri.kr(0.5),0.1)
});
)

(
Ndef('pad',{
	var gate = ~tg.(1/16);
	var numNotes = 4;
	//my attempt at chord
	/*
	var note = Array.fill(4,{|i|Select.kr(((~tc.(1/16) % 4).floor * 4) + i,[
		57, 60, 65, 67,
		58, 62, 65, 67,

	]-12);});
	*/
	//park's implementation of chord
	var note = Select.kr({|i|((~tc.(1/16) % 2).floor * numNotes) + i}.dup(numNotes),[
		57, 60, 65, 67,
		58, 62, 65, 67

	]-12);
	var env = EnvGen.kr(Env([0,1,0],[3,3]),gate);

	Out.ar(0,Pan2.ar(RLPF.ar(Mix(Saw.ar(note.midicps,mul: env)),env.linexp(0,1,400,6000),rq: 0.5, mul: 0.25),SinOsc.kr(1,mul: 0.3)));
});
)

(
Ndef('hh',{
	var div_t = ~tg.(1);
	var div = TIRand.kr(1,6,div_t);
	var gate = ~tg.(div);

	var env = EnvGen.kr(Env.perc(0.003,0.027),gate);
	var mod_idx = Select.kr((~tc.(1/16) % 2).floor,[5.935,6.818]);
	var sound = HPF.ar(Pulse.ar(276 + Pulse.ar(182, mul: 182 * mod_idx)), 6000) * env;
	Out.ar(0,Pan2.ar(sound,TRand.kr(-0.3,0.3)));
})
)