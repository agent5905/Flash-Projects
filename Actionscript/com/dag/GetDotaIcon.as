package dag
{
    import flash.desktop.Icon;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLRequest;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
    import flash.desktop.NativeApplication;
	
    public class GetDotaIcon extends Icon
    {		
		private var imageURLs:Array = ['icons/icefrog_16.png'];
		private var cycleImageURLs:Array;
		private var myTimer:Timer = new Timer(500);
		private var cycleBitmaps:Array;
		private var count:Number;
		private var defaultBitmaps:Array;
		
        public function GetDotaIcon():void{
            super();
            bitmaps = new Array();
			defaultBitmaps = new Array();
			cycleBitmaps = new Array();
			myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			count = 0;
        }
        
        public function loadImages(event:Event = null):void{
        	if(event != null){
        		bitmaps.push(event.target.content.bitmapData);
				defaultBitmaps.push(event.target.content.bitmapData);
        	}
        	if(imageURLs.length > 0){
        		var urlString:String = imageURLs.pop();
        		var loader:Loader = new Loader();
        		loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadImages,false,0,true);
				loader.load(new URLRequest(urlString));
        	} else {
				NativeApplication.nativeApplication.icon.bitmaps = defaultBitmaps;
        		var complete:Event = new Event(Event.COMPLETE,false,false);
        		dispatchEvent(complete);
        	}
        }
		
		public function cycleImages(img:Array):void{
			cycleImageURLs = img;
				//icon.contentLoaderInfo.addEventListener(Event.COMPLETE, iconLoadComplete); 
                //icon.load(new URLRequest("icons/AIRApp_16.png")); 
                 
                //var systray:SystemTrayIcon =  NativeApplication.nativeApplication.icon as SystemTrayIcon; 
    		loadCycleImages();
        	
        
        }
		
		public function loadCycleImages(event:Event = null):void{
        	if(event != null){
        		cycleBitmaps.push(event.target.content.bitmapData);
				
        	}
        	if(cycleImageURLs.length > 0){
        		var urlString:String = cycleImageURLs.pop();
        		var loader:Loader = new Loader();
        		loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadCycleImages,false,0,true);
				loader.load(new URLRequest(urlString));
        	} else {
				cycleBitmaps.reverse();
        		myTimer.start();
        	}
        }
		
		private function timerHandler(e:TimerEvent):void{
           // repeat--;
            //statusTextField.text = ((delay * repeat) / 1000) + " seconds left.";
			
			NativeApplication.nativeApplication.icon.bitmaps = new Array(cycleBitmaps[count]);
			count++
			if(count > cycleBitmaps.length - 1){
				count = 0;
			}
			
        }
		
		public function stopCycleImages():void{
        	
        		myTimer.stop();
				count = 0;
				loadImages();
        	
        }
		
    }
}