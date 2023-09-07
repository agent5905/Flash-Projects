package dag.sf4
{
    import flash.display.MovieClip;
    import fl.controls.Button;
    import fl.controls.TextArea;
	import fl.controls.CheckBox;
	import fl.controls.ComboBox;
    import flash.events.Event;
	import flash.events.MouseEvent;
    import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.filesystem.*;
	import flash.xml.*;

	
	
    public class TourneyWindow extends MovieClip
    {		
		
		private var tittleBarSize:Number = 101;
		private var directory:File = File.applicationDirectory;
		var xmlDes:String = "";
		
		
        public function TourneyWindow():void{
            
			//btnWin.addEventListener(MouseEvent.CLICK,onwin);
			//btnLoss.addEventListener(MouseEvent.CLICK,onLoss);
			//btnDraw.addEventListener(MouseEvent.CLICK, onDraw);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        }
        
        private function onMouseDown(e:Event):void
		{
			if (stage.mouseY >= -13 && stage.mouseY <= tittleBarSize)
			{
				stage.nativeWindow.startMove();
			}
		}
		
		//private function onWin(e:Event):void
		//{
			
		//}
		
		
		

		


		
    }
}