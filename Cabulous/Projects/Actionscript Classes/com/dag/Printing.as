package dag{
    import flash.printing.PrintJob;
    import flash.display.*
    import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.geom.Rectangle;
       
    public class Printing extends Sprite
    {
        private var bg:Sprite;
		private var sheet:Sprite;
		private var textf:TextField = new TextField();
		private var centsText:TextField = new TextField();
		private var newFormat:TextFormat = new TextFormat();
		private var newFormat2:TextFormat = new TextFormat();
		private var template:MovieClip = new TagTemplate();
		private var template2:MovieClip = new TagTemplate();
		
		private var tmpSku:String;
		private var tmpBrand:String;
		private var tmpModel:String;
		private var tmpPrice:String;
		private var tmpTitle:String;
		private var tmpRam:String;
		private var tmpHD:String;
		private var tmpBundle:Number;
		private var tmpBTP:Number;
		
        private var txt:TextField;

        public function Printing(sku:String,brand:String,model:String,price:String,titleS:String,ram:String,hd:String,bundle:Number):void
        {
            
			tmpSku = sku;
			tmpBrand = brand;
			tmpModel = model;
			tmpPrice = price;
			tmpTitle = titleS;
			tmpRam = ram;
			tmpHD = hd;
			tmpBundle = bundle;
			tmpBTP = Number(price);
			
			init();
            draw();
            printPage();
        }
        
        private function printPage():void
        {
            var pj:PrintJob = new PrintJob();
            
            if (pj.start())
            {
                trace(">> pj.orientation: " + pj.orientation);
                trace(">> pj.pageWidth: " + pj.pageWidth);
                trace(">> pj.pageHeight: " + pj.pageHeight);
                trace(">> pj.paperWidth: " + pj.paperWidth);
                trace(">> pj.paperHeight: " + pj.paperHeight);    

                try
                {
                    pj.addPage(this, null);
                }
                catch (error:Error)
                {
                    trace(error);// Do nothing.
                }
                pj.send();
            }
            else
            {
               
            }
            // Reset the txt scale properties.
           
        }
        
        private function init():void
        {
            //mc.name = "mc";
			sheet = new Sprite();
			//bundle.gotoAndStop(2);
			//bundle.x = 27.4;
			//bundle.y = 211.7;
			//bundle.name = "bundle";
			
			
			//template.addChild(bundle);
			 if(tmpPrice.length <= 6){
				if(tmpPrice.indexOf(".") > -1){
					template.price.text = tmpPrice.substr(0,tmpPrice.indexOf("."));
					template.cents.text = tmpPrice.substring(tmpPrice.indexOf(".") + 1,tmpPrice.length);
				}else{
			    	template.price.text = tmpPrice;
					template.cents.text = "00";
		   		}
			 }else{
				template.price2.text = tmpPrice.substr(0,tmpPrice.indexOf("."));
				template.cents.text = tmpPrice.substring(tmpPrice.indexOf(".") + 1,tmpPrice.length);
			 }
			template.model.text = tmpModel;
			template.brand.text = tmpBrand;
			template.titleT.text = tmpTitle;
			template.ram.text = tmpRam;
			template.hd.text = tmpHD;
			template.sku.text = tmpSku;
			
			if(tmpBTP >= 0 && tmpBTP <= 399.99){
				template.btp.text = "129.99";
			}else if(tmpBTP >= 400 && tmpBTP <= 599.99){
				template.btp.text = "169.99";
			}else if(tmpBTP >= 600 && tmpBTP <= 749.99){
				template.btp.text = "199.99";
			}else if(tmpBTP >= 750 && tmpBTP <= 999.99){
				template.btp.text = "229.99";
			}else if(tmpBTP >= 1000 && tmpBTP <= 1499.99){
				template.btp.text = "299.99";
			}else if(tmpBTP >= 1500){
				template.btp.text = "349.99";
			}
			
			template.bundle.gotoAndStop(tmpBundle);
			
			var i:int = 0;
			while(i < template.numChildren) {
    			trace(template.getChildAt(i).name + " is at position: " + i++);
			}
			
			//template2.addChild(bundle);
							 
			 if(tmpPrice.length <= 6){
				if(tmpPrice.indexOf(".") > -1){
					template2.price.text = tmpPrice.substr(0,tmpPrice.indexOf("."));
					template2.cents.text = tmpPrice.substring(tmpPrice.indexOf(".") + 1,tmpPrice.length);
				}else{
			    	template2.price.text = tmpPrice;
					template2.cents.text = "00";
		   		}
			 }else{
				template2.price2.text = tmpPrice.substr(0,tmpPrice.indexOf("."));
				template2.cents.text = tmpPrice.substring(tmpPrice.indexOf(".") + 1,tmpPrice.length);
			 }
			template2.model.text = tmpModel;
			template2.brand.text = tmpBrand;
			template2.titleT.text = tmpTitle;
			template2.ram.text = tmpRam;
			template2.hd.text = tmpHD;
			template2.sku.text = tmpSku;
			
			
			if(tmpBTP >= 0 && tmpBTP <= 399.99){
				template2.btp.text = "129.99";
			}else if(tmpBTP >= 400 && tmpBTP <= 599.99){
				template2.btp.text = "169.99";
			}else if(tmpBTP >= 600 && tmpBTP <= 749.99){
				template2.btp.text = "199.99";
			}else if(tmpBTP >= 750 && tmpBTP <= 999.99){
				template2.btp.text = "229.99";
			}else if(tmpBTP >= 1000 && tmpBTP <= 1499.99){
				template2.btp.text = "299.99";
			}else if(tmpBTP >= 1500){
				template2.btp.text = "349.99";
			}
			
			
			template2.bundle.gotoAndStop(tmpBundle);
			template2.x = 288;
			
			
			sheet.addChild(template);
			sheet.addChild(template2);
		}
        
        private function draw():void
        {
           addChild(sheet);
		


           
        }
    }
}

