package bestbuy
{
    import flash.display.MovieClip;
	import flash.xml.*;
	import flash.events.*;
	import flash.net.*;
	import flash.display.Loader;
	import flash.display.Bitmap;
	import dag.CustomEvent;

    public class product extends MovieClip
    {	
	
		public var sku:String;
		public var brand:String;
		public var dollarPrice:String;
		public var centsPrice:String;
		public var processor:String;
		public var ram:String;
		public var hd:String;
		public var image:Bitmap;
		
		private var short:String;
		private var price:String;
		private var itemLoader:Loader = new Loader();
		private var leftImageURL:String;
		private var frontImageURL:String;
		private var imageURL:String;
		private var request:URLRequest = new URLRequest(); 	
			
		public function product():void{
			super();
        }
	
		public function checkSku():void{
           	var productLoader:URLLoader = new URLLoader();
			request = new URLRequest("http://api.remix.bestbuy.com/v1/products/" + sku + ".xml?apiKey=bnt2fgfhs9q53exuqhpfqwy3&show=salePrice,manufacturer,shortDescription,leftViewImage,image");
			productLoader.addEventListener(Event.COMPLETE, productLoaderCompleteHandler);
            productLoader.addEventListener(ProgressEvent.PROGRESS, productLoaderProgressHandler);
            productLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, productLoaderHttpStatusHandler);
			productLoader.addEventListener(IOErrorEvent.IO_ERROR,productErrorHandler);
			productLoader.load(request);
			
			
			
        }
		
		private function productLoaderProgressHandler(event:ProgressEvent):void {
            trace("productLoaderProgressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
			
        }
        
        private function productLoaderHttpStatusHandler(event:HTTPStatusEvent):void {
            trace("productLoaderHttpStatusHandler: " + event);
        }
		
		private function productErrorHandler(event:IOErrorEvent):void {
            trace("productErrorHandler: " + event);
			var customEvent:CustomEvent = new CustomEvent("Fail");
			dispatchEvent(customEvent);
			
		}
		
		private function productLoaderCompleteHandler(event:Event):void {
            var productXml = new XML(event.target.data);
			trace(productXml);
			
			
			price = productXml.salePrice.text();
			dollarPrice = priceExtractor(price,true);
			centsPrice = priceExtractor(price,false);
			brand = productXml.manufacturer.text();
			short = productXml.shortDescription.text();
			leftImageURL = productXml.leftViewImage.text();
			frontImageURL = productXml.image.text();
			shortDescExtractor(short);
			
			if(leftImageURL == ""){
				imageURL = frontImageURL;
			} else {
				imageURL = leftImageURL;
			}
			
			itemLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, itemLoaderCompleteHandler);
           	itemLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, itemLoaderProgressHandler);
            itemLoader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, itemLoaderHttpStatusHandler);
			loadImage(imageURL);
			
			
			
  		}
		
		private function priceExtractor(priceValue:String,dollar:Boolean):String {
            var location = priceValue.indexOf(".");
			var length = priceValue.length;
			var dollarValue = priceValue.substring(0,location);
			var centsValue = priceValue.substring(location+1, length);
			if(dollar == true){
				return dollarValue;
			}else{
				return centsValue;
			}
			
  		}
		
		private function shortDescExtractor(description:String):void {
			var length = description.length;
            var locationOfProcessor = description.indexOf("Intel");
			if (locationOfProcessor == -1){
				locationOfProcessor = description.indexOf("AMD");
			}
			
			var endLength = description.indexOf(";");
			
			processor = description.substring(locationOfProcessor, endLength);
			
			
			var locationOfMemory = description.indexOf("memory");
			ram = description.substring(locationOfMemory-4, locationOfMemory-1);
			
			var locationOfHD = description.indexOf("hard",locationOfMemory);
			hd = description.substring(locationOfMemory+8, locationOfHD-1);
			
  		}
		
		private function loadImage(imageAddress):void {
			request = new URLRequest(imageAddress);
			itemLoader.load(request);
		}
		
		private function itemLoaderProgressHandler(event:ProgressEvent):void {
            trace("itemProgressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
			//loadBarChange(infoString, (event.bytesLoaded / event.bytesTotal));
        }
        
        private function itemLoaderHttpStatusHandler(event:HTTPStatusEvent):void {
            trace("itemHttpStatusHandler: " + event);
        }
	
		private function itemLoaderCompleteHandler(event:Event):void {
			image = Bitmap(event.target.content);
			image.smoothing = true;
			image.width = 97.10;
			image.height = 110.45;
			
			
			itemLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, itemLoaderCompleteHandler);
			itemLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, itemLoaderProgressHandler);
            itemLoader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, itemLoaderHttpStatusHandler);
			
			var customEvent:CustomEvent = new CustomEvent("Success");
			dispatchEvent(customEvent);
        }
				
    }
}