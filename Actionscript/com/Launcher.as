package
{
	import dag.GetDota;
	import dag.GetDotaIcon;
	import flash.display.Sprite;
	import flash.events.InvokeEvent;
	import flash.events.ErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.Scene;
	import flash.display.Stage;
	import caurina.transitions.*;
	import flash.display.Screen;
	import flash.display.NativeMenu; 
    import flash.display.NativeMenuItem; 
    import flash.desktop.SystemTrayIcon; 
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.filesystem.File;
	import flash.ui.*;
	import dag.GetDotaXML;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import dag.CustomEvent;
	import flash.utils.Timer;
    import flash.events.TimerEvent;
	
	
	public class Launcher
		extends Sprite
	{
		private var getDota = new GetDota();
		private var getDotaXML = new GetDotaXML();
		private var window:NativeWindow;
		private var settingsWindow:NativeWindow;
		private var aboutWindow:NativeWindow;
		private var mc:GetDotaMC = new GetDotaMC();
		private var mc3:AboutMC = new AboutMC();
		private var icon:GetDotaIcon = new GetDotaIcon()
		private var fristrun:Number = 0;
		private var userPresent:Number = 1;
		private var popUp:Number = 0;
		var current:Screen;
		var checkTimer:Timer = new Timer(60000,0);
		
		
			var xmlDes:String = "xml/getDota.xml";
			var url = "http://www.getdota.com/changelogs"; 
			var urlReq = new URLRequest(url);
			var firstrun:Number;
			private const idleTime:int = 15; //seconds

		public function Launcher()
		{
			icon.addEventListener(Event.COMPLETE,function():void{
				NativeApplication.nativeApplication.icon.bitmaps = icon.bitmaps;
			});
			icon.loadImages();
			
			getDota.addEventListener("SaveComplete",  function(event:Event):void {windowPopUp(getDota.getDotaMapName);});
			
			checkTimer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
			checkTimer.addEventListener(TimerEvent.TIMER, timerHandler);
						
			var systray:SystemTrayIcon = NativeApplication.nativeApplication.icon as SystemTrayIcon; 
            systray.tooltip = "Get DotA";
						
			var iconMenu:NativeMenu = new NativeMenu(); 
			//iconMenu.addItem(new NativeMenuItem("Get DotA v1.0"));
			//iconMenu.addItem(new NativeMenuItem("",true)); //separator
			var launchSettings:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Settings"));
			//var launchPopUp:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Pop Up"));
			//var forceDL:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Download Map Now"));
			var launchAbout:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("About"));
			iconMenu.addItem(new NativeMenuItem("",true)); //separator
       		var exitCommand:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Exit"));
						
			exitCommand.addEventListener(Event.SELECT, function(event:Event):void {NativeApplication.nativeApplication.icon.bitmaps = []; NativeApplication.nativeApplication.exit();});
			//launchPopUp.addEventListener(Event.SELECT, function(event:Event):void {windowPopUp("DotA Allstars v6.60");});
			//forceDL.addEventListener(Event.SELECT, function(event:Event):void {getDota.getCurrentDotaName();});;
			launchSettings.addEventListener(Event.SELECT, function(event:Event):void {displaySettings();});
			launchAbout.addEventListener(Event.SELECT, function(event:Event):void {displayAbout();});
						
						
            systray.menu = iconMenu;
			
			current = Screen.mainScreen
			
			
			NativeApplication.nativeApplication.idleThreshold = idleTime;
			NativeApplication.nativeApplication.addEventListener(Event.USER_IDLE,onIdle);
			NativeApplication.nativeApplication.addEventListener(Event.USER_PRESENT,onPresence);
			
			NativeApplication.nativeApplication.autoExit = false;
			stage.nativeWindow.close();  
			
			if(!File.applicationStorageDirectory.resolvePath(xmlDes).exists){
				firstrun = 1;
				createSettingsWindow();
				
			}else{
				firstrun = 0;
				getDotaXML.addEventListener(Event.COMPLETE,function():void{
					startTimer();
				});
				getDotaXML.getXML();
			
			}
			
			
			

	
		}
		
			private function createWindow():void {
    		if (window == null) {
        		var options:NativeWindowInitOptions = new NativeWindowInitOptions();
        		options.systemChrome = NativeWindowSystemChrome.NONE;
				options.transparent = true;
        		options.type = NativeWindowType.LIGHTWEIGHT;
        		options.maximizable = false;
				options.minimizable = false;
				options.resizable = false;
        		window = new NativeWindow(options);
        		window.x = current.visibleBounds.right - 267;
        		window.y = current.visibleBounds.bottom - 100;
        		window.stage.stageHeight = 100;
        		window.stage.stageWidth = 267;
        		window.stage.scaleMode = StageScaleMode.NO_SCALE;
        		window.stage.align = StageAlign.TOP_LEFT;
				
				window.stage.addChild(mc);
				mc.y = 101;
        		
				window.alwaysInFront = true;
    			window.visible = true;
				window.addEventListener(Event.CLOSE, function(event:Event):void {window = null;});
				mc.addEventListener(MouseEvent.CLICK, function(event:Event):void {navigateToURL(urlReq);});
				mc.addEventListener(MouseEvent.MOUSE_OVER, function(event:Event):void {Mouse.cursor = MouseCursor.BUTTON});
				mc.addEventListener(MouseEvent.MOUSE_OUT, function(event:Event):void {Mouse.cursor = MouseCursor.ARROW});
    		}
    			
				
		}
	
	private function createSettingsWindow():void {
    		if (settingsWindow == null) {
        		var options:NativeWindowInitOptions = new NativeWindowInitOptions();
        		options.systemChrome = NativeWindowSystemChrome.NONE;
				options.transparent = true;
        		options.type = NativeWindowType.NORMAL;
        		options.maximizable = false;
				options.minimizable = false;
				options.resizable = false;
        		settingsWindow = new NativeWindow(options);
        		settingsWindow.x = (Screen.mainScreen.visibleBounds.width - 267)/2
				settingsWindow.y = (Screen.mainScreen.visibleBounds.height - 235)/2
        		settingsWindow.stage.stageHeight = 235;
        		settingsWindow.stage.stageWidth = 267;
        		settingsWindow.stage.scaleMode = StageScaleMode.NO_SCALE;
        		settingsWindow.stage.align = StageAlign.TOP_LEFT;
				
				var mc2:SettingsMC = new SettingsMC();
				
				settingsWindow.stage.addChild(mc2);
				settingsWindow.title = "Settings"
				
				if(firstrun == 0){
					settingsWindow.addEventListener(Event.CLOSE, function(event:Event):void {settingsWindow = null;});
				}else{
					settingsWindow.addEventListener(Event.CLOSE, settingsFirstRun);
							
				}
				        		
    		}
    			//mc2.btnCancel.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void {settingsWindow.close();});
				settingsWindow.visible = true;
				settingsWindow.orderToFront();
		}
		
		private function settingsFirstRun(event:Event):void
		{
			getDota.getCurrentDotaName();
			//getDota.addEventListener("SaveComplete",  function(event:Event):void {windowPopUp(getDota.getDotaMapName);});
			firstrun = 1;
			settingsWindow.removeEventListener(Event.CLOSE, settingsFirstRun);
			settingsWindow = null;
			startTimer();
		}
		
	private function createAboutWindow():void {
    		if (aboutWindow == null) {
        		var options:NativeWindowInitOptions = new NativeWindowInitOptions();
        		options.systemChrome = NativeWindowSystemChrome.NONE;
				options.transparent = true;
        		options.type = NativeWindowType.NORMAL;
        		options.maximizable = false;
				options.minimizable = false;
				options.resizable = false;
        		aboutWindow = new NativeWindow(options);
        		aboutWindow.x = (Screen.mainScreen.visibleBounds.width - 267)/2
				aboutWindow.y = (Screen.mainScreen.visibleBounds.height - 235)/2
        		aboutWindow.stage.stageHeight = 235;
        		aboutWindow.stage.stageWidth = 267;
        		aboutWindow.stage.scaleMode = StageScaleMode.NO_SCALE;
        		aboutWindow.stage.align = StageAlign.TOP_LEFT;
				
				aboutWindow.stage.addChild(mc3);
				aboutWindow.title = "About";
				
				aboutWindow.addEventListener(Event.CLOSE, function(event:Event):void {aboutWindow = null;});
    		}
    			
				
				aboutWindow.visible = true;
		}
		
		
	public function displaySettings():void
		{
			createSettingsWindow();			
		}
	
	public function displayAbout():void
		{
			createAboutWindow();
			
			
		}
	
	
	public function windowPopUp(strMap:String):void
		{
			if(getDotaXML.xmlAlert){
			createWindow();
			mc.mapVer.text = strMap;
			Tweener.addTween(mc, {y:0, time:2 });
			popUp = 1;
				if(userPresent != 0){
				Tweener.addTween(mc, {y:101, time:2,delay:4,onComplete: function() {window.close();} });
				popUp = 0;
				}
			}
			
		}
		
	public function startTimer():void
		{
			var timeCheck:Number;
			
			switch(getDotaXML.xmlCheck){
			
			case 0:
			timeCheck = 1;
			break;
			case 1:
			timeCheck = 30;
			break;
			case 2:
			timeCheck = 60;
			break;
			case 3:
			timeCheck = 120;
			break;
			case 4:
			timeCheck = 240;
			break;
			case 5:
			timeCheck = 360;
			break;
			case 6:
			timeCheck = 720;
			break;
			case 7:
			timeCheck = 1440;
			break;
		}
			checkTimer.repeatCount = timeCheck;
			
			checkTimer.start();
			trace("Timer started " + timeCheck + " mins");
		}
		
		private function timerComplete(e:TimerEvent):void {
            trace("Checking Map Ver");
               getDota.getCurrentDotaName();
			   checkTimer.reset();
			   checkTimer.start();
				
        }
		
		private function timerHandler(e:TimerEvent):void{
            trace(checkTimer.currentCount);
        }
		 
		//When the computer is idle, don't remove the messages
		private function onIdle(event:Event):void{
			trace("Idling.");
			userPresent = 0;
		}
		
		//On return, let windows expire again
		private function onPresence(event:Event):void{
			trace("Resuming.");
			if(getDotaXML.xmlAlert){
			userPresent = 1
				if(popUp == 1){
				Tweener.addTween(mc, {y:101, time:2,delay:4,onComplete: function() {window.close();} });
				popUp = 0;
				}
			}
		}

		 
	}
}