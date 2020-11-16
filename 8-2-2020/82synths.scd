(
SynthDef('bass',{|freq,amp|
	var env = Env.perc.kr(2);
	var freq_env = XLine.kr((-5.midiratio),1,0.3);
	var sound = LPF.ar(Saw.ar(freq*freq_env,mul: env*amp),500);
	Out.ar(0,Pan2.ar(sound));
}).add;
)
(
SynthDef('playme',{|freq,amp,gate=0|
	var env = EnvGen.kr(Env.adsr(sustainLevel: 0.9,releaseTime:0.4),gate);
	var freq_env = EnvGen.kr(
		Env([-7.midiratio,-7.midiratio,1],[0,0.1],4),
		gate);
	var sound = LPF.ar(Saw.ar(freq*freq_env),1000);
	Out.ar(0,Pan2.ar(sound,level: env*amp*5.5));
}).add;
)
(
SynthDef('arp',{
	arg freq,gate=1,dur,amp;
	var env = EnvGen.kr(Env(times: ((dur/2)!2)/t.tempo),gate,doneAction: 2);
	var filt_env = EnvGen.kr(Env([freq,freq*8,freq],((dur/2)!2)/t.tempo,5),gate);
	var osc = SinOsc.ar([freq,freq*2],mul: amp/2*env);
	var sound = RLPF.ar(osc,filt_env,0.3);
	Out.ar(0,Pan2.ar(sound));
}).add;
)
(
SynthDef('hh',{|velocity|
	var env = Env.perc(0.005,0.055).kr(2);
	var sound = HPF.ar(WhiteNoise.ar,2000);
	var amp = velocity.linexp(1,127,0.001,0.8);
	Out.ar(0,Pan2.ar(sound*env,level: amp));
}).add
)
(
SynthDef('kick',{|freq=70,amp|
	//var freq = 70;
	var click_env = Env.perc(0.002,0.005).kr(0);
	var body_env = Env.perc(0.007,0.755).kr(2);
	var freq_env = XLine.kr((15.midiratio),1,0.100);
	var click = PinkNoise.ar;
	var body = SinOsc.ar(freq*freq_env).clip(-0.6,0.6);
	var sound = Mix([click*click_env,body*body_env*5]);
	Out.ar(0,Pan2.ar(sound*amp));
}).add;
)

(
SynthDef('rim',{|amp=1|
	var body = Klank.ar(`[
		5 collect: {200 * 10.0.rand},
		5 collect: {|i| (1/(i+1))*(1+0.5.rand2)},
		0.05!5
	],
	Impulse.ar(30) + PinkNoise.ar(0.3);
	);
	var env = Env.perc(0.015,0.5).kr(2);
	var sound = LPF.ar(body*env,3000);
	Out.ar(0,Pan2.ar(sound,0,amp));
}).add;
)
(

)