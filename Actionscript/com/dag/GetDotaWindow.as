package dag{

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
	import flash.display.Sprite;


	public class GetDotaWindow extends MovieClip{
			
		
		private var window:NativeWindow;
		private var settingsWindow:NativeWindow;
		private var aboutWindow:NativeWindow;
		private var mc:GetDotaMC = new GetDotaMC();
		private var mc2:SettingsMC = new SettingsMC();
		private var mc3:AboutMC = new AboutMC();
		private var iconPath:String  = "icons/icefrog_16_red.png";
		private var icon:GetDotaIcon = new GetDotaIcon()
		var current:Screen;
		
		//var icon:Loader = new Loader(); 
        var iconMenu:NativeMenu = new NativeMenu(); 
		var launchSettings:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Settings"));
		var launchPopUp:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Pop Up"));
		var launchAbout:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("About"));
        var exitCommand:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Exit")); 
		
	
	public function GetDotaWindow():void 
		{
			
			 
			
			exitCommand.addEventListener(Event.SELECT, function(event:Event):void {NativeApplication.nativeApplication.icon.bitmaps = []; NativeApplication.nativeApplication.exit();});
			launchPopUp.addEventListener(Event.SELECT, function(event:Event):void {windowPopUp("DotA Allstars v6.60");});
			launchSettings.addEventListener(Event.SELECT, function(event:Event):void {displaySettings();});
			launchAbout.addEventListener(Event.SELECT, function(event:Event):void {displayAbout();});
			var mc:GetDotaMC = new GetDotaMC();
			current = Screen.mainScreen
			
			
			icon.addEventListener(Event.COMPLETE,function():void{
				NativeApplication.nativeApplication.icon.bitmaps = icon.bitmaps;
			});
			icon.loadImages();
			
			createWindow();
			
			
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
        		
    		}
    			window.alwaysInFront = true;
    			window.visible = true;
				window.title = "Get Dota"
				
				/* 
                trace("dag");
				//icon.contentLoaderInfo.addEventListener(Event.COMPLETE, iconLoadComplete); 
            	//icon.load(new URLRequest(File.applicationDirectory.resolvePath(iconPath).url));
                
				var systray:SystemTrayIcon = NativeApplication.nativeApplication.icon as SystemTrayIcon; 
                systray.tooltip = "Get DotA";
                systray.menu = iconMenu;
				
				*/
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
				
				settingsWindow.stage.addChild(mc2);
				        		
    		}
    			//window.alwaysInFront = true;
    			//window.visible = true;
				trace("icon:" + NativeApplication.nativeApplication.icon.bitmaps);
				settingsWindow.title = "Settings"
				settingsWindow.activate();
		}
		
	private function createAboutWindow():void {
    		if (settingsWindow == null) {
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
				        		
    		}
    			//window.alwaysInFront = true;
    			//window.visible = true;
				trace("icon:" + NativeApplication.nativeApplication.icon.bitmaps);
				aboutWindow.title = "About"
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
			
			mc.mapVer.text = strMap;
			Tweener.addTween(mc, {y:0, time:2 });
			Tweener.addTween(mc, {y:101, time:2,delay:4,onComplete: function() {/*NativeApplication.nativeApplication.exit();*/} });
			
		}
              
	 private function iconLoadComplete(event:Event):void 
        { 
            NativeApplication.nativeApplication.icon.bitmaps = [event.target.content.bitmapData];
			
			
        } 
		
		
		
   }
}