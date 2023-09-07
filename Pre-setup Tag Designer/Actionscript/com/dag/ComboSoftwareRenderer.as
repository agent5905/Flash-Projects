package dag{
	import fl.controls.*;
	import fl.controls.listClasses.*;
	import fl.data.DataProvider;
	import flash.events.*;
	import fl.events.*;

	public class ComboSoftwareRenderer extends ComboBox implements ICellRenderer {
		private var _listData:ListData;
		private var _data:Object;
		private var _selected:Boolean;
		private var dp:DataProvider = new DataProvider();

		public function ComboSoftwareRenderer():void {
			super();
			this.dataProvider = dp;
			this.prompt = "Choose Software";
			dp.addItem({label:"Trend Micro AV & Spy Sweeper", data:"Trend Micro AV & Spy Sweeper"});
			dp.addItem({label:"Trend Micro IS", data:"Trend Micro IS"});
			dp.addItem({label:"Kaspersky IS", data:"Kaspersky IS"});
			dp.addItem({label:"Spy Sweeper with Anti-Virus", data:"Spy Sweeper with Anti-Virus"});
			addEventListener(Event.CHANGE, clicked);
		}
		public function set data(d:Object):void {
			_data = d;
		}
		public function get data():Object {
			return _data;
		}
		public function set listData(ld:ListData):void {
			_listData = ld;
		}
		public function get listData():ListData {
			return _listData;
		}
		public function setMouseState(state:String):void {
        }
		public function set selected(s:Boolean):void {
			_selected = s;
		}
		public function get selected():Boolean {
			return _selected;
		}
		public function clicked(e:Event):void {
			this.listData.owner.dispatchEvent(new DataEvent("data", false, false, this.selectedItem.data));
		}
	}
}