﻿import caurina.transitions.*;
mapv.vcall._visible = false;
mapv.route._visible = false;
mapv.arrow._visible = false;


	var conn2:LocalConnection = new LocalConnection();
	conn2.client= this;
	conn2.connect ("gps3");
conn2.callsent = function() {
    incomingCall();
};



mapv.infobar.viewbutton.onRelease = function() {
	 viewCall();
}

mapv.vcall.acceptb.onRelease = function() {
	 acceptCall();
}

mapv.vcall.declineb.onRelease = function() {
	 declineCall()
}



function incomingCall() {
Tweener.addTween(mapv.infobar, {_y:-.8, time:1, transition:"linear"});
}

function viewCall() {
	
mapv.vcall._visible = true;
mapv.infobar._y = -23.3;

mapv.vcall.cname.text = "John Wolpert";
mapv.vcall.cphone.text = "(909) 123-2536";
mapv.vcall.cquote.text = "$699.99";
mapv.vcall.cnote.text = "Client is requesting an agent to come fix his computer due to a virus infection. Client has very important data on his PC and needs it to be recovered";
}

function acceptCall() {
	conn.send ("dispatch2", 'callback',"Agent Blackmon has accepted the call");
mapv.vcall._visible = false;
mapv.dbar.dinfo.text = "Calculating route...";
Tweener.addTween(mapv.dbar, {_y:-.8, time:1, transition:"linear"});

var changebar:Number = setTimeout(updateBar, 2000,0); //2 Second Delay
}

function updateBar(arg) {
	clearTimeout(changebar);
	switch (arg) { 
    case 0 : 
        mapv.dbar.dinfo.text = "Route calculated...";
		var changebar:Number = setTimeout(updateBar, 2000,1); //2 Second Delay
        break; 
    case 1 : 
       	mapv.dbar.dinfo.text = "Proceed down Main St.";
		
		mapv.route._visible = true;
		mapv.arrow._visible = true;
        break; 
    default : 
        
	}

}

function declineCall() {
	
mapv.vcall._visible = false;
conn2.send ("dispatch", 'callback',"Agent Blackmon has declined the call");

}

/////////////////////Bug Movin Script///////////////////////////
function setup() {
mapv.hbar._height = 5;
mapv.hbar._y = -6.9;
}

//repeat();
function repeat() {
Tweener.addTween(mapv.hbar, {_height:10, _y:130.6, time:15, transition:"linear",onStart:setup, onComplete:repeat});
}
