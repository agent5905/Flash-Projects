﻿package dag{
	import flash.filesystem.*;
	import flash.display.*
	
	
	public class Writing extends Sprite
    {
		public function Writing(xml:String):void
        {
					
					var myFile:File =  File.documentsDirectory.resolvePath("xml/skulist.xml");
					//trace(myFile.url);
   					var myFileStream:FileStream = new FileStream();
   					myFileStream.openAsync(myFile, FileMode.WRITE);
   					myFileStream.writeUTFBytes(xml);
					myFileStream.close();
			
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}