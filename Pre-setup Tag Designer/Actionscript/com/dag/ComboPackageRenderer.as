package dag{
	import fl.controls.*;
	import fl.controls.listClasses.*;
	import fl.data.DataProvider;
	import flash.events.*;
	import fl.events.*;

	public class ComboPackageRenderer extends ComboBox implements ICellRenderer {
		private var _listData:ListData;
		private var _data:Object;
		private var _selected:Boolean;
		private var dp:DataProvider = new DataProvider();

		public function ComboPackageRenderer():void {
			super();
			this.dataProvider = dp;
			this.prompt = "Choose Package";
			dp.addItem({label:"Adv Security & Performance", data:"1"});
			dp.addItem({label:"Std Security & Performance", data:"2"});
			dp.addItem({label:"Std Security with Office", data:"3"});
			dp.addItem({label:"Essentials Package", data:"4"});
			dp.addItem({label:"Blue Label Essentials Package", data:"5"});
			dp.addItem({label:"Optimization & Restore CD's", data:"6"});
			dp.addItem({label:"Connect & Protect", data:"7"});
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