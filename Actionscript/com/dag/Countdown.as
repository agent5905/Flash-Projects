//Countdown.as
package dag{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.text.*; 
	
	public class Countdown extends Sprite 
	{
		private var _endDate:Date;
		public var time:String;
		
		private var fmt:TextFormat = new TextFormat();
		

		public var textbox:TextField = new TextField();
		
		
		public function Countdown(endDate:Date):void 
		{
			_endDate = endDate;
			trace(_endDate);
			var countdownTimer:Timer = new Timer(1000);
			countdownTimer.addEventListener(TimerEvent.TIMER, updateTime);
			countdownTimer.start();
		}
		
		private function updateTime(e:TimerEvent):void
		{
	
		var now:Date = new Date();
		
		var timeLeft:Number = _endDate.getTime() - now.getTime()
		
		timeLeft += (((now.getTimezoneOffset() / 60) -(_endDate.getTimezoneOffset() / 60)) * 3600000);
	
		var seconds:Number = Math.floor(timeLeft / 1000);
		var minutes:Number = Math.floor(seconds / 60);
		var hours:Number = Math.floor(minutes / 60);
		var days:Number = Math.floor(hours / 24);
	
		seconds %= 60;
		minutes %= 60;
		hours %= 24;
	
		var sec:String = seconds.toString();
		var min:String = minutes.toString();
		var hrs:String = hours.toString();
		var d:String = days.toString();
	
		if (sec.length < 2) {
			sec = "0" + sec;
		}
	
		if (min.length < 2) {
			min = "0" + min;
		}
	
		if (hrs.length < 2) {
			hrs = "0" + hrs;
		}
	
		time = d + "  " + hrs + ":" + min + ":" + sec;
		textbox.text = time;
		fmt.letterSpacing = 14;
		textbox.setTextFormat(fmt);
		}
		
				
	}
}