package dag{
	import flash.filesystem.*;
	import flash.display.*
	
	
	public class DataGridRow extends MovieClip
    {
		public function DataGridRow():void
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