package dag
{
    import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.*;
    import flash.net.*;
	import flash.filesystem.*;
    import flash.xml.*;
    
	public class GetDotaXML extends MovieClip
    {		
		var xmlDes:String = "xml/getDota.xml";
		var xml:XML = new XML();
		public var xmlMap:String;
		public var xmlLocation:String;
		public var xmlAlert:Boolean;
		public var xmlCheck:Number;
		public var xmlAutoDL:Boolean;
		public var xmlRSS:Boolean;
		public var xmlStartup:Boolean;
		var fileStream:FileStream;
		var file:File;
		
										
        public function GetDotaXML():void{
			
            super();
			
			
        }
        
        ///////////////////////////////////////getXML Events//////////////////////////////////////////////////////////
		
		public function getXML(event:Event = null):void {
			
			
			file = File.applicationStorageDirectory.resolvePath(xmlDes); 
			fileStream = new FileStream(); 
			fileStream.addEventListener(Event.COMPLETE, getXMLComplete); 
			fileStream.openAsync(file, FileMode.READ); 
			;
		}
      
        private function getXMLComplete(event:Event):void {
				xml = XML(fileStream.readUTFBytes(fileStream.bytesAvailable)); 
    			fileStream.close();
				
			
				
				
        		xmlMap = xml.*.@name;
				xmlLocation = xml.*.location;
				xmlAlert = stringToBoolean(xml.*.alert);
				xmlCheck = xml.*.check;
				xmlAutoDL = stringToBoolean(xml.*.autodl);
				xmlRSS = stringToBoolean(xml.*.rss);
				xmlStartup = stringToBoolean(xml.*.startup);
				trace(xmlMap, xmlLocation, xmlAlert, xmlCheck, xmlAutoDL, xmlRSS, xmlStartup);
				
				var complete:Event = new Event(Event.COMPLETE,false,false);
        		dispatchEvent(complete);
        }
		
		private function stringToBoolean(str:String):Boolean
		{
   			 return (str.toLowerCase() == "true" || str.toLowerCase() == "1");
		} 
		
		public function saveXML():void {
			var xmlSave:XML = <getDota/>;
			var myFile:File = File.applicationStorageDirectory.resolvePath(xmlDes);
			
			var myFileStream:FileStream = new FileStream();
			
			myFileStream.addEventListener(Event.CLOSE, fileClosed);
			myFileStream.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
			myFileStream.addEventListener(Event.COMPLETE, completeHandler);
			myFileStream.addEventListener(ProgressEvent.PROGRESS,progressHandler)
   			myFileStream.openAsync(myFile, FileMode.WRITE);
			
						xmlSave.map = "";
			xmlSave.*.@name = xmlMap;
			xmlSave.*.location = xmlLocation;
			xmlSave.*.alert = xmlAlert;
			xmlSave.*.check = xmlCheck;
			xmlSave.*.rss = xmlRSS;
			xmlSave.*.autodl = xmlAutoDL;
			xmlSave.*.startup = xmlStartup;
			
   			myFileStream.writeUTFBytes(xmlSave);
			myFileStream.close();
			trace("closed");
			myFileStream = null;
			
			
		}
		
		

		private function fileClosed(event:Event):void {
    		trace("closedEventHandler" + event);
		} 
		
		private function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
		}
		private function completeHandler(event:Event):void {
            trace("completeHandler: " + event);
		}
		private function progressHandler(event:ProgressEvent):void {
            trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }
        /*
        private function getXMLHttpStatusHandler(event:HTTPStatusEvent):void {
            trace("getXMLHttpStatusHandler: " + event);
        }
		
		///////////////////////////////////////File Output//////////////////////////////////////////////////////////
		
		private function outFile(fileName:String, data:ByteArray):void { 
			trace("writing file");
    		var outFile:File = new File();
			outFile.nativePath = xmlLocation + "/" + fileName;
    		//outFile = outFile.resolvePath(fileName);  // name of file to write 
    		var outStream:FileStream = new FileStream(); 
    		// open output file stream in WRITE mode 
    		outStream.open(outFile, FileMode.WRITE); 
    		// write out the file 
    		outStream.writeBytes(data, 0, data.length); 
    		// close it 
   			outStream.close(); 
		}
		*/
    }
}