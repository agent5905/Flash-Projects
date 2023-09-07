package dag
{
	import flash.events.*;
	
	public class ScrollBarUpdateEvent extends Event
	{
		public static const VALUE_CHANGED = "valueUpdate";
		
		
		public function ScrollBarUpdateEvent():void
		{
			super(VALUE_CHANGED);
			
		}
		
	}
}
