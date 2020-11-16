~backVol = Bus.control(s);
(
SynthDef('back',{
	arg freq, amp;
	Out.ar(0,Pan2.ar(SinOsc.ar(freq.lag(0.2),
		mul:~backVol.kr.linexp(0,127,0.001,0.1)
)));
}).add;
)
~calcRate = Bus.control(s);
~calcPan = Bus.control(s);
~calcVol = Bus.control(s);
(
SynthDef('calculator',{
	arg freq;
	var raw_rate =~calcRate.kr.linexp(0,127,1,20);
	var rate = raw_rate ; //* LFTri.kr(0.5,mul: raw_rate * 0.3,add: 1);
	var pan = SinOsc.ar(0.6);
	//var pan = ~calcPan.kr.linlin(0,127,-20,20,'clip');
	var amp = ~calcVol.kr.linexp(0,127,0.001,0.5);
	var trig = Impulse.kr(rate);
	var freqs = Array.fill(6,{|i|
		if(i == 0,{freq},{(i / (i+1)) * freq})});
	var sound = LFTri.ar(TChoose.kr(trig,freqs).lag(rate.reciprocal*0.2));
	Out.ar(0,Pan2.ar(sound,pan,amp));
}).add;
)

//MICROPHONE IN
(
SynthDef('aesthetic',{
	Out.ar(0,In.ar(0)*0.5);
}).add;
x = Synth('aesthetic');
)
~vapVol = Bus.control(s);
~vapPan = Bus.control(s);
(
SynthDef('vapor',{
	arg freq,gate=1;
	var bell = PMOsc.ar(freq*1,freq*4.07982,4) * EnvGen.kr(Env.perc(releaseTime: 0.02),gate);
	var body = SinOsc.ar(SinOsc.ar(freq*2.087)+freq + SinOsc.ar(5,mul: freq*0.02));
	var body_env = EnvGen.kr(Env.adsr(0.175,0.55,0.4,0.4),gate,doneAction: 2);
	var noise = WhiteNoise.ar * EnvGen.kr(Env(times: [0.5,0.2]),gate);
	var mix = Mix([bell*0.025, body*body_env*1.0, noise*body_env*0.019]);
	var sound = RLPF.ar(mix,XLine.kr(5000,500,0.125),0.2,);
	Out.ar(0,Pan2.ar(sound,~vapPan.kr,~vapVol.kr))

}).add;
)
~grainTrig = Bus.control(s)
~grainDur = Bus.control(s)
~grainPan = Bus.control(s)
~grainVol = Bus.control(s)
//THINKING MORE OF A GATE
(
SynthDef('grain',{
	var in = LocalIn.ar();
	var mod = SinOsc.ar(100 + in,mul: 500);
	var car = SinOsc.ar(69 + mod,mul:0.8);
	var fb = LocalOut.ar(car * 0.01);
	var sound = GrainIn.ar(2,
		Dust.kr(~grainTrig.kr),~grainDur.kr,car,~grainPan.kr);
	Out.ar(0,sound*~grainVol.kr);
}).add;
)
x = Synth('grain');
x.free;