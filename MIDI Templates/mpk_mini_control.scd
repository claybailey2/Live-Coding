(
CmdPeriod.run;
s.boot;
MIDIClient.init;
MIDIIn.connectAll;

//knobs
MIDIdef.cc('mpk_mini_k1',{|val,kn,chan,src| /*program logic here*/ },1);
MIDIdef.cc('mpk_mini_k2',{|val,kn,chan,src|},2);
MIDIdef.cc('mpk_mini_k3',{|val,kn,chan,src|},3);
MIDIdef.cc('mpk_mini_k4',{|val,kn,chan,src|},4);
MIDIdef.cc('mpk_mini_k5',{|val,kn,chan,src|},5);
MIDIdef.cc('mpk_mini_k6',{|val,kn,chan,src|},6);
MIDIdef.cc('mpk_mini_k7',{|val,kn,chan,src|},7);
MIDIdef.cc('mpk_mini_k8',{|val,kn,chan,src|},8);

MIDIdef.cc('mpk_mini_pad1',{|val,kn,chan,src|
	if ( val > 0,
		{ /*button on*/ },
		{ /*button off*/}
);},20);
MIDIdef.cc('mpk_mini_pad2',{|val,kn,chan,src|
	if ( val > 0,
		{ /*button on*/ },
		{ /*button off*/}
);},21);
MIDIdef.cc('mpk_mini_pad3',{|val,kn,chan,src|
	if ( val > 0,
		{ /*button on*/ },
		{ /*button off*/}
);},22);
MIDIdef.cc('mpk_mini_pad4',{|val,kn,chan,src|
	if ( val > 0,
		{ /*button on*/ },
		{ /*button off*/}
);},23);
MIDIdef.cc('mpk_mini_pad5',{|val,kn,chan,src|
	if ( val > 0,
		{ /*button on*/ },
		{ /*button off*/}
);},24);
MIDIdef.cc('mpk_mini_pad6',{|val,kn,chan,src|
	if ( val > 0,
		{ /*button on*/ },
		{ /*button off*/}
);},25);
MIDIdef.cc('mpk_mini_pad7',{|val,kn,chan,src|
	if ( val > 0,
		{ /*button on*/ },
		{ /*button off*/}
);},26);
MIDIdef.cc('mpk_mini_pad8',{|val,kn,chan,src|
	if ( val > 0,
		{ /*button on*/ },
		{ /*button off*/}
);},27);
MIDIdef.cc('mpk_mini_pad9',{|val,kn,chan,src|
	if ( val > 0,
		{ /*button on*/ },
		{ /*button off*/}
);},28);
MIDIdef.cc('mpk_mini_pad10',{|val,kn,chan,src|
	if ( val > 0,
		{ /*button on*/ },
		{ /*button off*/}
);},29);
MIDIdef.cc('mpk_mini_pad11',{|val,kn,chan,src|
	if ( val > 0,
		{ /*button on*/ },
		{ /*button off*/}
);},30);
MIDIdef.cc('mpk_mini_pad12',{|val,kn,chan,src|
	if ( val > 0,
		{ /*button on*/ },
		{ /*button off*/}
);},31);
MIDIdef.cc('mpk_mini_pad13',{|val,kn,chan,src|
	if ( val > 0,
		{ /*button on*/ },
		{ /*button off*/}
);},32);
MIDIdef.cc('mpk_mini_pad14',{|val,kn,chan,src|
	if ( val > 0,
		{ /*button on*/ },
		{ /*button off*/}
);},33);
MIDIdef.cc('mpk_mini_pad15',{|val,kn,chan,src|
	if ( val > 0,
		{ /*button on*/ },
		{ /*button off*/}
);},34);
MIDIdef.cc('mpk_mini_pad16',{|val,kn,chan,src|
	if ( val > 0,
		{ /*button on*/ },
		{ /*button off*/}
);},35);

MIDIdef.bend('mpk_mini_joystick_x',{|val| /*0-8192-16383*/});
//joystick_y maps to same as k1
)