~bassVol=Bus.control;

(
SynthDef('bass',{|freq,gate=1,amp|
	var mod1i = 2;
	var mod2i = 1.5;
	var mod1 = SinOsc.ar(freq*3.009,mul: freq*mod1i);
	var mod2 = SinOsc.ar(freq*3.991,mul: freq*mod2i);
	var car = SinOsc.ar(freq+mod1+mod2);
	var env = EnvGen.kr( Env.adsr(0.01,0.01,0.6,0.05), gate,doneAction: 2);
	var sound = LPF.ar(car * env,XLine.kr(freq*30,freq*5,0.1));
	Out.ar(0,Pan2.ar(sound,0,amp));
}).add;
)
(
SynthDef('arp1',{|freq,gate=1,amp|
	var env = EnvGen.kr(Env.adsr(0.02,0.02,0.8,0.05),gate,
		doneAction: 2);
	var filt_env = XLine.kr(1000,10000,0.2);
	var src = LFTri.ar(freq);
	var sound = RLPF.ar(src,filt_env,0.2);
	Out.ar(0,Pan2.ar(sound*env,0,amp));
}).add;
)
(
SynthDef('accomp',{|freq,gate=1,amp|
	var env = EnvGen.kr(Env.adsr(0.04,0.06,0.8,0.2),gate,doneAction: 2);
	var bell = SinOsc.ar(freq*4 + SinOsc.kr(freq*4*3.785, mul: freq*1.37)) * Env.perc(releaseTime:0.4).kr;
	var body = SinOsc.ar(freq +
		SinOsc.ar(freq * LFTri.kr(7,mul: 0.05,add: 3), mul: freq*XLine.kr(4,1,0.3))
	);
	var sound = FreeVerb.ar(Mix([body*env,bell*3]));
	Out.ar(0,Pan2.ar(sound,0,amp));
}).add;
)
(
SynthDef('pad1',{|freq,amp,gate=1|
	//hold synth open
	var curFreq = freq.lag(0.2);
	var env = EnvGen.kr(Env.adsr(sustainLevel: 1),gate,doneAction: 2);
	var noise = BPF.ar(WhiteNoise.ar(),curFreq,0.5);
	var body = SinOsc.ar(curFreq + SinOsc.ar(0.995*curFreq, mul: curFreq*8.5));
	var filter_env = EnvGen.kr(Env([freq*10,freq*10,freq*6],[0,0.5],3),'trig'.tr());
	var sound = LPF.ar(Mix([body*1,noise*3]),filter_env);
	Out.ar(0,Pan2.ar(sound*env,0,amp))
}).add;
)
(
SynthDef('snare',{|amp|
	var env = Env.perc.kr(2);
	var noise = WhiteNoise.ar();
	var freq_filt = XLine.kr(20000,200,0.1);
	var sound = HPF.ar(noise,freq_filt);
	Out.ar(0,Pan2.ar(sound*env,0,amp))
}).add;
)
(
SynthDef('click',{|amp|
	var env = Env.perc().kr(2);
	//var sound = SinOsc.ar(200);
	var sound = Klank.ar(
		`[
			[200,310,628,1234,2048],
			[0.4,0.4,0.04,0.02,0.01]*4,
			[0.6,0.6,0.4,0.2,0.1]
		],
		Impulse.ar(1);
	);
	Out.ar(0,Pan2.ar(sound*env,0,amp))
}).add;
)
(
SynthDef('vocoder-note',{arg freq = 200, amp = 1,gate=1;
	var env = EnvGen.kr(Env.adsr(sustainLevel: 1),gate,doneAction: 2);
	var input = SoundIn.ar();
	var sound =
		CombC.ar(input*0.01,freq.reciprocal,freq.reciprocal,0.2);
	Out.ar(0,Pan2.ar(sound*env*100,0,amp));
}).add;
)
(
SynthDef('vocoder-chord',{arg freq = 200, amp = 1,gate=1;
	var env = EnvGen.kr(Env.adsr(sustainLevel: 1),gate,doneAction: 2);
	var input = SoundIn.ar();
	var intervals = (3.collect({|i|[0]+(i*12)})).flat;
	var combs = Array.fill(intervals.size,{|i|
		var combFreq = freq.lag(0.1) * intervals[i].midiratio;
		//var combFreq = freq.lag(0.1) * (i+1);
		CombC.ar(input*0.01,combFreq.reciprocal,combFreq.reciprocal,1);
	});
	var sound = Mix([combs]);
	Out.ar(0,Pan2.ar(sound*env*100,0,amp));
}).add;
)
x = Synth('vocoder-chord');
x.free