package dag{
	//This class is used to handle functions of getting the map name, random server where to
	//download the map and then downlaoding the map to the location targeted in the getDota program.
	import flash.net.*;
	import flash.filesystem.*;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.ByteArray;
	import dag.GetDotaIcon;
	//import dag.GetDotaWindow
	import dag.GetDotaXML;
	import dag.CustomEvent;
	
    public class GetDota extends MovieClip {
		var url:String = "http://www.getdota.com/app/getmap/";
		
		var getDotaLoader:URLLoader = new URLLoader();
		var getMirrorLoader:URLLoader = new URLLoader();
		var getMapLoader:URLLoader = new URLLoader();
		var mapDataLoader:URLLoader
		
		var request:URLRequest = new URLRequest(url);
		var variables:URLVariables = new URLVariables();
		public var dotaFilename:String;
		public var getDotaMapName:String;
		public var dotaBackupMirror:String;
		var dotaBackupMirrorLoc:Number = 0;
		var mirror:String;
		
		private var getDotaXML = new GetDotaXML();
		private var icon:GetDotaIcon = new GetDotaIcon()
		
		var dotaHtml:String;
		
	   public function GetDota():void 
		{
			
			
			getDotaLoader.addEventListener(Event.COMPLETE, getDotaCompleteHandler);
            getDotaLoader.addEventListener(ProgressEvent.PROGRESS, getDotaProgressHandler);
            getDotaLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, getDotaHttpStatusHandler);
            
			getMirrorLoader.addEventListener(Event.COMPLETE, getMirrorCompleteHandler);
            getMirrorLoader.addEventListener(ProgressEvent.PROGRESS, getMirrorProgressHandler);
            getMirrorLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, getMirrorHttpStatusHandler);
            
			getMapLoader.addEventListener(Event.COMPLETE, getMapCompleteHandler);
            getMapLoader.addEventListener(ProgressEvent.PROGRESS, getMapProgressHandler);
            getMapLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, getMapHttpStatusHandler);
			
			
			
			
			////getCurrentDotaName();
			
			
			variables.mirror_id = 0;
			//variables.mirror_id = 56;
			variables.mirror_nr = 2;
			//Loader Object Retrieves the current filename from www.getdota.com
			//variables.file_name = "DotA+Allstars+v6.59c.w3x";
			variables.as_zip = 0;
			variables.language = "en";
			variables.language_id = 2;
			variables.map_id = 447;
			
			//GDW.windowPopUp("DotA Allstars v6.60");
		}
	   
		public function getCurrentDotaName():void
	   	{
			dotaBackupMirrorLoc = 0;
			request = new URLRequest("http://www.getdota.com");
			getDotaLoader.load(request);
			
		}
	   	   
	   public function getMirror():void
	   	{
			request = new URLRequest(url);
			request.contentType ="application/x-www-form-urlencoded";
			request.method = URLRequestMethod.POST;
			request.data = variables;
			getMirrorLoader.load(request);
		}
	   
	   private function getMap():void
	   	{
			request = new URLRequest(mirror);
			getMapLoader.dataFormat = URLLoaderDataFormat.BINARY;
			request.method = URLRequestMethod.GET;
			getMapLoader.load(request);
		}
	   
	   		
		///////////////////////////////////////getCurrentDotaName Loader Events//////////////////////////////////////////////////////////
		
		private function getDotaCompleteHandler(event:Event):void {
            var loader:URLLoader = URLLoader(event.target);
            //trace("getDotaCompleteHandler: " + loader.data);
			dotaHtml= loader.data;
			var dotaStartLocation:Number = dotaHtml.indexOf('file_name" value="');
			dotaStartLocation += 18;
			
			
			var dotaEndLocation:Number = dotaHtml.indexOf('"',dotaStartLocation);
			
			dotaFilename = dotaHtml.slice(dotaStartLocation,dotaEndLocation);
			dotaFilename = dotaFilename.replace(/ /g,"+");
			
			trace(dotaFilename);
			variables.file_name = dotaFilename;
			
			getDotaXML.addEventListener(Event.COMPLETE,getDotaCheck);
			getDotaXML.getXML();
			
			
        }
       	 private function getDotaCheck(event:Event):void {
            if(getDotaXML.xmlMap != dotaFilename){
					icon.cycleImages(['icons/icefrog_16_green.png','icons/icefrog_16_red.png']);
					getDotaXML.removeEventListener(Event.COMPLETE,getDotaCheck);
					getMirror();
				}else{
					
				}
        }
	   
	   
        private function getDotaProgressHandler(event:ProgressEvent):void {
            trace("getDotaProgressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }
        
        private function getDotaHttpStatusHandler(event:HTTPStatusEvent):void {
            trace("getDotaHttpStatusHandler: " + event);
        }
       
		///////////////////////////////////////getMirror Events//////////////////////////////////////////////////////////
		
		private function getMirrorCompleteHandler(event:Event):void {
            var loader:URLLoader = URLLoader(event.target);
            trace("getMrirrorCompleteHandler: " + loader.data);
			mirror = loader.data;
			mirror = mirror.replace(/\+/g," ");
			trace(mirror);
			
			getMap()
        }
       
        private function getMirrorProgressHandler(event:ProgressEvent):void {
            trace("getMirrorProgressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }
        
        private function getMirrorHttpStatusHandler(event:HTTPStatusEvent):void {
            trace("getMirrorHttpStatusHandler: " + event);
        }
		
		///////////////////////////////////////getMap Events//////////////////////////////////////////////////////////
		
		private function getMapCompleteHandler(event:Event):void {
            mapDataLoader = URLLoader(event.target);
            trace("getMapCompleteHandler: " + mapDataLoader.data);
			
			getDotaXML.getXML();
				
			getDotaXML.addEventListener(Event.COMPLETE,getDotaWrite);
			
			
        }
       
	   private function getDotaWrite(event:Event):void {
		   getDotaXML.removeEventListener(Event.COMPLETE,getDotaWrite);
		   	getDotaMapName = dotaFilename.replace(/\+/g," ")
			getDotaMapName = getDotaMapName.slice(0,getDotaMapName.length -4);
            outFile(dotaFilename.replace(/\+/g," "), mapDataLoader.data)
        }
	   
        private function getMapProgressHandler(event:ProgressEvent):void {
            trace("getMapProgressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }
        
        private function getMapHttpStatusHandler(event:HTTPStatusEvent):void {
            trace("getMapHttpStatusHandler: " + event);
			switch(event.status){
			
			case 0:
			if(dotaBackupMirrorLoc == 0){
			dotaBackupMirrorLoc = dotaHtml.indexOf('SelectMirror(1,');
			dotaBackupMirrorLoc += 15;
			}
			dotaBackupMirrorLoc = dotaHtml.indexOf('SelectMirror(1,',dotaBackupMirrorLoc);
			dotaBackupMirrorLoc += 15;
			
			var dotaBackupMirrorEndLoc:Number = dotaHtml.indexOf(')',dotaBackupMirrorLoc);
			
			dotaBackupMirror = dotaHtml.slice(dotaBackupMirrorLoc,dotaBackupMirrorEndLoc);
			
			variables.mirror_id = Number(dotaBackupMirror);
			getMirror();
			break;
			case 200:
			
			break;
			}
        }
		
		private function outFile(fileName:String, data:ByteArray):void { 
		
				var customEvent:CustomEvent = new CustomEvent("SaveComplete");
				
				var outFile:File = new File(getDotaXML.xmlLocation); // dest folder is desktop 
				
    			outFile = outFile.resolvePath(fileName);  // name of file to write 
				//if(!outFile.resolvePath(fileName).exists){
    			var outStream:FileStream = new FileStream(); 
    			// open output file stream in WRITE mode 
    			outStream.open(outFile, FileMode.WRITE); 
    			// write out the file 
    			outStream.writeBytes(data, 0, data.length); 
    			// close it 
    			outStream.close(); 
				
				getDotaXML.xmlMap = dotaFilename;
				getDotaXML.saveXML();
				//}
				icon.stopCycleImages();
				dispatchEvent(customEvent);

						
		}
		
		
    }
}
/*
var url:String = "http://www.getdota.com/app/getmap/";
var loader:URLLoader = new URLLoader();
var request:URLRequest = new URLRequest(url);
var variables:URLVariables = new URLVariables();
//var variables:ByteArray = [{mirror_id = 0


variables.mirror_id = 0;
variables.mirror_nr = 2;
variables.file_name = "DotA+Allstars+v6.59c.w3x";
variables.as_zip = 0;
variables.language = "en";
variables.map_id = 113;

request.contentType ="application/x-www-form-urlencoded";
request.method = URLRequestMethod.POST;
request.data = variables;
configureListeners(loader);

trace("strated");
loader.load(request);

trace("started 2nd DL");
			request = new URLRequest("http://dota.gamesproject.net/getdota/eng/DotA%20Allstars%20v6.59c.w3x");
			//request.contentType ="application/octet-stream";
			//request = new URLRequest("http://dotaproject.myutsu.net/eng/DotA%20Allstars%20v6.59c.w3x")
			//request.contentType ="text/plain";

			
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			request.method = URLRequestMethod.GET;
			loader.load(request);


function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }
        function completeHandler(event:Event):void {
            var loader:URLLoader = URLLoader(event.target);
            trace("completeHandler: " + loader.data);
			trace(loader.dataFormat);
			outFile("DotA Allstars v6.59c.w3x",loader.data)
			//loader.load(request);
			
        }
       function openHandler(event:Event):void {
            trace("openHandler: " + event);
        }
        function progressHandler(event:ProgressEvent):void {
            trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }
        function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }
         function httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
        }
        function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
        }


function outFile(fileName:String, data:ByteArray):void { 
    var outFile:File = File.desktopDirectory; // dest folder is desktop 
    outFile = outFile.resolvePath(fileName);  // name of file to write 
    var outStream:FileStream = new FileStream(); 
    // open output file stream in WRITE mode 
    outStream.open(outFile, FileMode.WRITE); 
    // write out the file 
    outStream.writeBytes(data, 0, data.length); 
    // close it 
    outStream.close(); 
	
	
	var file:File = new File(); 
file.addEventListener(Event.SELECT, dirSelected); 
file.browseForDirectory("Select a directory"); 
function dirSelected(e:Event):void { 
    trace(file.nativePath); 
}
}
*/