package dag{
	import flash.filesystem.*;
	import flash.display.*
	import flash.text.TextField;
	
	public class Row extends MovieClip
    {
		

		public function Row():void
        {
			
			
			}
					
			public function set sku(text:String):void {
           			sku.text = text;
        	}
        
       		public function set brand(text:String):void {
           			brand.text = text;
       	 	}
        	public function set model(text:String):void {
           			model.text = text;
        	}
        
       		public function set brand(text:String):void {
           			price.text = text;
       	 	}
       		
        	private function over_Mouse(e:MouseEvent):void {
           			select.gotoAndStop(2);
					
        	}
			private function out_Mouse(e:MouseEvent):void {
           			select.gotoAndStop(1);
        	}
			private function click_Mouse(e:MouseEvent):void {
					this.removeEventListener(MouseEvent.ROLL_OVER, out_Mouse);
					this.removeEventListener (MouseEvent.CLICK, click_Mouse);
					this.addEventListener(MouseEvent.CLICK, selClick_Mouse);
					select.gotoAndStop(3);
        	}
			private function selClick_Mouse(e:MouseEvent):void {
           			select.gotoAndStop(1);
					this.removeEventListener (MouseEvent.CLICK, selClick_Mouse);
					this.addEventListener(MouseEvent.ROLL_OUT, out_Mouse);
					this.addEventListener(MouseEvent.CLICK, click_Mouse);
        	}
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}