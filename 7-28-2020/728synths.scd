(
SynthDef('728kick',{|velocity,pan|
	var click_env,click, body_env,body, kick,amp, out;
	//click = noise with sharp env
	click_env = EnvGen.kr(
		Env(times: [ 0.005 , 0.005 ] ));
	click = PinkNoise.ar() * click_env;
	//body  = longer, pitched
	body_env = EnvGen.kr(
		Env(times: [ 0.010, 0.070 ] ),
		doneAction: 2
	);
	body = SinOsc.ar(69) * body_env;
	kick = Mix([click * 0.2, body * 1]);
	amp = velocity.linexp(1,127,0.01,0.8);
	out = Out.ar(0,Pan2.ar(kick,pan) * amp);
}).add;


SynthDef('728clap',{|velocity,pan|
	var noise, click_env, click, body_env, body, filt, clap, amp, out;
	noise = WhiteNoise.ar;
	click_env = EnvGen.kr(
		Env(times: [ 0.010 , 0.005 ] ));
	click = noise * click_env;
	//body  = array of bandpassed noise attacks
	body_env = EnvGen.kr(
		Env([0,1,0.25,0],[ 0.015,0.004, 0.110 ] ,curve: 3),
		doneAction: 2
	);
	//TODO: find a way to randomize all these band freqs
	body = Array.fill(11, {|i|
		BPF.ar(noise, 1500 + (50*(i-5)*Rand()), 0.06,);
	}) * body_env;
	filt = RHPF.ar(body,XLine.kr(500,3500,0.1),0.02);
	clap = Mix([click * 0.1, body * 5]);
	amp = velocity.linexp(1,127,0.01,0.8);
	out = Out.ar(0,Pan2.ar(clap,pan) * amp);
}).add;


SynthDef('728lead',{|freq,velocity,pan,gate=1|
	var lfo, osc1, osc2, lead_env,lead,amp, out;
	lfo = SinOsc.ar(5,mul:freq*0.1.midiratio);
	osc1 = Pulse.ar(freq);
	osc2 = LFTri.ar(freq*3*0.2.midiratio);
	lead_env = EnvGen.kr(
		Env.adsr(0.005,0.01,0.4,0.2),
		gate,
		doneAction: 2
	);
	lead = Mix([osc1 * 3,osc2 * 1]) * lead_env;
	amp = velocity.linexp(1,127,0.01,0.8);
	out = Out.ar(0,Pan2.ar(lead,pan) * amp);
}).add;


)