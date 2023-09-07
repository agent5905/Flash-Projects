import flash.net.*
import flash.filesystem.*;
import flash.display.*;
import fl.managers.FocusManager;
import flash.events.*;
import fl.controls.dataGridClasses.DataGridColumn;
import fl.controls.ComboBox;
import fl.controls.CheckBox;
import fl.data.DataProvider;
import dag.FlashUpdater
import dag.PrintSheet;

var loadXml:XML;
var loader:URLLoader = new URLLoader();

var newClick = new MouseEvent(MouseEvent.CLICK);

var Counter:uint=0;
var _Tag:Array = new Array();
var _Sheet:Array = new Array();
var _PrintTag:Array = new Array();

var fm:FocusManager = new FocusManager(this);

scrollb.sbUpdate()

office.tabIndex = 1;
sku.tabIndex = 2;
price.tabIndex = 3;
bundle.bundle.tabIndex = 4;
software.software.tabIndex = 5;


sku.restrict = "0-9";
price.restrict = ".0-9"
office.restrict = ".0-9"

fm.setFocus(office);

bundle.bundle.addEventListener(Event.CHANGE, bundleChange);
dg.addEventListener(Event.CHANGE, dgChange);
/////////////////////////////////////////////////////
/* Create and populate a new DataProvider object. Note that three of the items
   in the data provider refer to externally-loaded images, whereas the last two
   items refer to symbol linkages in the library. */
var dp:DataProvider = new DataProvider();

var mc:MovieClip = new MovieClip();

dg.columns = ["SKU", "BRAND", "MODEL", "PRICE", "PACKAGE", "SOFTWARE", "OFFICE"];
dg.dataProvider = dp;

bundle.visible = false;
software.visible = false;
edit_button.visible = false;
///////////////////////////////////////////////////


var dSku:String;
var dBrand:String;
var dModel:String;
var dPrice:String;

//var dX = -7;
var dY = -27;
var tPrice:Number;
var tBundle:Number;
var tSoftware:Number;
var tRow:Number = 0;
var tRow2:Number = 1;
var tCountSheet:uint = 1;
var tCount:uint = 0;
var et:Number;

var softwareSet1:Array = [
{label:"(Choose Software)", data:"0"},
{label:"Trend Micro AV & Spy Sweeper", data:"1"},
{label:"Trend Micro IS", data:"2"},
{label:"Kaspersky IS", data:"3"},
{label:"Spy Sweeper with Anti-Virus", data:"4"},
];

var softwareSet2:Array = [
{label:"(Choose Software)", data:"0"},
{label:"Trend Micro IS Included", data:"5"},
{label:"Norton Included", data:"6"},
];

software.software.dataProvider = new DataProvider(softwareSet1);

sku.addEventListener(Event.CHANGE, changeHandlerS);

add_button.addEventListener(MouseEvent.CLICK, click_addButton);
print_button.addEventListener(MouseEvent.CLICK, click_printButton);
edit_button.addEventListener(MouseEvent.CLICK, click_editButton);
popup.ok_button.addEventListener(MouseEvent.CLICK, ok_buttonClick);

var obj:InteractiveObject;

var fm2:FocusManager = new FocusManager(this);
fm2.deactivate();

fm.defaultButtonEnabled = true;
fm.defaultButton  = add_button;

disable_mc.visible = false;
popup.visible = false;


var checkUpdate:FlashUpdater = new FlashUpdater("http://www.d4g.us/bby/update/update_sld.xml");

var my_loader:URLLoader = new URLLoader();
var URLcontent:String;
var dollarSign:Number;
var decimalPoint:Number;
var unitPrice:String;
var difference:Number;
var url;

browser_button.addEventListener(MouseEvent.CLICK, browseButton);

function browseButton (e:MouseEvent):void{
url = "http://www.bestbuy.com/site/olspage.jsp?_dyncharset=ISO-8859-1&id=pcat17071&type=page&st=" + sku.text + "&sc=Global&cp=1&nrp=15&sp=&qp=&list=n&iht=y&usc=All+Categories&ks=960"; 
var urlReq = new URLRequest(url);
navigateToURL(urlReq);
}

replace_button.addEventListener(MouseEvent.CLICK, replaceButton);

function replaceButton (e:MouseEvent):void{
price.text = onlinePrice.text;
onlineStatus.gotoAndStop(2);
replace_button.visible = false;

}

replace_button.visible = false;
browser_button.visible = false;

my_loader.addEventListener(Event.COMPLETE, loaderComplete);
my_loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);



function clearEdit(){
	clearTag()
software.visible = false;
software.software.selectedIndex = 0;
bundle.visible = false;
edit_button.visible = false;
dg.selectedIndices = null;

	
}

function click_addButton(e:MouseEvent){
	if(addCheck()){
	addTag();
	}
	
}

function click_printButton(e:MouseEvent){
	if(dg.length != 0){
	Prints();
	}else{
		obj = sku;
		alertbox("Please make sure to enter a correct sku before attempting to Print.");
	}
	
}

function click_editButton(e:MouseEvent){
	
	if(editCheck()){
	EditTag(et);
	}
	
}

function dgChange(e:Event){
	trace(DataGrid(e.target).selectedIndex);
	
	sku_di.text = DataGrid(e.target).selectedItem.SKU;
	brand_di.text = DataGrid(e.target).selectedItem.BRAND;
	model_di.text = DataGrid(e.target).selectedItem.MODEL;
	price.text = DataGrid(e.target).selectedItem.PRICE
	
	bundle.visible = true;
	switch(DataGrid(e.target).selectedItem.PACKAGE){
		case "Adv Security & Performance":
			bundle.bundle.selectedIndex = 1;
			software.software.dataProvider = new DataProvider(softwareSet1)
			break;
		case "Std Security & Performance":
			bundle.bundle.selectedIndex = 2;
			software.software.dataProvider = new DataProvider(softwareSet1)
			break;
		case "Adv Security Pre-Bundled AV":
			bundle.bundle.selectedIndex = 3;
			software.software.dataProvider = new DataProvider(softwareSet2)
			break;
		case "Std Security Pre-Bundled AV":
			bundle.bundle.selectedIndex = 4;
			software.software.dataProvider = new DataProvider(softwareSet2)
			break;
	}
	software.visible = true;
	switch(DataGrid(e.target).selectedItem.SOFTWARE){
	
		case "Trend Micro AV & Spy Sweeper":
			software.software.selectedIndex = 1;
			break;
		case "Trend Micro IS":
			software.software.selectedIndex = 2;
			break;
		case "Kaspersky IS":
			software.software.selectedIndex = 3;
			break;
		case "Spy Sweeper with Anti-Virus":
			software.software.selectedIndex = 4;
			break;
		case "Trend Micro IS Included":
			software.software.selectedIndex = 5;
			break;
		case "Norton Included":
			software.software.selectedIndex = 6;
			break;
	}
	et = DataGrid(e.target).selectedIndex;
	trace("index:", DataGrid(e.target).selectedIndex);
	//DataGrid(e.target).selectedIndex = null;
	edit_button.visible = true;
}

function bundleChange(e:Event){
	switch(Number(ComboBox(e.target).selectedItem.data)){
		case 0:
			software.software.dataProvider = new DataProvider(softwareSet1)
			break;
		case 1:
			software.software.dataProvider = new DataProvider(softwareSet1)
			software.visible = true;
			break;
		case 2:
			software.software.dataProvider = new DataProvider(softwareSet1)
			software.visible = true;
			break;
		case 3:
			software.software.dataProvider = new DataProvider(softwareSet2)
			software.visible = true;
			break;
		case 4:
			software.software.dataProvider = new DataProvider(softwareSet2)
			software.visible = true;
			break;
	}
}

function changeHandlerS(e:Event):void {
	
	if(sku.text != ""){
	load_buttonClick(MouseEvent(newClick));
	}else{
    status.gotoAndStop(1);
	}
}

function load_buttonClick(e:MouseEvent) {
if(checkSkuValue()){
loader.addEventListener(Event.COMPLETE, onComplete);
loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError, false, 0, true);
loader.load( new URLRequest(File.documentsDirectory.resolvePath("xml/skulist.xml").url));
}
}

function onComplete(e:Event):void {
try{
	loadXml = new XML(e.target.data)
	
	searchSku(loadXml);
	
	loader.removeEventListener(Event.COMPLETE, onComplete);
	loader.removeEventListener (IOErrorEvent.IO_ERROR, onIOError);
}catch(err:Error){
	trace("Load Error:\n" + err.message);
}
																				   
}

function onIOError(e:IOErrorEvent):void {
trace("IO Error:\n" + e.text);
}


function searchSku(xml:XML):void{
	var strXml:String = String(xml.*.(@sku == sku.text));
	
	if( strXml == ""){
		//obj = brand;
			status.gotoAndStop(3);
		//alertbox("Sku not found. Please create the item info and save.")
	}else{
	dBrand = xml.*.(@sku == sku.text).brand;
	dModel = xml.*.(@sku == sku.text).model;
	dPrice = xml.*.(@sku == sku.text).price;
	dSku = xml.*.(@sku == sku.text).@sku;
	/*titleT.text = xml.*.(@sku == sku.text).tittle;
	ram.text = xml.*.(@sku == sku.text).ram;
	hd.text = xml.*.(@sku == sku.text).hd;
	updateTagText();*/
	updateTag();
	
	onlinePrice.text = "";
	replace_button.visible = false;
	browser_button.visible = false;
	onlineStatus.gotoAndStop(1);
	try {
    	my_loader.load(new URLRequest("http://www.bestbuy.com/site/olspage.jsp?_dyncharset=ISO-8859-1&id=pcat17071&type=page&st=" + sku.text + "&sc=Global&cp=1&nrp=15&sp=&qp=&list=n&iht=y&usc=All+Categories&ks=960"));
		onlineStatus.gotoAndStop(7);
		} catch (error) {
    		trace("Unable to load requested document.");
    }

	
	status.gotoAndStop(2);
	if(auto_fill.selected){
		switch(dBrand){
			case "DELL":
				bundle.visible = true;
				bundle.bundle.selectedIndex = 2;
				break;
			case "TOSHIBA":
				bundle.visible = true;
				bundle.bundle.selectedIndex = 2;
				break;
			case "ASUS":
				bundle.visible = true;
				bundle.bundle.selectedIndex = 2;
				break;
			default:
				bundle.visible = true;
				bundle.bundle.selectedIndex = 1;
				break;
		}
				
		software.software.dataProvider = new DataProvider(softwareSet1)
		software.visible = true;
		software.software.selectedIndex = 1;
		
	}
	
	fm.setFocus(price);
	edit_button.visible = false;
	dg.selectedIndices = null;
	}
	
}


function updateTag():void{
	sku_di.text = dSku;
	brand_di.text = dBrand;
	model_di.text = dModel;
	price.text = dPrice;
	bundle.visible = true;
	bundle.bundle.selectedIndex = 0;
}

function clearTag():void{
	sku_di.text = "";
	brand_di.text = "";
	model_di.text = "";
	price.text = "";
	sku.text = "";
	fm.setFocus(sku);
	status.gotoAndStop(1);
}

function addTag():void{
dp.addItem({SKU:sku_di.text, BRAND:brand_di.text, MODEL:model_di.text, PRICE:price.text, PACKAGE:bundle.bundle.selectedItem.label, SOFTWARE:software.software.selectedItem.label, OFFICE:office.text});

Counter++;
_Tag[Counter] = new TagTemplate();
switch(brand_di.text){
		case "ACER":
			tBundle = 2;
			break;
		case "ASUS":
			tBundle = 3;
			break;
		case "COMPAQ":
			tBundle = 4;
			break;
		case "DELL":
			tBundle = 5;
			break;
		case "EMACHINES":
			tBundle = 6;
			break;
		case "GATEWAY":
			tBundle = 7;
			break;
		case "HEWLETT PACKARD":
			tBundle = 8;
			break;
		case "SONY":
			tBundle = 9;
			break;
		case "TOSHIBA":
			tBundle = 10;
			break;
}
_Tag[Counter].logo.gotoAndStop(tBundle);
_Tag[Counter].model.text = model_di.text;
switch(Number(software.software.selectedItem.data)){
		case 1:
			tSoftware = 2;
			break;
		case 2:
			tSoftware = 3;
			break;
		case 3:
			tSoftware = 4;
			break;
		case 4:
			tSoftware = 5;
			break;
		case 5:
			tSoftware = 6;
			break;
		case 6:
			tSoftware = 7;
			break;
}
switch(Number(bundle.bundle.selectedItem.data)){
		case 1:
			//tPrice = 160;
			if ( Number(software.software.selectedItem.data) == 2 || Number(software.software.selectedItem.data) == 4){
				tPrice = 160;
			}
			if ( Number(software.software.selectedItem.data) == 1 || Number(software.software.selectedItem.data) == 3){
				tPrice = 180;
			}
			if ( Number(software.software.selectedItem.data) == 5 || Number(software.software.selectedItem.data) == 6){
				tPrice = 130;
			}
			_Tag[Counter].pack.text = "With Advanced Security Package";
			_Tag[Counter].restorecd.text = "We will also create recovery CD's";
			break;
		case 2:
			//tPrice = 130;
			if ( Number(software.software.selectedItem.data) == 2 || Number(software.software.selectedItem.data) == 4){
				tPrice = 130;
			}
			if ( Number(software.software.selectedItem.data) == 1 || Number(software.software.selectedItem.data) == 3){
				tPrice = 150;
			}
			if ( Number(software.software.selectedItem.data) == 5 || Number(software.software.selectedItem.data) == 6){
				tPrice = 90;
			}
			_Tag[Counter].pack.text = "With Standard Security Package";
			break;
		case 3:
			tPrice = 130;
			_Tag[Counter].pack.text = "With Advanced Security Package";
			_Tag[Counter].restorecd.text = "We will also create recovery CD's";
			break;
		case 4:
			tPrice = 90;
			_Tag[Counter].pack.text = "With Standard Security Package";
			break;
		case 5:
			tPrice = 60;
			tSoftware = 0;
			break;
		case 6:
			tPrice = 40;
			tSoftware = 0;
			break;
}
_Tag[Counter].softwares.gotoAndStop(tSoftware);
_Tag[Counter].totPrice.text = int(Number(price.text) + tPrice);
_Tag[Counter].offPrice.text = int(Number(price.text) + tPrice + Number(office.text) + 50);
_Tag[Counter].width = 396;
_Tag[Counter].height = 280;

if(Counter%2){
_Tag[Counter].x = 9.6;
}else{
_Tag[Counter].x = 406;
}
_Tag[Counter].y = (290* tRow);
//_Tag[Counter].y = 46.4 + (290* tRow);

if(Counter%2 == 0){
tRow++;
}



scrollb.contnt.addChild(_Tag[Counter]);





scrollb.sbUpdate()
clearTag()
software.visible = false;
software.software.selectedIndex = 0;
bundle.visible = false;
status.gotoAndStop(1);
}

/////////////////////////////////EDIT TAG////////////////////////////
function EditTag(id:Number):void{
//dp.addItem({SKU:sku_di.text, BRAND:brand_di.text, MODEL:model_di.text, PRICE:price.text, PACKAGE:bundle.bundle.selectedItem.label, SOFTWARE:software.software.selectedItem.label, OFFICE:office.text});
 
dp.getItemAt(id).SKU = sku_di.text;
dp.getItemAt(id).BRAND = brand_di.text;
dp.getItemAt(id).MODEL = model_di.text
dp.getItemAt(id).PRICE = price.text;
dp.getItemAt(id).PACKAGE = bundle.bundle.selectedItem.label;
dp.getItemAt(id).SOFTWARE = software.software.selectedItem.label;
dp.getItemAt(id).OFFICE = office.text;





switch(brand_di.text){
		case "ACER":
			tBundle = 2;
			break;
		case "ASUS":
			tBundle = 3;
			break;
		case "COMPAQ":
			tBundle = 4;
			break;
		case "DELL":
			tBundle = 5;
			break;
		case "EMACHINES":
			tBundle = 6;
			break;
		case "GATEWAY":
			tBundle = 7;
			break;
		case "HEWLETT PACKARD":
			tBundle = 8;
			break;
		case "SONY":
			tBundle = 9;
			break;
		case "TOSHIBA":
			tBundle = 10;
			break;
}
_Tag[id+1].logo.gotoAndStop(tBundle);
_Tag[id+1].model.text = model_di.text;
switch(Number(software.software.selectedItem.data)){
		case 1:
			tSoftware = 2;
			break;
		case 2:
			tSoftware = 3;
			break;
		case 3:
			tSoftware = 4;
			break;
		case 4:
			tSoftware = 5;
			break;
		case 5:
			tSoftware = 6;
			break;
		case 6:
			tSoftware = 7;
			break;
}
switch(Number(bundle.bundle.selectedItem.data)){
		case 1:
			//tPrice = 160;
			if ( Number(software.software.selectedItem.data) == 2 || Number(software.software.selectedItem.data) == 4){
				tPrice = 160;
			}
			if ( Number(software.software.selectedItem.data) == 1 || Number(software.software.selectedItem.data) == 3){
				tPrice = 180;
			}
			if ( Number(software.software.selectedItem.data) == 5 || Number(software.software.selectedItem.data) == 6){
				tPrice = 130;
			}
			_Tag[id+1].pack.text = "With Advanced Security Package";
			_Tag[id+1].restorecd.text = "We will also create recovery CD's";
			break;
		case 2:
			//tPrice = 130;
			if ( Number(software.software.selectedItem.data) == 2 || Number(software.software.selectedItem.data) == 4){
				tPrice = 130;
			}
			if ( Number(software.software.selectedItem.data) == 1 || Number(software.software.selectedItem.data) == 3){
				tPrice = 150;
			}
			if ( Number(software.software.selectedItem.data) == 5 || Number(software.software.selectedItem.data) == 6){
				tPrice = 90;
			}
			_Tag[id+1].pack.text = "With Standard Security Package";
			break;
		case 3:
			tPrice = 130;
			_Tag[id+1].pack.text = "With Advanced Security Package";
			_Tag[id+1].restorecd.text = "We will also create recovery CD's";
			break;
		case 4:
			tPrice = 90;
			_Tag[id+1].pack.text = "With Standard Security Package";
			break;
		case 5:
			tPrice = 60;
			tSoftware = 0;
			break;
		case 6:
			tPrice = 40;
			tSoftware = 0;
			break;
}
_Tag[id+1].softwares.gotoAndStop(tSoftware);
_Tag[id+1].totPrice.text = int(Number(price.text) + tPrice);
_Tag[id+1].offPrice.text = int(Number(price.text) + tPrice + Number(office.text) + 50);

_Tag[id+1].width = 396;
_Tag[id+1].height = 280;

if((id+1)%2){
_Tag[id+1].x = 9.6;
}else{
_Tag[id+1].x = 406;
}

if(id%2){
  _Tag[id+1].y = (290* ((id+1) - int((id+1)/2) - 1)); 
  trace("true");
}else{
	_Tag[id+1].y = (290* ((id+1) - int((id+1)/2) - 1));
	trace("false");
}


//_Tag[Counter].y = 46.4 + (290* tRow);



scrollb.contnt.addChild(_Tag[id+1]);







var ddg:DataGrid = new DataGrid();



clearTag()
software.visible = false;
software.software.selectedIndex = 0;
bundle.visible = false;
edit_button.visible = false;
dg.selectedIndices = null;
}


function checkSkuValue():Boolean{
	if(sku.text.length != 7 || isNaN(Number(sku.text))){
		obj = sku;
		status.gotoAndStop(4);
		//alertbox("Please make sure to enter a correct sku before attempting to load.");
		return false;
		trace("sku false");
	}
	
       trace("sku true");
	return true;
}


function Prints():void{
	var ps:PrintSheet = new PrintSheet();
	var cnt:Number = dp.length;
	var i:Number = 0;
	var _pageCnt:Number = 1;
	var dag = ps.init();
	_Sheet[tCountSheet] = new MovieClip();
	for (i = 0; i < cnt; i++)
	{
 
		_PrintTag[i] = new TagTemplate();

switch(dp.getItemAt(i).BRAND){
		case "ACER":
			tBundle = 2;
			break;
		case "ASUS":
			tBundle = 3;
			break;
		case "COMPAQ":
			tBundle = 4;
			break;
		case "DELL":
			tBundle = 5;
			break;
		case "EMACHINES":
			tBundle = 6;
			break;
		case "GATEWAY":
			tBundle = 7;
			break;
		case "HEWLETT PACKARD":
			tBundle = 8;
			break;
		case "SONY":
			tBundle = 9;
			break;
		case "TOSHIBA":
			tBundle = 10;
			break;
}
_PrintTag[i].logo.gotoAndStop(tBundle);
_PrintTag[i].model.text = dp.getItemAt(i).MODEL;
switch(dp.getItemAt(i).SOFTWARE){
		case "Trend Micro AV & Spy Sweeper":
			tSoftware = 1;
			break;
		case "Trend Micro IS":
			tSoftware = 2;
			break;
		case "Kaspersky IS":
			tSoftware = 3;
			break;
		case "Spy Sweeper with Anti-Virus":
			tSoftware = 4;
			break;
		case "Trend Micro IS Included":
			tSoftware = 5;
			break;
		case "Norton Included":
			tSoftware = 6;
			break;
}
switch(dp.getItemAt(i).PACKAGE){
		case "Adv Security & Performance":
			//tPrice = 160;
			if ( tSoftware == 2 || tSoftware == 4){
				tPrice = 160;
			}
			if ( tSoftware == 1 || tSoftware == 3){
				tPrice = 180;
			}
			//if ( tSoftware == 5 || tSoftware == 6){
				//tPrice = 130;
			//}
			_PrintTag[i].pack.text = "With Advanced Security Package";
			_PrintTag[i].restorecd.text = "We will also create recovery CD's";
			break;
		case "Std Security & Performance":
			//tPrice = 130;
			if ( tSoftware == 2 || tSoftware == 4){
				tPrice = 130;
			}
			if ( tSoftware == 1 || tSoftware == 3){
				tPrice = 150;
			}
			//if ( tSoftware == 5 || tSoftware == 6){
				//tPrice = 90;
			//}
			_PrintTag[i].pack.text = "With Standard Security Package";
			break;
		case "Adv Security Pre-Bundled AV":
			tPrice = 130;
			_PrintTag[i].pack.text = "With Advanced Security Package";
			_PrintTag[i].restorecd.text = "We will also create recovery CD's";
			break;
		case "Std Security Pre-Bundled AV":
			_PrintTag[i].pack.text = "With Standard Security Package";
			tPrice = 90;
			break;
		case "Optimization & Restore":
			tPrice = 60;
			tSoftware = 0;
			break;
		case "Optimization":
			tPrice = 40;
			tSoftware = 0;
			break;
}
_PrintTag[i].softwares.gotoAndStop(tSoftware+1);
_PrintTag[i].totPrice.text = int(Number(dp.getItemAt(i).PRICE) + tPrice);
_PrintTag[i].offPrice.text = int(Number(dp.getItemAt(i).PRICE) + tPrice + Number(dp.getItemAt(i).OFFICE) + 50);

_PrintTag[i].width = 396;
_PrintTag[i].height = 296;

if(i%2){
_PrintTag[i].x = 389;
	trace("x = 2");
//_PrintTag[i].x = 53;
}else{
_PrintTag[i].x = 0;
	trace("x = 1");
}



if(tRow2 == 1||tRow2 == 2){
	_PrintTag[i].y = 00;
	trace("y = 1 or 2");
	
}else if(tRow2 == 3 || tRow2 == 4){
	_PrintTag[i].y = 286;
	//_PrintTag[i].y = 39;
	trace("y = 3 or 4");
}
tRow2++;


if(tRow2 == 5){
	tRow2 = 1;
}

trace("PrintTag " + (i+1), _PrintTag[i].x, _PrintTag[i].y);


_Sheet[tCountSheet].addChild(_PrintTag[i]);

/*if( i<= 3){
	paper.addChild(_PrintTag[i]);
}else{
	paper2.addChild(_PrintTag[i]);
}*/
trace();
trace(_pageCnt, _pageCnt%4);

if(_pageCnt%4 == 0){
	_Sheet[tCountSheet].rotation = 90
	ps.addSheet(_Sheet[tCountSheet]);
	tCountSheet++;
	_Sheet[tCountSheet] = new MovieClip();
}else{
	
	//tCountSheet++;
	
}
	_pageCnt += 1;
	}
	if((_pageCnt-1)%4 != 0){
	_Sheet[tCountSheet].rotation = 90
	ps.addSheet(_Sheet[tCountSheet]);
	}
	ps.printSheet();

}

function addCheck():Boolean{
	
	if(office.text == "" || isNaN(Number(office.text))){
		obj = office;
		alertbox("Please make sure to enter a correct price for office.");
		return false;
	}else if(sku.text.length != 7 || isNaN(Number(sku.text))){
		obj = sku;
		alertbox("Please make sure to enter a correct sku before attempting to Add.");
		return false;
	}else if(price.text == "" || isNaN(Number(price.text))){
		obj = price;
		alertbox("Please make sure to enter a price.");
		return false;
	}else if(Number(bundle.bundle.selectedItem.data) == 0){
		obj = bundle.bundle;
		alertbox("Please make sure to select a package.");
		return false;
	}else if(Number(software.software.selectedItem.data) == 0){
		obj = software.software;
		alertbox("Please make sure to select a software.");
		return false;
	}
	return true;
}

function editCheck():Boolean{
	
	if(office.text == "" || isNaN(Number(office.text))){
		obj = office;
		alertbox("Please make sure to enter a correct price for office.");
		return false;
	}else if(price.text == "" || isNaN(Number(price.text))){
		obj = price;
		alertbox("Please make sure to enter a price.");
		return false;
	}else if(Number(bundle.bundle.selectedItem.data) == 0){
		obj = bundle.bundle;
		alertbox("Please make sure to select a package.");
		return false;
	}else if(Number(software.software.selectedItem.data) == 0){
		obj = software.software;
		alertbox("Please make sure to select a software.");
		return false;
	}
	return true;
}


function ok_buttonClick(e:MouseEvent) {

disable_mc.visible = false;
popup.visible = false;

sku.enabled = true;
price.enabled = true;
office.enabled = true;
bundle.bundle.enabled = true;
software.software.enabled = true;

add_button.enabled = true;
edit_button.enabled = true;
print_button.enabled = true;

fm2.deactivate();
fm.activate();
fm.setFocus(obj);

obj = null;
																				   
}


function alertbox(txt:String):void {
fm.deactivate();
fm2.activate();
popup.msg.text = txt;
disable_mc.visible = true;
popup.visible = true;

sku.enabled = false;
office.enabled = false;
price.enabled = false;
bundle.bundle.enabled = false;
software.software.enabled = false;

add_button.enabled = false;
edit_button.enabled = false;
print_button.enabled = false;

//fm.setFocus(popup.ok_button);
fm2.defaultButton  = popup.ok_button;
fm2.defaultButtonEnabled = true;
}

function loaderComplete (e:Event):void{

URLcontent = e.target.data;
	if ( 0 < URLcontent.indexOf("1 - 1")){
		
		dollarSign = URLcontent.indexOf("$", URLcontent.indexOf("price sale"));
		decimalPoint = URLcontent.indexOf(".",dollarSign);
			trace(dollarSign, decimalPoint);
		difference = decimalPoint - dollarSign;
		unitPrice = URLcontent.substr(dollarSign + 1, difference + 2);
		if ( 0 < unitPrice.indexOf(",")){
			unitPrice = unitPrice.substring(0,unitPrice.indexOf(",")) + unitPrice.substring(unitPrice.indexOf(",")+1)
		}
		onlinePrice.text = unitPrice;
		
		if(price.text == unitPrice){
			replace_button.visible = false;
			onlineStatus.gotoAndStop(2);
		}else{
			replace_button.visible = true;
			onlineStatus.gotoAndStop(3);
		}
		if( 0 < URLcontent.indexOf("</a>Outlet Center</a>")){
			replace_button.visible = false;
			onlineStatus.gotoAndStop(5);
		}
		
		browser_button.visible = true;
	}else{
		onlineStatus.gotoAndStop(4);
		replace_button.visible = false;
		browser_button.visible = true;
	}

}

function ioErrorHandler(event) {
            trace("ioErrorHandler: " + event);
			onlineStatus.gotoAndStop(6);
        }