package dag{
	import flash.display.MovieClip;
    //import flash.display..ProgressBar;
    //import fl.controls.Button;
	import flash.text.TextField
        
    //this class sets the type for the myWindow component
    //we use it as a proxy to the UI controls from the myWindow component 
    //(buttons, labels, text area, or progress bar)
    public class GetDotaMC extends MovieClip {
        
        
        public function set mapName(text:String):void {
           mapVer.text = text;
        }
        /*
        public function set enableDescription(enable:Boolean):void {
           description_mc.visible = enable;
        }
               

        public function enableBar(enable:Boolean):void {
           bar_mc.visible = enable;
        }
        
        public function get bar():ProgressBar {
           return bar_mc;
        }
        
        public function get buttonLeft():Button {
           return button1_mc;
        }
        
        public function get buttonRight():Button {
           return button2_mc;
        }
*/
    }
}