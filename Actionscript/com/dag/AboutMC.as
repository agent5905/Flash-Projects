package dag
{
    import flash.display.MovieClip;
    import fl.controls.Button;
    import flash.events.Event;
	import flash.events.MouseEvent;
    import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	

	
	
    public class AboutMC extends MovieClip
    {		
		
		private var tittleBarSize:Number = 20;
		
		
        public function AboutMC():void{
            
			btnOK.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void {stage.nativeWindow.close();});
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        }
        
        private function onMouseDown(e:Event):void
		{
			if (stage.mouseY >= 0 && stage.mouseY <= tittleBarSize)
			{
				stage.nativeWindow.startMove();
			}
		}
			
    }
}