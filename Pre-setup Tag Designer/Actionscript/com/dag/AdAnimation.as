package dag{
	import flash.display.*

    public class AdAnimation extends MovieClip {
		
       
        public function AdAnimation(item:String,textItem:Array):void {
           description_mc.text = text;
        }
        
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

    }
}