package dag{
	import flash.printing.PrintJob;
    import flash.display.*
	import flash.events.*;
	
	public class PrintSheet extends Sprite
    {
		var pj:PrintJob = new PrintJob();
		
		public function PrintSheet():void
        {
			
		}
		
		public function init():Boolean {
            
			if(pj.start()){
				trace(">> pj.orientation: " + pj.orientation);
                trace(">> pj.pageWidth: " + pj.pageWidth);
                trace(">> pj.pageHeight: " + pj.pageHeight);
                trace(">> pj.paperWidth: " + pj.paperWidth);
                trace(">> pj.paperHeight: " + pj.paperHeight);
				return true;
            }else{
               //Canceled Print
			   return false;
            }
			
        	}
					
		public function addSheet(sheet:Sprite):void{
            
            trace(sheet);
            try {
         		pj.addPage(sheet, null);
       		}
       		catch(e:Error) {
				trace(e);
         	 // handle error 
       		}

           
        	}
			
		public function printSheet():void{
            
            
            
                pj.send();
			}
		
			
		
	}
}
		
		