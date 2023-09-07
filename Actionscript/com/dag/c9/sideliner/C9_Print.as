package dag.c9.sideliner{
    import flash.printing.*;
    import flash.display.*
    import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.geom.Rectangle;
    import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;
	
    public class C9_Print extends Sprite
    {
		private var sheet:Array = new Array();;
		private var pj:PrintJob = new PrintJob();
		private var po:PrintJobOptions = new PrintJobOptions();
		
		private var countSheet:uint = 1;
		private var countItem:uint = 0;
		private var tmpList:Array = new Array();
		
		private var printer:String;
				
        public function C9_Print(tagList:Array, printerType:String):void
        {
			printer = printerType;
			if(init()){
			trace("start printing...")
			trace(tagList);
			//po.printAsBitmap = true;
			trace("Bitmap set...")
			sheet[countSheet] = new Sprite();
			for (var i:Number = 0; i < tagList.length; i++)
			{
				countItem++;
				trace("add item " + (i + 1));
				addItem(tagList[i]);
			}
			trace("countItem%4: " + countItem%4);
			if(countItem%4 != 0 && countItem != 0){
				trace("less than 4 items on a sheet...");
				sheet[countSheet].rotation = 90;
				addSheet(sheet[countSheet]);
			}
			
			printSheet();
			}
			
		}
			
		private function init():Boolean
		{
			if(pj.start())
			{
				
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
        
        private function addItem(_item:Sprite):void
		{		
			switch(countItem)
			{
				case 1:
					_item.x = 0;
					_item.y = 0;
					break;
				case 2:
					_item.x = 389;
					_item.y = 0;
					break;
				case 3:
					_item.x = 0;
					_item.y = 293;
					break;
				case 4:
					_item.x = 389;
					_item.y = 293;
					break;
			}
			if(printer == "INKJET"){
			_item.height = 283;
			}
			sheet[countSheet].addChild(_item);
			
			trace("item " + countItem + " [" + _item.x + " x " + _item.y + "], " + _item.width + ", " + _item.height + " added");
			trace("sheet "  + " [" + sheet[countSheet].x + " x " + sheet[countSheet].y + "], " + sheet[countSheet].width + ", " + sheet[countSheet].height + " ");
			if(countItem%4 == 0){
				sheet[countSheet].rotation = 90;
				trace("4 items on a sheet...");
				addSheet(sheet[countSheet]);
				countSheet++;
				countItem = 0;
				sheet[countSheet] = new Sprite();
			}else{
	
				
	
			}
           
        }
			
		private function addSheet(_sheet:Sprite):void
		{
            trace("added page...");
			
           	pj.addPage(_sheet, null);

           
        }
			
		private function printSheet():void
		{
			
			
        	pj.send();
			trace("print sent");
			pj = null;
		}
        
        
        
       
    }
}
