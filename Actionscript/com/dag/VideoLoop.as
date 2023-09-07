//VideoLoop.as
package dag{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.media.Video;
	
	public class VideoLoop extends Sprite 
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
		public function VideoLoop(mc:MovieClip):void 
		{
			_mc = mc;
			_vidConnection = new NetConnection();
			_vidConnection.connect(null);
			_vidStream = new NetStream(_vidConnection);
			
			_infoClient = new Object();
			_infoClient = onMetaData;
			_vidStream.client = _infoClient;
			
			_vidStream.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus, false, 0, true);
			
			_vid = new Video(mc.width,mc.height);
			_vid.attachNetStream(_vidStream);
			_mc.addChild(_vid);
		}
		
		public function startVideo():void
		{
			setUp();
		}
		
		public function addVideo(_vid:String):void
		{
			_vidList.push(_vid);
			_vidNumber = _vidList.length
			trace(_vidList[0]);
		
		}
				
		private function onMetaData(info:Object):void
		{
			_duration = info.duration
		
		}
		
		private function onNetStatus(evt:NetStatusEvent):void
		{
			trace(evt.info.level + ": " + evt.info.code);
			
			if(evt.info.code == "NetStream.Play.Stop"){
				nextVid();
			}
		
		}
		
		private function setUp():void
		{
			_vidCount = 0;
			_vidURL = _vidList[_vidCount];
			_vidStream.play(_vidURL);
		
		}
		
		private function nextVid():void
		{
			_vidCount += 1;
			
			if(_vidCount >= _vidList.length ){
				_vidCount = 0;
			}
			_vidURL = _vidList[_vidCount];
			trace(_vidURL);
			_vidStream.play(_vidURL);
		}
		
		
	}
}