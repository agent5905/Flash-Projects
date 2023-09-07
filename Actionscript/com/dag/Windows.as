//Windows.as
//var window:Windows = new Windows("StockTicker","Stock Ticker");
package dag{
	import flash.desktop.NativeApplication;
	import flash.display.BitmapData;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowResize;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowDisplayState;
	import flash.display.NativeWindowType;
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	
	public class Windows extends MovieClip
	{
		public var newMc:MovieClip;
		
		public function Windows( mcIName:String, title:String = "Window", x:uint = 0, y:uint = 0,width:uint = 0, height:uint = 0):void 
		{
			//create the init options 
			var winOptions:NativeWindowInitOptions = new NativeWindowInitOptions(); 
			winOptions.systemChrome = NativeWindowSystemChrome.STANDARD; 
			winOptions.type = NativeWindowType.NORMAL
			winOptions.transparent = false; 
			winOptions.resizable = false; 
			winOptions.maximizable = false;
			
			var tMC:Class = getDefinitionByName(mcIName) as Class;
			newMc = new tMC() as MovieClip;
			
			//create the window 
    		var newWindow:NativeWindow = new NativeWindow(winOptions); 
   		 	newWindow.title = title; 
    		newWindow.width = newMc.width + 6; 
    		newWindow.height = newMc.height + 32;
			newWindow.alwaysInFront = false;
    		newWindow.visible = true;
			newWindow.x = (Screen.mainScreen.visibleBounds.width - newWindow.width)/2
			newWindow.y = (Screen.mainScreen.visibleBounds.height - newWindow.height)/2
			
			//add window content
			//newWindow.stage.stageHeight = 232.9;
        	//newWindow.stage.stageWidth = 603;
        	newWindow.stage.scaleMode = StageScaleMode.NO_SCALE;
        	newWindow.stage.align = StageAlign.TOP_LEFT;
			
			
			newWindow.stage.addChild(newMc);
			
			//activate and show window
			newWindow.activate();
		}
		
		
   
     
     
     
 
				
	}
}