package dag.sf4
{
    import flash.display.MovieClip;
    import flash.events.Event;
	import flash.events.MouseEvent;
	

    public class btnBar extends MovieClip
    {	
	
		
           	
			
		public function btnBar():void{
			btnClose.addEventListener(MouseEvent.CLICK, closeApp);
			btnClose.addEventListener(MouseEvent.MOUSE_OVER, function():void{btnClose.gotoAndStop(2)});
         	btnClose.addEventListener(MouseEvent.MOUSE_OVER, function():void{btnClose.gotoAndStop(2)});
        }
	
		public function closeApp():void{
          
        }
		public function restoreApp():void{
          
        }
		
		public function minApp():void{
           
           

        }
		
	
			
    }
}