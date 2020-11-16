s.options.outDevice_("out + black hole");
(
s.boot;
s.waitForBoot({
	SynthDef('simp', {
		|freq,amp,gate=1|
		var sound, env, out;
		sound = SinOsc.ar(freq.lag());
		env = EnvGen.kr(Env.adsr,gate,doneAction: 2);
		out = Out.ar(0,sound * env * amp);
	}).add;

	SynthDef('accent', {
		|freq,amp, t_gate = 1|
		var carrier,modulator,env,out;
		//for noise: fm square/saw waves
		// modulator = Saw.ar(freq * MouseX.kr(1,4).poll(0.5),freq * MouseY.kr(0,10).poll(0.5)); // testing
		modulator = Saw.ar(freq * 1.99834,freq * 2.87673); //crash with dolphins

		//modulator = Saw.ar(freq *1.30538, 568.048);//swoop up with echo
		carrier = Saw.ar(freq + modulator);

		env = EnvGen.kr(Env.perc,t_gate);
		out = Out.ar(1,carrier * env * amp);
	}).add;

	SynthDef('lead',{
		|freq,amp,gate=1|
		var filtenv,detune,organ_muls,vibrato,organ,sound,env,out;
		filtenv = EnvGen.kr(Env([freq/2,freq*7, freq*2],[0.2,0.8],3),gate);
		//hammond organ, with vibrato and detune
		vibrato = { |in_amp| SinOsc.ar(5 + 0.5.rand2, phase:1.rand, mul:in_amp * 0.2) };
		detune = 0.002;

		organ_muls = [0.7,0.5,0.4,0.07,0.1,0.05,0.03];
		organ = Array.fill(organ_muls.size,{|i|SinOsc.ar(freq*(i+1) * (1 + detune.rand2) + vibrato.(organ_muls[i]), mul:organ_muls[i] );});

		sound = LPF.ar(Mix(organ),filtenv);
		env = EnvGen.kr(Env.adsr(0.1,0.3,0.1,0.2),gate,doneAction: 2);
		out = Out.ar(0,Pan2.ar(sound * env * amp));
	}).add;

	SynthDef('mcfm-grain', {
		|freq, amp|
		var mod, car1, car2, car3, mcfm, trig, grain_dur, grain, out;
		mod = SinOsc.ar(freq * 2, mul: freq * 3.2);

		car1 = SinOsc.ar(freq + mod);
		car2 = SinOsc.ar(freq * 4.03 + mod);
		car3 = SinOsc.ar(freq * 7.09 + mod);
		mcfm = Mix([car1,car2,car3]);
		trig = Impulse.kr(MouseX.kr(1,50).poll);
		grain_dur = MouseY.kr(0.005, 0.5).linexp(0.005,0.5,0.005,0.5).poll;
		grain = GrainIn.ar(
			numChannels: 2,
			trigger: trig,
			dur: grain_dur,
			in: mcfm,
			pan: 0,
			mul: amp
		);
		out = Out.ar(0,grain);

	}).add;

	//song data
	~leadnotes = [ 55, 53, 52, 53, 52, 50, 52, 48, 50, 47 ];
	~leaddurs = [ 0.4375, 0.25, 0.25, 0.5625, 0.1875, 0.25, 0.5, 0.5, 0.4375, 0.375 + 0.25 ];
	~leadamps = [ 94, 107, 70, 107, 72, 72, 81, 78, 86, 87 ].linexp(1,127,0.01,0.7);

	//end song data

	//patterns

	~repeats = 4;

	Pmono(
		'simp',
		'note',Pseq([0,4,5,7,0,7,4,2],~repeats * 2),
		'dur',0.25,
		'amp',0.2
	).play;

	Pbind(
		'instrument','accent',
		'dur',Pseq([0.375,0.375,Rest(1.25)],inf),
		'amp',0.1,
		'midinote',Pseq([72,79,Rest(),69,72,Rest()],~repeats)
	).play;

	Pbind(
		'instrument','lead',
		'octave',5,
		'midinote',Pseq(~leadnotes,~repeats),
		'dur',Pseq(~leaddurs,~repeats),
		'amp',Pseq(~leadamps,~repeats)
	).play;

	Pbind(
		'instrument','lead',
		'octave',2,
		'degree',Pseq([8,6,5],~repeats),
		'dur',Pseq([2,1,1],inf),
		'amp',0.8,
		'legato',1
	).play;

	/*Synth('mcfm-grain',[
		'freq',216/2,
		'amp',0.6]
	);*/

});
)