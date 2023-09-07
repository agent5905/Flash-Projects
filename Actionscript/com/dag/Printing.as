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
		private var barcode:MovieClip = new Barcode();
		private var barcode2:MovieClip = new Barcode();
		
		private var tmpSku:String;
		private var tmpBrand:String;
		private var tmpModel:String;
		private var tmpPrice:String;
		private var tmpTitle:String;
		private var tmpRam:String;
		private var tmpHD:String;
		private var tmpBundle:Number;
		private var tmpBTP:Number;
		private var tmpOffice:String;
		private var tmpTotalPrice:String;
		private var tmpAV:Number;
		private var tmpList:Array = new Array();
		
        private var txt:TextField;

        public function Printing(sku:String,brand:String,model:String,price:String,totalprice:String,officeprice:String,titleS:String,ram:String,hd:String,bundle:Number,av:Number,list:Array):void
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
			tmpOffice = officeprice;
			tmpTotalPrice = totalprice;
			tmpAV = av;
			tmpList = list;
			
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
				template.btp.text = "229.99";
			}else if(tmpBTP >= 400 && tmpBTP <= 599.99){
				template.btp.text = "269.99";
			}else if(tmpBTP >= 600 && tmpBTP <= 749.99){
				template.btp.text = "299.99";
			}else if(tmpBTP >= 750 && tmpBTP <= 999.99){
				template.btp.text = "329.99";
			}else if(tmpBTP >= 1000 && tmpBTP <= 1499.99){
				template.btp.text = "399.99";
			}else if(tmpBTP >= 1500){
				template.btp.text = "449.99";
			}
			
			
			if(tmpTotalPrice.length <= 6){
		   if(tmpTotalPrice.indexOf(".") > -1){
			   	template.bundle.totprice2.text = "";
				template.bundle.totprice.text = tmpTotalPrice.substr(0,tmpTotalPrice.indexOf("."));
				template.bundle.totcents.text = tmpTotalPrice.substring(tmpTotalPrice.indexOf(".") + 1,tmpTotalPrice.length);
		   }else{
			    template.bundle.totprice2.text = "";
				template.bundle.totprice.text = tmpTotalPrice;
				template.bundle.totcents.text = "00";
		   }
		}else{
				template.bundle.totprice.text = "";
				template.bundle.totprice2.text = tmpTotalPrice.substr(0,tmpTotalPrice.indexOf("."));
				template.bundle.totcents.text = tmpTotalPrice.substring(tmpTotalPrice.indexOf(".") + 1,tmpTotalPrice.length);
		}
			
			template.bundle.gotoAndStop(tmpBundle);
			template.bundle.software.gotoAndStop(tmpAV);
			
			switch(tmpBundle - 1){
		case 3:
			template.bundle.officeprice1.text = "$" + tmpOffice;
			template.bundle.officeprice2.text = "";
			template.bundle.officeprice3.text = "";
			break;
		case 4:
			template.bundle.officeprice1.text = "";
			template.bundle.officeprice2.text = "$" + tmpOffice;
			template.bundle.officeprice3.text = "";
			break;
		case 5:
			template.bundle.officeprice1.text = "";
			template.bundle.officeprice2.text = "";
			template.bundle.officeprice3.text = "$" + tmpOffice;
			break;
		default:
			template.bundle.officeprice1.text = "";
			template.bundle.officeprice2.text = "";
			template.bundle.officeprice3.text = "";
			break;
	}
			
			if( tmpList[0] != null){
				template.line1.text = tmpList[0];
				template.c1.visible = true;
			}else{
				template.line1.text = "";
				template.c1.visible = false;
			}
			if( tmpList[1] != null){
				template.line2.text = tmpList[1];
				template.c2.visible = true;
			}else{
				template.line2.text = "";
				template.c2.visible = false;
			}
			if( tmpList[2] != null){
				template.line3.text = tmpList[2];
				template.c3.visible = true;
			}else{
				template.line3.text = "";
				template.c3.visible = false;
			}
			if( tmpList[3] != null){
				template.line4.text = tmpList[3];
				template.c4.visible = true;
			}else{
				template.line4.text = "";
				template.c4.visible = false;
			}
			if( tmpList[4] != null){
				template.line5.text = tmpList[4];
				template.c5.visible = true;
			}else{
				template.line5.text = "";
				template.c5.visible = false;
			}
			
			///////////////////////////////////////////Template 2////////////////////////////////
			var i:int = 0;
			while(i < template.numChildren) {
    			trace(template.getChildAt(i).name + " is at position: " + i++);
			}
			
							 
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
				template2.btp.text = "229.99";
			}else if(tmpBTP >= 400 && tmpBTP <= 599.99){
				template2.btp.text = "269.99";
			}else if(tmpBTP >= 600 && tmpBTP <= 749.99){
				template2.btp.text = "299.99";
			}else if(tmpBTP >= 750 && tmpBTP <= 999.99){
				template2.btp.text = "329.99";
			}else if(tmpBTP >= 1000 && tmpBTP <= 1499.99){
				template2.btp.text = "399.99";
			}else if(tmpBTP >= 1500){
				template2.btp.text = "449.99";
			}
			
			
			template2.bundle.gotoAndStop(tmpBundle);
			template2.bundle.software.gotoAndStop(tmpAV);
			
			if(tmpTotalPrice.length <= 6){
		   if(tmpTotalPrice.indexOf(".") > -1){
			   	template2.bundle.totprice2.text = "";
				template2.bundle.totprice.text = tmpTotalPrice.substr(0,tmpTotalPrice.indexOf("."));
				template2.bundle.totcents.text = tmpTotalPrice.substring(tmpTotalPrice.indexOf(".") + 1,tmpTotalPrice.length);
		   }else{
			    template2.bundle.totprice2.text = "";
				template2.bundle.totprice.text = tmpTotalPrice;
				template2.bundle.totcents.text = "00";
		   }
		}else{
				template2.bundle.totprice.text = "";
				template2.bundle.totprice2.text = tmpTotalPrice.substr(0,tmpTotalPrice.indexOf("."));
				template2.bundle.totcents.text = tmpTotalPrice.substring(tmpTotalPrice.indexOf(".") + 1,tmpTotalPrice.length);
		}
			
			switch(tmpBundle - 1){
		case 3:
			template2.bundle.officeprice1.text = "$" + tmpOffice;
			template2.bundle.officeprice2.text = "";
			template2.bundle.officeprice3.text = "";
			break;
		case 4:
			template2.bundle.officeprice1.text = "";
			template2.bundle.officeprice2.text = "$" + tmpOffice;
			template2.bundle.officeprice3.text = "";
			break;
		case 5:
			template2.bundle.officeprice1.text = "";
			template2.bundle.officeprice2.text = "";
			template2.bundle.officeprice3.text = "$" + tmpOffice;
			break;
		default:
			template2.bundle.officeprice1.text = "";
			template2.bundle.officeprice2.text = "";
			template2.bundle.officeprice3.text = "";
			break;
	}
			
			if( tmpList[0] != null){
				template2.line1.text = tmpList[0];
				template2.c1.visible = true;
			}else{
				template2.line1.text = "";
				template2.c1.visible = false;
			}
			if( tmpList[1] != null){
				template2.line2.text = tmpList[1];
				template2.c2.visible = true;
			}else{
				template2.line2.text = "";
				template2.c2.visible = false;
			}
			if( tmpList[2] != null){
				template2.line3.text = tmpList[2];
				template2.c3.visible = true;
			}else{
				template2.line3.text = "";
				template2.c3.visible = false;
			}
			if( tmpList[3] != null){
				template2.line4.text = tmpList[3];
				template2.c4.visible = true;
			}else{
				template2.line4.text = "";
				template2.c4.visible = false;
			}
			if( tmpList[4] != null){
				template2.line5.text = tmpList[4];
				template2.c5.visible = true;
			}else{
				template2.line5.text = "";
				template2.c5.visible = false;
			}
			
		
			template2.x = 288;
			
			
			
			sheet.addChild(template);
			sheet.addChild(template2);
			
			switch(tmpBundle -1){
				case 1:
					switch(tmpAV - 1){
						case 1:
							barcode.gotoAndStop(1);
							barcode2.gotoAndStop(1);
							break;
						case 2:
							barcode.gotoAndStop(2);
							barcode2.gotoAndStop(2);
							break;
						case 3:
							barcode.gotoAndStop(3);
							barcode2.gotoAndStop(3);
							break;						
					}
					break;
				case 2:
						switch(tmpAV - 1){
						case 1:
							barcode.gotoAndStop(4);
							barcode2.gotoAndStop(4);
							break;
						case 2:
							barcode.gotoAndStop(5);
							barcode2.gotoAndStop(5);
							break;
						case 3:
							barcode.gotoAndStop(6);
							barcode2.gotoAndStop(6);
							break;						
					}
					break;
				case 3:
					switch(tmpAV - 1){
						case 1:
							barcode.gotoAndStop(7);
							barcode2.gotoAndStop(7);
							break;
						case 2:
							barcode.gotoAndStop(8);
							barcode2.gotoAndStop(8);
							break;
						case 3:
							barcode.gotoAndStop(9);
							barcode2.gotoAndStop(9);
							break;						
					}
					break;
				case 4:
					switch(tmpAV - 1){
						case 1:
							barcode.gotoAndStop(10);
							barcode2.gotoAndStop(10);
							break;
						case 2:
							barcode.gotoAndStop(11);
							barcode2.gotoAndStop(11);
							break;
						case 3:
							barcode.gotoAndStop(12);
							barcode2.gotoAndStop(12);
							break;						
					}
					break;
				case 5:
						barcode.gotoAndStop(13);
						barcode2.gotoAndStop(13);
						break;
				case 6:
						barcode.gotoAndStop(14);
						barcode2.gotoAndStop(14);
						break;
			}
			
			barcode.y = 396;
			barcode.x = 11;
			
			barcode2.y = 396;
			barcode2.x = 299;
			
			
			sheet.addChild(barcode);
			sheet.addChild(barcode2);
			
		}
        
        private function draw():void
        {
           addChild(sheet);
		


           
        }
    }
}

