(
//CmdPeriod.run;
s.boot;
MIDIClient.init;
MIDIIn.connectAll;

//sliders x 2 banks
MIDIdef.cc('graphite_49_s1a',{|val|
	~backVol.set(val);
},7,0);
MIDIdef.cc('graphite_49_s2a',{|val|
	~calcVol.set(val);
},7,1);
MIDIdef.cc('graphite_49_s3a',{|val|
	~vapVol.set(val.linexp(0,127,0.001,0.5));
},7,2);
MIDIdef.cc('graphite_49_s4a',{|val|
	~grainVol.set(val.linexp(0,127,0.001,0.8))
},7,3);
MIDIdef.cc('graphite_49_s5a',{|val|},7,4);
MIDIdef.cc('graphite_49_s6a',{|val|},7,5);
MIDIdef.cc('graphite_49_s7a',{|val|},7,6);
MIDIdef.cc('graphite_49_s8a',{|val|},7,7);

MIDIdef.cc('graphite_49_s1b',{|val|},7,8);
MIDIdef.cc('graphite_49_s2b',{|val|},7,9);
MIDIdef.cc('graphite_49_s3b',{|val|},7,10);
MIDIdef.cc('graphite_49_s4b',{|val|},7,11);
MIDIdef.cc('graphite_49_s5b',{|val|},7,12);
MIDIdef.cc('graphite_49_s6b',{|val|},7,13);
MIDIdef.cc('graphite_49_s7b',{|val|},7,14);
MIDIdef.cc('graphite_49_s8b',{|val|},7,15);


//knobs x 2 banks
MIDIdef.cc('graphite_49_e1a',{|val|
	~calcRate.set(val);
},10,0);
MIDIdef.cc('graphite_49_e2a',{|val|
	~vapPan.set(val.linlin(0,127,-1.0,1.0));
},10,1);
MIDIdef.cc('graphite_49_e3a',{|val|
	~grainTrig.set(val.linlin(0,127,1,8).floor * 2 / t.tempo);
},10,2);
MIDIdef.cc('graphite_49_e4a',{|val|
	~grainDur.set(val.linexp(0,127,0.005,0.1));
},10,3);
MIDIdef.cc('graphite_49_e5a',{|val|
	~grainPan.set(val.linlin(0,127,-1.0,1.0));
},10,4);
MIDIdef.cc('graphite_49_e6a',{|val|},10,5);
MIDIdef.cc('graphite_49_e7a',{|val|},10,6);
MIDIdef.cc('graphite_49_e8a',{|val|},10,7);

MIDIdef.cc('graphite_49_e1b',{|val|},10,8);
MIDIdef.cc('graphite_49_e2b',{|val|},10,9);
MIDIdef.cc('graphite_49_e3b',{|val|},10,10);
MIDIdef.cc('graphite_49_e4b',{|val|},10,11);
MIDIdef.cc('graphite_49_e5b',{|val|},10,12);
MIDIdef.cc('graphite_49_e6b',{|val|},10,13);
MIDIdef.cc('graphite_49_e10b',{|val|},10,14);
MIDIdef.cc('graphite_49_e8b',{|val|},10,15);


//buttons
MIDIdef.cc('graphite_49_f1',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},16,0);
MIDIdef.cc('graphite_49_f2',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},17,0);
MIDIdef.cc('graphite_49_f3',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},18,0);
MIDIdef.cc('graphite_49_f4',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},19,0);
MIDIdef.cc('graphite_49_f5',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},20,0);
MIDIdef.cc('graphite_49_f6',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},21,0);
MIDIdef.cc('graphite_49_f7',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},22,0);
MIDIdef.cc('graphite_49_f8',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},23,0);
MIDIdef.cc('graphite_49_f9',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},24,0);
MIDIdef.cc('graphite_49_f10',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},25,0);
MIDIdef.cc('graphite_49_f11',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},26,0);
MIDIdef.cc('graphite_49_f12',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},27,0);
MIDIdef.cc('graphite_49_f13',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},28,0);
MIDIdef.cc('graphite_49_f14',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},29,0);
MIDIdef.cc('graphite_49_f15',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},30,0);
MIDIdef.cc('graphite_49_f16',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},31,0);


//4 pads x 2 pad-banks
MIDIdef.noteOn('graphite_49_p1a',{|val,nn,ch,src|},36,9);
MIDIdef.noteOff('graphite_49_p1a',{|val,nn,ch,src|},36,9);
MIDIdef.noteOn('graphite_49_p2a',{|val,nn,ch,src|},37,9);
MIDIdef.noteOff('graphite_49_p2a',{|val,nn,ch,src|},37,9);
MIDIdef.noteOn('graphite_49_p3a',{|val,nn,ch,src|},38,9);
MIDIdef.noteOff('graphite_49_p3a',{|val,nn,ch,src|},38,9);
MIDIdef.noteOn('graphite_49_p4a',{|val,nn,ch,src|},39,9);
MIDIdef.noteOff('graphite_49_p4a',{|val,nn,ch,src|},39,9);

MIDIdef.noteOn('graphite_49_p1b',{|val,nn,ch,src|},40,9);
MIDIdef.noteOff('graphite_49_p1b',{|val,nn,ch,src|},40,9);
MIDIdef.noteOn('graphite_49_p2b',{|val,nn,ch,src|},41,9);
MIDIdef.noteOff('graphite_49_p2b',{|val,nn,ch,src|},41,9);
MIDIdef.noteOn('graphite_49_p3b',{|val,nn,ch,src|},42,9);
MIDIdef.noteOff('graphite_49_p3b',{|val,nn,ch,src|},42,9);
MIDIdef.noteOn('graphite_49_p4b',{|val,nn,ch,src|},43,9);
MIDIdef.noteOff('graphite_49_p4b',{|val,nn,ch,src|},43,9);

//pad touch (not pad-specific)
MIDIdef.touch('graphite_49_touch',{|val,ch,src|
		~grainTrig.set(val.linlin(0,127,1,96) / t.tempo);
},9);


//other
MIDIdef.cc('graphite_49_modulation',{|val,ccNum,ch,src|},1,0);
MIDIdef.cc('graphite_49_rewind',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},116,0);
MIDIdef.cc('graphite_49_fastforward',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},117,0);
MIDIdef.cc('graphite_49_fastforward',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},117,0);
MIDIdef.cc('graphite_49_stop',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},118,0);
MIDIdef.cc('graphite_49_play',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},119,0);
MIDIdef.cc('graphite_49_record',{|val|
	if( val > 0,
		{/*button on*/},
		{/*button off*/}
	);},114,0);

//bend bar
MIDIdef.bend('graphite_49_bend',{|val| /*0-8192-16383*/});
)
