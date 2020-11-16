(
//CmdPeriod.run;
MIDIClient.init;
MIDIIn.connectAll;


~sequence = Array.newClear;

MIDIdef.noteOn('sequence_record',{|val,nn,chan,src|
	~sequence = ~sequence.add(nn);
});
)


~sequence;

