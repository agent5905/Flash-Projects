package dag.sm{
	import flash.net.*
	import flash.filesystem.*;
	import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.events.*;
	import fl.controls.dataGridClasses.DataGridColumn;
	import fl.controls.ComboBox;
	import fl.controls.CheckBox;
	import fl.controls.DataGrid;
	import fl.data.DataProvider;
    //This class is used to handle the stock ticker in the screen messenger program.
    public class tabs extends MovieClip {
       
	   var dpShec:DataProvider = new DataProvider();
	   var dpTodo:DataProvider = new DataProvider();
	   var dpNews:DataProvider = new DataProvider();
	   var dpName:DataProvider
	   var loadedXml:XML;
	   var loader:URLLoader = new URLLoader();
	   var Names:Array = new Array();
	   var targetIndex:Number;
	   var targetTIndex:Number;
	   var targetNIndex:Number;
	   
	   
	   
	
	   public function tabs():void 
		{
			this.todo.visible = false;
			this.news.visible = false;
			
			d_schedule.addEventListener(MouseEvent.CLICK, clkSchedule);
			d_todo.addEventListener(MouseEvent.CLICK, clkTodo);
			d_news.addEventListener(MouseEvent.CLICK, clkNews);
			
			this.schedule.dgShec.addEventListener(Event.CHANGE, clkShecItem);
			this.schedule.btnShecAdd.addEventListener(MouseEvent.CLICK, addName);
			this.schedule.btnShecDel.addEventListener(MouseEvent.CLICK, delName);
			
			this.todo.dgTodo.addEventListener(Event.CHANGE, clkTodoItem);
			this.todo.btnTodoAdd.addEventListener(MouseEvent.CLICK, addItem);
			this.todo.btnTodoDel.addEventListener(MouseEvent.CLICK, delItem);
			
			this.news.dgNews.addEventListener(Event.CHANGE, clkNewsItem);
			this.news.btnNewsAdd.addEventListener(MouseEvent.CLICK, addNews);
			this.news.btnNewsDel.addEventListener(MouseEvent.CLICK, delNews);
			
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError, false, 0, true);
			
			//loader.load( new URLRequest(File.documentsDirectory.resolvePath("xml/skulist.xml").url));
			loader.load( new URLRequest("xml/employeelist.xml"));
			
			this.schedule.dgShec.columns = ["NAME", "START TIME", "END TIME"];
			this.schedule.dgShec.dataProvider = dpShec;
			
			this.todo.dgTodo.columns = ["TODO ITEM"];
			this.todo.dgTodo.dataProvider = dpTodo;
			
			this.news.dgNews.columns = ["NEWS ITEM"];
			this.news.dgNews.dataProvider = dpNews;
		}
	   
		
	   private function clkSchedule (e:MouseEvent):void
	   	{
			this.schedule.visible = true;
			this.todo.visible = false;
			this.news.visible = false;
		}
	   
	   private function clkTodo (e:MouseEvent):void
	   	{
			this.schedule.visible = false;
			this.todo.visible = true;
			this.news.visible = false;
		}
	   
	   private function clkNews (e:MouseEvent):void
	   	{
			this.schedule.visible = false;
			this.todo.visible = false;
			this.news.visible = true;
		}
		
		
		///////////////////////////////////////Shecdule Tab//////////////////////////////////////////////////////////
		
		
		private function addName (e:MouseEvent):void
	   	{
			
			var strStart:String = this.schedule.txtStartTime.text + " " + this.schedule.cmbStartAP.text;
			var strEnd:String = this.schedule.txtEndTime.text + " " + this.schedule.cmbEndAP.text;
			
			dpShec.addItem({NAME:this.schedule.cmbName.text, 'START TIME':strStart, 'END TIME':strEnd});
		}
		
		private function onComplete(e:Event):void {
			try{
				loadedXml = new XML(e.target.data)
				
				for each( var strName:XML in loadedXml..@name){
					Names.push({label:strName, data:0});
				}
				
				dpName = new DataProvider(Names);
				this.schedule.cmbName.dataProvider = dpName;
				
				loader.removeEventListener(Event.COMPLETE, onComplete);
				loader.removeEventListener (IOErrorEvent.IO_ERROR, onIOError);
			}catch(err:Error){
				trace("Load Error:\n" + err.message);
			}
																				   
		}

		private function onIOError(e:IOErrorEvent):void {
			trace("IO Error:\n" + e.text);
		}

		private function clkShecItem (e:Event):void
	   	{
			trace(e.target);
			targetIndex = DataGrid(e.target).selectedIndex;
			
			 
			
		}

		private function delName (e:MouseEvent):void
	   	{
			dpShec.removeItemAt(targetIndex);
		}
		
		///////////////////////////////////////Todo Tab//////////////////////////////////////////////////////////
		
		
		private function addItem (e:MouseEvent):void
	   	{			
					dpTodo.addItem({'TODO ITEM':this.todo.txtItem.text});
		}
		
		private function clkTodoItem (e:Event):void
	   	{
			targetTIndex = DataGrid(e.target).selectedIndex;
		}

		private function delItem (e:MouseEvent):void
	   	{
			dpTodo.removeItemAt(targetTIndex);
		}
		
		///////////////////////////////////////News Tab//////////////////////////////////////////////////////////
		
		
		private function addNews (e:MouseEvent):void
	   	{			
					dpNews.addItem({'NEWS ITEM':this.news.txtItem.text});
		}
		
		private function clkNewsItem (e:Event):void
	   	{
			targetNIndex = DataGrid(e.target).selectedIndex;
		}

		private function delNews (e:MouseEvent):void
	   	{
			dpNews.removeItemAt(targetNIndex);
		}
		
    }
}