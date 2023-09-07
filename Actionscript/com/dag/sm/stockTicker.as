package dag.sm{
	import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.*;
	import flash.utils.Timer;
	
    //This class is used to handle the stock ticker in the screen messenger program.
    public class stockTicker extends MovieClip {
       
	   private var _urlLoader:URLLoader = new URLLoader();
	   private var URLcontent:String;
	   private var countdownTimer:Timer = new Timer(900000);
	   
	   
	   public function stockTicker():void 
		{
			_urlLoader.addEventListener(Event.COMPLETE, loaderComplete);
	   		_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
			_urlLoader.load(new URLRequest("http://finance.yahoo.com/d/quotes.csv?s=BBY&f=sl1d1t1c1ohgv"));
			
			countdownTimer.addEventListener(TimerEvent.TIMER, updateTime);
			countdownTimer.start();
		}
	   
		private function updateTime(e:TimerEvent):void
		{
			_urlLoader.load(new URLRequest("http://finance.yahoo.com/d/quotes.csv?s=BBY&f=sl1d1t1c1ohgv"));
		}
	   	   
		private function loaderComplete (e:Event):void
	   	{
			var startPos:Number;
			var endPos:Number;
			var stkP:String;
			
			URLcontent = unescape(e.target.data);
			
			startPos = 6
			endPos = URLcontent.indexOf(",",startPos);
			stkP = URLcontent.slice(startPos,endPos);
			stockPrice.text = "$" + stkP;
		}

		private function ioErrorHandler(event) 
		{
            trace("ioErrorHandler: " + event);
		}
	   
	   
	   
	   

    }
}