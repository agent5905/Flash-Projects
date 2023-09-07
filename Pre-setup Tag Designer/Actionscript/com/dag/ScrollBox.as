package dag
{
	import flash.display.*;
	import flash.events.*;
	import caurina.transitions.*;
	
	public class ScrollBox extends MovieClip
	{		
		public function ScrollBox():void
		{
			sb.addEventListener(ScrollBarEvent.VALUE_CHANGED, sbChange);
			
		}
		
		private function sbChange(e:ScrollBarEvent):void
		{
			Tweener.addTween(contnt, {y:(-e.scrollPercent*(contnt.height-masker.height-.07)),
							   time:1});
		}
		
		public function sbUpdate():void
		{
			if((masker.height /contnt.height) < 1){
			sb.visible = true;
			sb.thumb.height =  sb.track.height *(masker.height /contnt.height)
			sb.yMax = sb.track.height - sb.thumb.height;
			}else{
			sb.visible = false;
			}
			trace(sb.track.height ,masker.height,contnt.height, sb.yMax);
		}
	}
}