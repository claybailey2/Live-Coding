~bassVol=Bus.control;
(
SynthDef('bass',{|freq,gate=1|
	var mod1i = 2;
	var mod2i = 1.5;
	var mod1 = SinOsc.ar(freq*3.009,mul: freq*mod1i);
	var mod2 = SinOsc.ar(freq*3.991,mul: freq*mod2i);
	var car = SinOsc.ar(freq+mod1+mod2);
	var env = EnvGen.kr( Env.adsr(0.01,0.01,0.6,0.05), gate,doneAction: 2);
	var sound = LPF.ar(car * env,XLine.kr(freq*30,freq*5,0.1));
	Out.ar(0,Pan2.ar(sound,0,~bassVol.kr));
}).add;
)

~keysVol=Bus.control;
(
SynthDef('keys',{|freq,gate=1|
	var bell = Mix([ SinOsc.ar(freq*4),SinOsc.ar(freq*4*(3.midiratio),mul: 0.5)
	]);
	var bell_env = EnvGen.kr(Env.perc(),gate);
	var body = Mix(Array.fill(3,{
		|i|SinOsc.ar(freq*(i+1))/(i+1)
	}));
	var noise = BPF.ar(WhiteNoise.ar(),freq*8,0.1);
	var adsr_env = EnvGen.kr(Env.adsr(0.1,0.1,releaseTime: 0.3),gate,doneAction: 2);
	var mix = Mix([
		bell*bell_env*adsr_env*3,
		body*adsr_env*7,
		noise*adsr_env*1
	]);
	var sound = RLPF.ar(mix,XLine.kr(freq*2.pow(4),freq*2.pow(2),0.3));
	Out.ar(0,Pan2.ar(sound,0,~keysVol.kr));
}).add;
)


~leadVol = Bus.control;
~leadFilt = Bus.control;
~leadDur = Bus.control;
(
SynthDef('lead',{|freq,dur,gate=1|
	var env = EnvGen.kr(Env.adsr(2,1,0.5,0.3),gate,doneAction: 2);
	var impulse = Impulse.ar(20 + SinOsc.kr(3,mul: 5));
	var in = Klank.ar(
		`[[1,0.6,1.2,1.8]*freq,nil,[100,50,12,6]],
		impulse
	);
	var sound = GrainIn.ar(2,
		trigger: impulse,
		dur: ~leadDur.kr,
		in: in,
		pan: 0,
		mul: 0.2
	);
	Out.ar(0,Pan2.ar(LPF.ar(sound,~leadFilt.kr)*env*~leadVol.kr));
}).add;
)

~hhVol=Bus.control;
(
SynthDef('hh',{
	var env = EnvGen.kr(Env.perc(0.003,0.082),doneAction: 2);
	var filt_env = EnvGen.kr(Env([2000,6000],[0.014],4));
	Out.ar(0,Pan2.ar(RHPF.ar(WhiteNoise.ar()*env,filt_env,0.2),0,~hhVol.kr));
}).add;
)