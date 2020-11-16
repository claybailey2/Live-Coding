(
SynthDef('drone',{|out=0,fund=40, mcratio=4.20, mindex=8.12, gate=1|
	var env = EnvGen.kr(
		Env.adsr(0.2,0.1,0.8,0.2),
		gate,
		doneAction:2
	);
	var mod = SinOsc.ar(fund * mcratio,mul: fund * mindex);
	var cars = Array.fill(4,{|i|
		var detune = 1 + 0.2.rand2;
		var freq = fund * (10.pow(1/3)).pow(i) * detune;
		var amp = if (i==0,{1},{0.5.rand + 0.2});
		SinOsc.ar(freq + mod,mul: amp);
	});

	var sound = Mix(cars).softclip(0.95);
	Out.ar(out,Pan2.ar(sound*env));
}).add;
)

(
SynthDef('filter-rise',{|in,out=0,dur,gate=1,amp|
	var input = In.ar(in,2);
	var env = EnvGen.kr(Env(
		[200,200,1000,200],
		[0,dur/t.tempo-0.1,0.1],
		3
	),'trig'.tr()
	);
	var filt = RLPF.ar(input,env,0.15);
	Out.ar(out,filt*amp);
}).add;
)
(
SynthDef('kick',{
	var env = EnvGen.kr(Env.perc(releaseTime: 0.2),'trig'.tr());
	Out.ar(0,Pan2.ar(SinOsc.ar(72),level: env))
}).add;
)
(
SynthDef('snare',{|out = 0|
	var env = EnvGen.kr(Env.perc(releaseTime: 0.1),'trig'.tr());
	var filt = RHPF.ar( WhiteNoise.ar,XLine.kr(1500,200,0.1),0.3);
	Out.ar(out,Pan2.ar(filt,level: env))
}).add;
)
(
SynthDef('verb',{arg amp,in;
	var input = In.ar(in,2);
	var verb = FreeVerb.ar(input);
	Out.ar(0,(
		(input*3) +
		(Pan2.ar(verb,
			Select.kr(
				Saw.kr(3,add:1).floor,
				[-1,1]
		))*7)
	)/10*amp);
}).add;
)
(
SynthDef('hh',{arg amp;
	var env = EnvGen.kr(Env.perc(releaseTime: 0.05),'trig'.tr());
	var filt = RHPF.ar( WhiteNoise.ar,XLine.kr(15000,3000,0.05),0.3);
	Out.ar(0,Pan2.ar(filt,level: env*amp))
}).add;
)
(
SynthDef('crash',{arg amp;
	var env = EnvGen.kr(Env.perc(releaseTime: 2),'trig'.tr());
	var filt = RHPF.ar( WhiteNoise.ar,LFTri.kr(8).linexp(-1,1,2000,15000),0.3);
	Out.ar(0,Pan2.ar(filt,level: env*amp))
}).add;
)
(
SynthDef('arp',{|gate=1, freq, amp,dur|
	var env = EnvGen.kr(Env.linen(
		sustainTime:(dur/t.tempo)-0.02,
		releaseTime: 0.01),'trig'.tr());
	var sound = Mix([
		Saw.ar(LFSaw.ar(18,mul: 20,add: freq)),
		BPF.ar(
			PMOsc.ar(freq/4.186,freq*1.618,69),freq*4,0.1)
	]);
	Out.ar(0,Pan2.ar(sound,LFTri.kr(0.25/t.tempo),env*amp));
}).add;
)
(
SynthDef('tom',{|freq,gate,amp|
	var env = EnvGen.kr(Env.perc(releaseTime: 0.5),'trig'.tr(),doneAction:2);
	//bpf fm sq noise in mid
	var fmnoise = FreeVerb.ar(Saw.ar(freq + SinOsc.ar(freq*12.3456, mul: 10000)),0.5,0.7,0.8);
	var bpf = BPF.ar(fmnoise,freq*2,1);
	//click
	var click = EnvGen.kr(Env.perc(0.002,0.005),'trig'.tr())*WhiteNoise.ar;
	//resonant
	var res = Mix([SinOsc.ar(freq),SinOsc.ar(freq+3.4)]);
	var sound = LPF.ar(Mix([bpf,res,click]),6000);
	Out.ar(0,Pan2.ar(sound)*env*amp);
}).add;
)