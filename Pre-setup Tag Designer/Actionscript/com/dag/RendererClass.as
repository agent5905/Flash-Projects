package dag{
	import fl.controls.*;
	import fl.controls.dataGridClasses.*;
	import flash.display.*;
	import flash.events.*;
	import fl.events.*;
	import fl.data.DataProvider;
	
	public class RendererClass extends Sprite{
		
		private var dp:DataProvider = new DataProvider();
		private var genderCol:DataGridColumn;
		private var lastCol:DataGridColumn;
		private var row:Object;
		
		public function RendererClass():void{
			dg.tabEnabled = false;
			createDataGrid();
		};
		private function createDataGrid():void {
			dg.dataProvider = dp;
			dg.resizableColumns = false;
			dg.rowHeight = 22;
			dg.columns = ["FirstName", "Software", "Package"];
			genderCol = dg.getColumnAt(2);
			genderCol.cellRenderer = ComboPackageRenderer;
			lastCol = dg.getColumnAt(1);
			lastCol.cellRenderer = ComboSoftwareRenderer;
			dg.addEventListener(DataEvent.DATA, workData);
			dg.addEventListener(ListEvent.ITEM_CLICK, itemOver);
			dg.minColumnWidth = dg.width / 6;
			populateGrid(15);
		};
		private function populateGrid(_i:uint):void{
			for(var i:uint = 0;i<_i;i++){
				if ((i % 2) == 0) {
					dp.addItem({FirstName:"James"+i.toString()});//, LastName:"Smith"+i.toString()});
				} else {
					dp.addItem({FirstName:"Jane"+i.toString()});//, LastName:"Doe"+i.toString()});
				};
			};
		};
		private function itemOver(e:ListEvent):void{
			row = e.item;
			trace(e);
		};
		private function workData(e:DataEvent):void{
			alert_txt.text = "You changed "+row.FirstName+" "+" to "+e.data;
			trace(e);
		};
		
	};
};