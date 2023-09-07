package dag{    
import flash.display.DisplayObject;    
import flash.events.Event;

//***example***
//var customEvent:CustomEvent = new CustomEvent("Success");
//dispatchEvent(customEvent);
//.addEventListener("Success", yourfunction);


public class CustomEvent extends Event {        
private var customAsset:DisplayObject;   

function CustomEvent(type:String) :void {            
super(type);        
}   

public function addAsset(customAsset:DisplayObject):void {            
this.customAsset = customAsset;        
}   

public function get asset():DisplayObject {            
return customAsset;        
}    
}} 