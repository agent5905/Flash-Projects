import caurina.transitions.*;

var tabs = 0;
var bug = 0;
var aname = "";
var astatus = "";
var aloc = "";

popup._visible = false;

var conn:LocalConnection;
conn=new LocalConnection();
conn.allowDomain ("*");
conn.connect ("dispatch");

conn.callback = function(txt:String ) {
    popup.popinfo.text = txt;
	pop();
};

map.motionguide.bug1.siren._visible = false;
map.bug2.siren._visible = false;
map.bug3.siren._visible = false;

map.motionguide.bug1.butt.onRelease = function() {
	 buttonPressed(1);
}

map.bug2.butt.onRelease = function() {
	 buttonPressed(2);
}

map.bug3.butt.onRelease = function() {
	 buttonPressed(3);
}

tab.call911.onRelease = function() {
	 if(tab.agentname.text == "Agent Garcia"){
		 conn.send ("gps2", 'callsent');
		 trace("sent to gps");
	 }else{
		 conn.send ("gps3", 'callsent');
		 trace("sent to gps2");
	 }
}
popup.onRelease = function() {
	popdown();
}
function pop() {
popup._visible = true;
popup._xscale = 0;
popup._yscale = 0;
Tweener.addTween(popup, {_xscale:100,_yscale:100, time:.25, transition:"linear"})
}

function popdown() {

Tweener.addTween(popup, {_xscale:0,_yscale:0, time:.25, transition:"linear",onComplete: function() {popup._visible = true;}})
}

function buttonPressed(bugval:Number) {
	
switch (bug) { 
    case 1 : 
        map.motionguide.bug1.siren._visible = false;
		map.motionguide.bug1.butt.enabled = true;
		break; 
    case 2 : 
		map.bug2.siren._visible = false;
		map.bug2.butt.enabled = true;
		break; 
    case 3 : 
 		map.bug3.siren._visible = false;
		map.bug3.butt.enabled = true;
		break; 
    default : 
	}
	
switch (bugval) { 
    case 1 : 
		map.motionguide.bug1.butt.enabled = false;
        map.motionguide.bug1.siren._visible = true;
		aname = "Agent Hogan";
		astatus = "Preceding to Job";
		aloc = "Moving...";
		bug = 1;
        break; 
    case 2 : 
		map.bug2.butt.enabled = false;
		map.bug2.siren._visible = true;
		aname = "Agent Garcia";
		astatus = "Available";
		aloc = "N Mansfield Ave";
		bug = 2;
        break; 
    case 3 : 
		map.bug3.butt.enabled = false;
 		map.bug3.siren._visible = true;
		aname = "Agent Blackmon";
		astatus = "Available";
		aloc = "The Grove Dr";
		bug = 3;
        break; 
    default : 
	}
	

if(tabs == 0){
	tab.agentname.text = aname;
	tab.agentstatus.text = astatus;
	tab.agentloc.text = aloc;
	updateAgent();
	Tweener.addTween(tab, {_y:402.3, time:1.5, transition:"easeOutBounce"});
	tabs = 1;
	}else{
	Tweener.addTween(tab, {_y:502.3, time:.5, transition:"linear"});
	Tweener.addTween(tab, {_y:402.3, time:1, transition:"easeOutBounce", delay:.7 });
	var agent:Number = setTimeout(updateAgent, 600); //2 Second Delay
	}

function updateAgent() {
	clearTimeout(agent);
	tab.agentname.text = aname;
	tab.agentstatus.text = astatus;
	tab.agentloc.text = aloc;
if (bug == 1){ 
		tab.call911._visible = false;
	}else{
		tab.call911._visible = true;
	}
	
}

}