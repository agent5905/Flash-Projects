package dag{
	import air.update.ApplicationUpdater;
	import air.update.events.StatusFileUpdateEvent;
	import air.update.events.StatusUpdateErrorEvent;
	import air.update.events.StatusFileUpdateErrorEvent;
	import air.update.events.DownloadErrorEvent;
	import air.update.events.StatusUpdateEvent;
	import air.update.events.UpdateEvent;
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
	import fl.controls.Button;
	import Namespace;
	import XML;
	import flash.utils.Dictionary;
	
	public class FlashUpdater extends MovieClip
    {
		private var appUpdater:ApplicationUpdater = new ApplicationUpdater();
		private var window:NativeWindow;
		private var windowContent:myWindow = new myWindow();
		private var existentListeners:Dictionary = new Dictionary();
		private var mc_:MovieClip = new MovieClip();
		public function FlashUpdater(xml:String):void
        {
					
					setApplicationNameAndVersion();
    				//appUpdater.updateURL = "http://localhost/updater/update_flash.xml";
					appUpdater.updateURL = xml;
					//"C:/Users/DAG/Desktop/Pre-setup Tag Designer/Flash/Updater/update_flash.xml";
    				//we set the event handlers for INITIALIZED nad ERROR
					appUpdater.addEventListener(UpdateEvent.INITIALIZED, onUpdate);
    				appUpdater.addEventListener(ErrorEvent.ERROR, onError);
       				appUpdater.addEventListener(StatusUpdateEvent.UPDATE_STATUS, onStatusUpdate);
    				appUpdater.addEventListener(StatusUpdateErrorEvent.UPDATE_ERROR, onStatusUpdateError);
   					appUpdater.addEventListener(ProgressEvent.PROGRESS, onDownloadProgress);
   					appUpdater.addEventListener(UpdateEvent.DOWNLOAD_COMPLETE, onDownloadComplete);
    				appUpdater.addEventListener(DownloadErrorEvent.DOWNLOAD_ERROR, onDownloadError);
    				//initialize the updater
    				appUpdater.initialize();
		}
		
		//listener for INITIALIZED event of the applicationUpdater;
		private function onUpdate(event:UpdateEvent):void {
    				//start the process of checking for a new update and to install
   					 appUpdater.checkNow();
		}
		
		
		//Handler function for error events triggered by the ApplicationUpdater.initialize
		private function onError(event:ErrorEvent):void {
			trace("onError");
    		createWindow();
    		displayWindowError(event.errorID, event.text);
		}
		
		//handler function for StatusUpdateEvent.UPDATE_STATUS
		//this is called after the update descriptor was downloaded and interpreted successfuly 
		private function onStatusUpdate(event:StatusUpdateEvent):void {
    		trace("onStatusUpdate");
    		//prevent the default (start downloading the new version)
    		event.preventDefault();
    		
    		//create the window for displaying Update available
    		if (event.available) {
				createWindow();
    			windowContent.bar_mc.visible = false; //hide the progress bar
        		windowContent.title = "Update Available";
        		windowContent.enableDescription = true;
        		windowContent.description = event.version + " " + event.details[0][1];
        		windowContent.buttonLeft.label = "Update";
        		windowContent.buttonRight.label = "Cancel";
        		addEventToButton(windowContent.buttonLeft, MouseEvent.CLICK, startDownload);
        		addEventToButton(windowContent.buttonRight, MouseEvent.CLICK, closeWindow);
     		//we don't have an update, so display this information
    			} else {
        			/*
					windowContent.title = "No Update Available";
        			windowContent.enableDescription = false;
        			windowContent.buttonLeft.visible = false;
        			windowContent.buttonRight.label = "Close";
        			addEventToButton(windowContent.buttonRight, MouseEvent.CLICK, closeWindow);
					*/
    		}
		}

		//error listener for an error when the updater could not download or
		//interpret the update descriptor file.
		private function onStatusUpdateError(event:StatusUpdateErrorEvent):void
		{
    		trace("onStatusUpdateError");
			//createWindow();
    		//displayWindowError(event.subErrorID, event.text);
			
		}

		//error listener for DownloadErrorEvent. Dispatched if there is an error while connecting or
		//downloading the update file. It is also dispatched for invalid HTTP statuses 
		//(such as "404 - File not found").
		private function onDownloadError(event:DownloadErrorEvent):void {
    		trace("onDownloadError");
			createWindow();
    		displayWindowError(event.subErrorID, event.text);    
		}

		//start the download of the new version
		private function startDownload(event:MouseEvent):void {
    		appUpdater.downloadUpdate();
    		createWindow();
			
			
    		windowContent.bar_mc.visible = true;
    		windowContent.bar_mc.setProgress(0, 100);
		}

		//listener for the ProgressEvent when a download of the new version is in progress
		private function onDownloadProgress(event:ProgressEvent):void {
   			windowContent.bar_mc.setProgress(event.bytesLoaded, event.bytesTotal);

		}
		
		//listener for the complete event for downloading the application
		//just close the window; the downloaded version will be automatically installed,
		//and then the application gets restarted
		private function onDownloadComplete(event:UpdateEvent):void {
   		 	closeWindow(null);
		}

		//sets the state of the window in error display mode
		private function displayWindowError(errorId:int, errorText:String):void
		{
    		trace("onDisplayWindowError");
			windowContent.title = "Error";
    		windowContent.enableDescription = true;
    		windowContent.description = "Error ID: " + errorId + ". " + errorText;
    		windowContent.buttonLeft.visible = false;
    		windowContent.buttonRight.label = "Close";
   			windowContent.bar_mc.visible = false;
    		addEventToButton(windowContent.buttonRight, MouseEvent.CLICK, closeWindow);
			
			
		}
		
		//create a window using NativeWindow, and as a content myWindow class
		private function createWindow():void {
    		if (window == null) {
        		var options:NativeWindowInitOptions = new NativeWindowInitOptions();
        		options.systemChrome = NativeWindowSystemChrome.STANDARD;
        		options.type = NativeWindowType.NORMAL;
        		options.maximizable = false;
				options.minimizable = false;
				options.resizable = false;
        		window = new NativeWindow(options);
        		window.x = 300;
        		window.y = 200;
        		window.stage.stageHeight = 232.9;
        		window.stage.stageWidth = 603;
        		window.stage.scaleMode = StageScaleMode.NO_SCALE;
        		window.stage.align = StageAlign.TOP_LEFT;
        		window.stage.addChild(windowContent);
        		windowContent.bar.visible = false;
    		}
    			window.alwaysInFront = true;
    			window.visible = true;
				window.title = "Update!"
		}

		//close the window
		private function closeWindow(event:Event):void {
    		window.close();    
		}
		
		//hide the window
		private function hideWindow():void {
    		window.visible = false;
		}
		
		//sets the application name and version in the main window
		private function setApplicationNameAndVersion():void {
    		var appXML:XML = NativeApplication.nativeApplication.applicationDescriptor;
    		var ns:Namespace = appXML.namespace();
			trace("Verison: " + appXML.ns::version);
			trace("Name: " + appXML.ns::version);
    		/*lblVersion.text = appXML.ns::version;
    		lblName.text = appXML.ns::name;*/
		}

		//add to the given button, the listener for given type (actually we use only the type MouseEvent.CLICK).
		//we use a dictionary to store for each button the listener registered.
		//when this function gets called, first we remove any registered listener. Next we register the listener 
		//on the button, and next we save to dictionary.
		private function addEventToButton(button:Button, type:String, listener:Function):void
		{
    		//remove existent listneres
    		if (existentListeners[button] != null) {
        		var arr:Array = existentListeners[button] as Array;
        		button.removeEventListener(type, arr[0]);
    		} 
    		existentListeners[button] = [];
    		button.addEventListener(type, listener);
    		existentListeners[button][0] = listener;
    		button.visible = true;
		}

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}