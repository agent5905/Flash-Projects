//VideoLoop.as
package dag{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.media.Video;
	
	public class VideoControl extends Sprite 
	{
		private var _vidConnection:NetConnection;
		private var _vidStream:NetStream;
		private var _vid:Video;
		private var _vidURL:String;
		private var _infoClient:Object;
		private var _vidList:Array = new Array();
		private var _vidNumber:Number = 0;
		private var _vidCount:Number = 0;
		private var _mc:MovieClip;
		private var _duration:uint = 0;
		public function VideoControl(mc:MovieClip, videoFile:String):void 
		{
			_mc = mc;
			
			_vidConnection = new NetConnection();
			_vidConnection.connect(null);
			_vidStream = new NetStream(_vidConnection);
			
			_infoClient = new Object();
			//_infoClient = onMetaData;
			_vidStream.client = _infoClient;
			
			_vidStream.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus, false, 0, true);
			
			_vid = new Video(mc.width,mc.height);
			trace(_vid.width, _vid.height);
			_vid.attachNetStream(_vidStream);
			_mc.addChild(_vid);
			_vidURL = videoFile;
			
		}
		
		public function startVideo():void
		{
			trace(_vidURL);
			trace(_mc.parent.name);
			_vidStream.play(_vidURL);
		}
		
					
		//private function onMetaData(info:Object):void
		//{
			//_duration = info.duration
		
		//}
		
		private function onNetStatus(evt:NetStatusEvent):void
		{
			trace(evt.info.level + ": " + evt.info.code);
			
			if(evt.info.code == "NetStream.Play.Stop"){
				//code to send event;
				
				_vidStream.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
				_vidStream.close();
				_vidStream = null;
				_vid = null;
				var customEvent:CustomEvent = new CustomEvent("Finished");
				dispatchEvent(customEvent);
				
				
				
			}
		
		}
		
		
		
		
		
		
	}
}