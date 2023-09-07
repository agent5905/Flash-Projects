package dag.c9.sideliner
{
    import flash.display.MovieClip;
	import flash.xml.*;
	import flash.events.*;
	import flash.net.*;
	import flash.display.Loader;
	import dag.c9.sideliner.CustomEvent;

    public class product extends MovieClip
    {	
	
		public var sku:String;
		public var brand:String;
		public var model:String;
		public var price:String;
		public var productType:String;
        private var request:URLRequest = new URLRequest(); 	
			
		public function product():void{
			super();
        }
	
		public function checkSku():void{
           	var productLoader:URLLoader = new URLLoader();
			request = new URLRequest("http://api.remix.bestbuy.com/v1/products/" + sku + ".xml?apiKey=bnt2fgfhs9q53exuqhpfqwy3&show=salePrice,manufacturer,modelNumber,subclass");
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
			var customEvent:CustomEvent = new CustomEvent("Success");
			
			price = productXml.salePrice.text();
			brand = productXml.manufacturer.text();
			model = productXml.modelNumber.text();
			trace(productXml.modelNumber.text());
			trace(model);
			productType = productXml.product.subclass;
			dispatchEvent(customEvent);
			
  		}
				
    }
}