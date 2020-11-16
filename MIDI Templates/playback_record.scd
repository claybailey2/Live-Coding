(
//CmdPeriod.run;
s.boot;
MIDIClient.init;
MIDIIn.connectAll;

a = {Metro.ar(60, 1)!2 * 0.3}.play;
t = TempoClock.default;
t.tempo = 152/60;

//[timestamp,nn,val] format
~raw_playback = Array();
~synths = Array.fill(128,{nil});

MIDIdef.noteOn('playback_record_noteOn',{|val,nn,ch,src|
	~raw_playback = ~raw_playback.add([t.beats,nn,val]);

	//play lead synth here
	~synths[nn] = Synth(      'lead', //CHANGE MONITOR VOICE HERE
		[
			'freq',nn.midicps,
			'amp',val.linexp(1,127,0.01,0.15),
			'gate',1
		]
	)

});

MIDIdef.noteOff('playback_record_noteOff',{|val,nn,ch,src|
	~raw_playback = ~raw_playback.add([t.beats,nn,val]);

	~synths[nn].set('gate',0);
});

~quantize = {|data,subdivision|
	var data_cpy = Array.newClear;
	data.do({|val|
		var qt_start, qt_dur;
		qt_start = val[0].round(1/subdivision);
		qt_dur = val[3].round(1/subdivision);
		data_cpy = data_cpy.add([qt_start,val[1],val[2],qt_dur]);
	});
	data_cpy;
};
)
// ^^^ START RECORD ^^^

//~result = ~playback;
~result  = ~quantize.(~playback,16); //AFTER DONE RECORDING: CHANGE ARG TO MIN SUBDIVISION

~starts = ~result.collect{|note| note[0]};
~notes = ~result.collect{|note| note[1]};
~velocities = ~result.collect{|note| note[2]};
~durations = ~result.collect{|note| note[3]};

// VVV END RECORD VVV
(
a.free;


//post analysis
//[timing,nn,val,duration] format
~start = ~raw_playback[0][0];
~timestamps = Array.fill(128,{ nil });
~vals = Array.fill(128, { nil });
~playback = Array.newClear;
~raw_playback.do({|data|
	var timestamp = data[0], nn = data[1], val = data[2];
	if (val > 0,
		//note on
		{ //cache
			~timestamps[nn] = timestamp;
			~vals[nn] = val;
		},
		//note off
		{
			~playback = ~playback.add([
				~timestamps[nn] - ~start,
				nn,
				~vals[nn],
				timestamp - ~timestamps[nn]; //time of note off - time of note on
			]);
		}
	);
});

~playback;
)

~quantize.(~playback,8);



