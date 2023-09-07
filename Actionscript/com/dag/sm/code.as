import dag.Printing
import dag.Writing
import flash.net.*
import flash.filesystem.*;
import fl.managers.FocusManager;
import flash.events.*;
import dag.FlashUpdater
import fl.controls.RadioButtonGroup;

import air.update.ApplicationUpdater;
var appUpdater:ApplicationUpdater = new ApplicationUpdater(); 

var tmpBTP:Number;
var packPrice:Number = 0;
var softPrice:Number = 0;
var officePrice:String = "";
var totalPrice:String = "";
var lineNum:Number = 1;
var lineLists:Array = new Array();
var lineListsSp:Array = new Array();

var tagLang = 1;
var ddrT = 1;
var hdT:String = "GB";

var softSub:Number = 1;
var term:String = "1YR.";
var termS:String = "1AÑO.";


software.moRb.visible = false
software.oneyrRb.visible = false
software.twoyrRb.visible = false
software.threeyrRb.visible = false

var obj:InteractiveObject;
var newClick = new MouseEvent(MouseEvent.CLICK);
var fm:FocusManager = new FocusManager(this);
var fm2:FocusManager = new FocusManager(this);

var loadXml:XML;
var xmlSku:XML;
var loader:URLLoader = new URLLoader();
var loader2:URLLoader = new URLLoader();

var loader3:URLLoader = new URLLoader();

loader3.addEventListener(IOErrorEvent.IO_ERROR, onIOError3, false, 0, true);
loader3.load( new URLRequest(File.documentsDirectory.resolvePath("xml/skulist.xml").url));

sku.addEventListener(Event.CHANGE, changeHandlerS);
//brand.addEventListener(Event.CHANGE, changeTHandler);
cbBrand.addEventListener(Event.CHANGE,changeBrand)
model.addEventListener(Event.CHANGE, changeTHandler);
price.addEventListener(Event.CHANGE, changeTHandler);
office.office.addEventListener(Event.CHANGE, changeTHandler);
titleT.addEventListener(Event.CHANGE, changeTHandler);
ram.addEventListener(Event.CHANGE, changeTHandler);
hd.addEventListener(Event.CHANGE, changeTHandler);

sku.addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
cbBrand.addEventListener(FocusEvent.FOCUS_IN, focusIn2Handler);
model.addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
price.addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
office.office.addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
titleT.addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
ram.addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
hd.addEventListener(FocusEvent.FOCUS_IN, focusInHandler);

sku.tabIndex = 1;
//load_button.tabIndex = 2;
cbBrand.tabIndex = 2;
model.tabIndex = 3;
price.tabIndex = 4;
titleT.tabIndex = 5;
ram.tabIndex = 6;
ddrtype.tabIndex = 7;
hd.tabIndex = 8;
hdtype.tabIndex = 9;
var test:TextInput = new TextInput();
var testb:Button = new Button();

sku.restrict = "0-9";
//brand.restrict = "A-Za-z ";
model.restrict = "A-Za-z\\-0-9"
price.restrict = ".0-9"
titleT.restrict = "A-Za-z\\-0-9\" "
ram.restrict = "0-9";
hd.restrict = ".0-9";

office.office.restrict = ".0-9"


bundle.tabIndex = 10;
software.software.tabIndex = 11;
office.office.tabIndex = 12;


software.moRb.tabIndex = 13;
software.oneyrRb.tabIndex = 14;
software.twoyrRb.tabIndex = 15;
software.threeyrRb.tabIndex = 16;

save_button.tabIndex = 17;
clear_button.tabIndex = 18;
print_button.tabIndex = 19;


fm.setFocus(sku);
fm2.deactivate();

var rbg:RadioButtonGroup = new RadioButtonGroup("subs");
//software.moRb.group = rbg;
//software.oneyrRb.group = rbg;
//software.twoyrRb.group = rbg;
//software.threeyrRb.group = rbg;

//rbg.addEventListener(Event.CHANGE, changeSub);
software.moRb.addEventListener(Event.CHANGE, changeSub);
//oftware.oneyrRb.addEventListener(Event.CHANGE, changeSub);
//software.twoyrRb.addEventListener(Event.CHANGE, changeSub);
//software.threeyrRb.addEventListener(Event.CHANGE, changeSub);

lang.addEventListener(Event.CHANGE, changeLanguage);
ddrtype.addEventListener(Event.CHANGE, changeDdr);
hdtype.addEventListener(Event.CHANGE, changeHd);
bundle.addEventListener(Event.CHANGE, changeHandler);
software.software.addEventListener(Event.CHANGE, changeSHandler);

print_button.addEventListener(MouseEvent.CLICK, print_buttonClick);
clear_button.addEventListener(MouseEvent.CLICK, clear_buttonClick);
save_button.addEventListener(MouseEvent.CLICK, save_buttonClick);
//load_button.addEventListener(MouseEvent.CLICK, load_buttonClick);
popup.ok_button.addEventListener(MouseEvent.CLICK, ok_buttonClick);
stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUpPress);

fm.defaultButtonEnabled = true;
fm.defaultButton  = popup.ok_button;

var checkUpdate:FlashUpdater = new FlashUpdater("http://www.d4g.us/bby/update/update_psd.xml");

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
updateTagText();
}

replace_button.visible = false;
browser_button.visible = false;

my_loader.addEventListener(Event.COMPLETE, loaderComplete);
my_loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);


function onKeyUpPress(e:KeyboardEvent):void {
      trace(e);
	  if(e.ctrlKey){
		switch(e.keyCode){
			//case 76:
			//load_buttonClick(newClick);
			//break;
			case 83:
			save_buttonClick(newClick);
			break;
			case 80:
			print_buttonClick(newClick);
			break;
			case 67:
			clear_buttonClick(newClick);
			break;
		}
	  }
}


//var prints:Printing = new Printing();

disable_mc.visible = false;
popup.visible = false;

software.visible = false;
office.visible = false;
tag.bundle.totprice2.visible = false;
tag.bundle.totprice.visible = false;
tag.bundle.totcents.visible = false;

tag.c1.visible = false;
tag.c2.visible = false;
tag.c3.visible = false;
tag.c4.visible = false;
tag.c5.visible = false;

tag.c1s.visible = false;
tag.c2s.visible = false;
tag.c3s.visible = false;
tag.c4s.visible = false;
tag.c5s.visible = false;
tag.btpe.visible = false;
tag.btps.visible = false;
tag.hds.visible = false;
tag.rams.visible = false;
tag.ddrs.visible = false;
tag.english.visible = false;
tag.spanish.visible = false;
tag.bundle.software.sprice.visible = false;

	tag.ddr.text = "DDR2";
var cb:ComboBox = new ComboBox();
function changeBrand(e:Event):void {
	
	
	switch(Number(ComboBox(e.target).selectedItem.data)){
		case 0:
			
			break;
		default:
			updateTagText()
			break;

	}
	
}

function changeSub(e:Event):void {
	
	trace(Number(e.currentTarget.value));
	switch(Number(e.currentTarget.value)){
		case 0:
			softSub = 0;
			term = "1MO.";
			termS = "1MES.";
			break;
		case 1:
			softSub = 1;
			term = "1YR.";
			termS = "1AÑO.";
			break;
		case 2:
			softSub = 2;
			term = "2YR.";
			termS = "2AÑO.";
			break;
		case 3:
			softSub = 3;
			term = "3YR.";
			termS = "3AÑO.";
			break;
	}

	updateTag()
	updateTagText();
	
}

function changeDdr(e:Event):void {
	
	
	switch(Number(ComboBox(e.target).selectedItem.data)){
		case 0:
			ddrT = 1;
			break;
		case 1:
			ddrT = 2;
			break;

	}
	updateTagText()
}

function changeHd(e:Event):void {
	
	
	switch(Number(ComboBox(e.target).selectedItem.data)){
		case 0:
			hdT = "GB";
			break;
		case 1:
			hdT = "TB";
			break;

	}
	updateTagText()
}

function changeLanguage(e:Event):void {
	
	
	switch(Number(ComboBox(e.target).selectedItem.data)){
		case 0:
			tag.gotoAndStop(1);
			tagLang = 1;
			lineListsSp = new Array();
			tag.c1s.visible = false;
			tag.c2s.visible = false;
			tag.c3s.visible = false;
			tag.c4s.visible = false;
			tag.c5s.visible = false;
			tag.line1s.visible = false;
			tag.line2s.visible = false;
			tag.line3s.visible = false;
			tag.line4s.visible = false;
			tag.line5s.visible = false;
			tag.btp.visible = true;
			tag.btpe.visible = false;
			tag.btps.visible = false;
			tag.hd.visible = true;
			tag.hds.visible = false;
			tag.hde.visible = false;
			tag.rams.visible = false;
			tag.ddrs.visible = false;
			tag.english.visible = false;
			tag.spanish.visible = false;
			updateTagText()
			updateTag()
			break;
		case 1:
			tag.gotoAndStop(2);
			tagLang = 2;
			tag.line1s.visible = true;
			tag.line2s.visible = true;
			tag.line3s.visible = true;
			tag.line4s.visible = true;
			tag.line5s.visible = true;
			tag.btp.visible = false;
			tag.btpe.visible = true;
			tag.btps.visible = true;
			tag.hd.visible = false;
			tag.hds.visible = true;
			tag.hde.visible = true;
			tag.rams.visible = true;
			tag.ddrs.visible = true;
			tag.english.visible = true;
			tag.spanish.visible = true;
			updateTagText()
			updateTag()
			break;

	}
}

function focusInHandler(e:FocusEvent):void {
	//if(obj == cbBrand){
	//}else{
      e.currentTarget.setSelection(e.currentTarget.length, e.currentTarget.length);
	//}
}

function focusIn2Handler(e:FocusEvent):void {
	
}

function changeTHandler(e:Event):void {
	
	updateTagText();
}
function changeHandlerS(e:Event):void {
	if(sku.text != ""){
	load_buttonClick(MouseEvent(newClick));
	}else{
    status.gotoAndStop(1);
	}
	tag.sku.text = sku.text;
}
function changeHandler(e:Event):void {
       
       tag.bundle.gotoAndStop(Number(ComboBox(e.target).selectedItem.data) + 1);
	
	tag.bundle.officeprice1.text = "";
	tag.bundle.officeprice2.text = "";
	tag.bundle.officeprice3.text = "";
	
	switch(Number(ComboBox(e.target).selectedItem.data)){
		case 0:
			packPrice = 0;
			officePrice = "";
			software.visible = false;
			office.visible = false;
			software.software.selectedIndex = 0;
			tag.bundle.software.gotoAndStop(1);
			tag.bundle.software.sprice.visible = false;
			//tag.bundle.totprice2.visible = false;
			//tag.bundle.totprice.visible = false;
			//tag.bundle.totcents.visible = false;
			break;
		case 1:
			software.visible = true;
			tag.bundle.software.sprice.visible = true;
			//packPrice = 160;
			office.visible = false;
			office.office.text = "";
			officePrice = "";
			packPrice = 120;
			tag.english.text = "Advanced Security & Performance Package";
			tag.spanish.text = "Paquete de seguridad avanzado con funcionamiento";
			//tag.bundle.totprice2.visible = true;
			//tag.bundle.totprice.visible = true;
			//tag.bundle.totcents.visible = true;
			break;
		case 2:
			software.visible = true;
			tag.bundle.software.sprice.visible = true;
			//packPrice = 130;
			office.visible = false;
			office.office.text = "";
			officePrice = "";
			packPrice = 89.98;
			tag.english.text = "Standard Security & Performance Package";
			tag.spanish.text = "Paquete de seguridad con funcionamiento";
			//tag.bundle.totprice2.visible = true;
			//tag.bundle.totprice.visible = true;
			//tag.bundle.totcents.visible = true;
			break;
		case 3:
			software.visible = true;
			tag.bundle.software.sprice.visible = true;
			//packPrice = 180;
			office.visible = true;
			packPrice = 89.98 + 49.99;
			tag.english.text = "Standard Security with Office Package";
			tag.spanish.text = "Paquete de seguridad mas Office";
			//tag.bundle.totprice2.visible = true;
			//tag.bundle.totprice.visible = true;
			//tag.bundle.totcents.visible = true;
			tag.bundle.officeprice1.text = "$" + officePrice;
			tag.bundle.officeprice2.text = "";
			tag.bundle.officeprice3.text = "";
			break;
		case 4:
			software.visible = true;
			tag.bundle.software.sprice.visible = true;
			//packPrice = 210;
			office.visible = true;
			packPrice = 120 + 49.99;
			tag.english.text = "Essentials Package";
			tag.spanish.text = "Paquete de programación esencial";
			//tag.bundle.totprice2.visible = true;
			//tag.bundle.totprice.visible = true;
			//tag.bundle.totcents.visible = true;
			tag.bundle.officeprice1.text = "";
			tag.bundle.officeprice2.text = "$" + officePrice;
			tag.bundle.officeprice3.text = "";
			break;
		case 5:
			software.visible = false;
			software.software.selectedIndex = 0;
			tag.bundle.software.gotoAndStop(1);
			tag.bundle.software.sprice.visible = false;
			packPrice = 59.99 + 49.99;
			office.visible = true;
			tag.english.text = "Blue Label Essentials Package";
			tag.spanish.text = "Paquete de programación esencial para Blue Label";
			//tag.bundle.totprice2.visible = true;
			//tag.bundle.totprice.visible = true;
			//tag.bundle.totcents.visible = true;
			tag.bundle.officeprice1.text = "";
			tag.bundle.officeprice2.text = "";
			tag.bundle.officeprice3.text = "$" + officePrice;
			break;
		case 6:
			software.visible = false;
			software.software.selectedIndex = 0;
			tag.bundle.software.gotoAndStop(1);
			tag.bundle.software.sprice.visible = false;
			packPrice = 59.99;
			office.visible = false;
			office.office.text = "";
			officePrice = "";
			tag.english.text = "Optimization & Restore CD's";
			tag.spanish.text = "Optimización y discos de restauración";
			//tag.bundle.totprice2.visible = true;
			//tag.bundle.totprice.visible = true;
			//tag.bundle.totcents.visible = true;
			break;
		case 7:
			software.visible = true;
			tag.bundle.software.sprice.visible = true;
			packPrice = 240;
			office.visible = false;
			office.office.text = "";
			officePrice = "";
			tag.english.text = "Connect and Protect Package";
			tag.spanish.text = "Conectar y protejer";
			//tag.bundle.totprice2.visible = true;
			//tag.bundle.totprice.visible = true;
			//tag.bundle.totcents.visible = true;
			break;
		case 8:
			software.visible = false;
			software.software.selectedIndex = 0;
			tag.bundle.software.gotoAndStop(1);
			tag.bundle.software.sprice.visible = false;
			packPrice = 39.99;
			office.visible = false;
			office.office.text = "";
			officePrice = "";
			tag.english.text = "Optimization";
			tag.spanish.text = "Optimización";
			//tag.bundle.totprice2.visible = true;
			//tag.bundle.totprice.visible = true;
			//tag.bundle.totcents.visible = true;
			break;
	}
	updateSub();
			totalPrice = String(int((Number(price.text) + packPrice + Number(officePrice) + softPrice)*100)/100);
			
		if(totalPrice.length <= 6){
		   if(totalPrice.indexOf(".") > -1){
			   	tag.price2.text = "";
				tag.price.text = totalPrice.substr(0,totalPrice.indexOf("."));
				tag.cents.text = totalPrice.substring(totalPrice.indexOf(".") + 1,totalPrice.length);
		   }else if(totalPrice != ""){
			    tag.price2.text = "";
				tag.price.text = totalPrice;
				tag.cents.text = "00";
		   }else{
		   		tag.price2.text = "";
				tag.price.text = "";
				tag.cents.text = "";
		   }
		}else if(totalPrice.length > 6){
				tag.price.text = "";
				tag.price2.text = totalPrice.substr(0,totalPrice.indexOf("."));
				tag.cents.text = totalPrice.substring(totalPrice.indexOf(".") + 1,totalPrice.length);
		}
		updateTag();
}

function changeSHandler(e:Event):void {
       
       tag.bundle.software.gotoAndStop(Number(ComboBox(e.target).selectedItem.data) + 1);


		switch(Number(ComboBox(e.target).selectedItem.data)){
		case 0:
			tag.bundle.software.gotoAndStop(1);
			tag.bundle.software.sprice.visible = false;
			tag.bundle.software.sprice.text = "";
			//tag.bundle.totprice2.visible = false;
			//tag.bundle.totprice.visible = false;
			//tag.bundle.totcents.visible = false;
			software.moRb.visible = false
			software.oneyrRb.visible = false
			software.twoyrRb.visible = false
			software.threeyrRb.visible = false
			break;
		case 1:
			
			tag.bundle.software.sprice.visible = true;
			//tag.bundle.totprice2.visible = true;
			//tag.bundle.totprice.visible = true;
			//tag.bundle.totcents.visible = true;
			software.moRb.visible = true
			software.oneyrRb.visible = true
			software.twoyrRb.visible = true
			software.threeyrRb.visible = true
			break;
		case 2:
			
			tag.bundle.software.sprice.visible = true;
			//tag.bundle.totprice2.visible = true;
			//tag.bundle.totprice.visible = true;
			//tag.bundle.totcents.visible = true;
			software.moRb.visible = true
			software.oneyrRb.visible = true
			software.twoyrRb.visible = true
			software.threeyrRb.visible = true
			break;
		case 3:
			
			tag.bundle.software.sprice.visible = true;
			//tag.bundle.totprice2.visible = true;
			//tag.bundle.totprice.visible = true;
			//tag.bundle.totcents.visible = true;
			software.moRb.visible = true
			software.oneyrRb.visible = true
			software.twoyrRb.visible = true
			software.threeyrRb.visible = true
			break;
		case 4:
			tag.bundle.software.sprice.visible = true;
			//tag.bundle.totprice2.visible = true;
			//tag.bundle.totprice.visible = true;
			//tag.bundle.totcents.visible = true;
			software.moRb.visible = true
			software.oneyrRb.visible = true
			software.twoyrRb.visible = true
			software.threeyrRb.visible = true
			break;
		case 5:
			tag.bundle.software.sprice.visible = false;
			tag.bundle.software.sprice.text = "";
			//tag.bundle.totprice2.visible = true;
			//tag.bundle.totprice.visible = true;
			//tag.bundle.totcents.visible = true;
			software.moRb.visible = false
			software.oneyrRb.visible = false
			software.twoyrRb.visible = false
			software.threeyrRb.visible = false
			break;
		case 6:
			
			tag.bundle.software.sprice.visible = false;
			tag.bundle.software.sprice.text = "";
			//tag.bundle.totprice2.visible = true;
			//tag.bundle.totprice.visible = true;
			//tag.bundle.totcents.visible = true;
			software.moRb.visible = false
			software.oneyrRb.visible = false
			software.twoyrRb.visible = false
			software.threeyrRb.visible = false
			break;
		case 7:
			
			tag.bundle.software.sprice.visible = true;
			//tag.bundle.totprice2.visible = true;
			//tag.bundle.totprice.visible = true;
			//tag.bundle.totcents.visible = true;
			software.moRb.visible = true
			software.oneyrRb.visible = true
			software.twoyrRb.visible = true
			software.threeyrRb.visible = true
			break;
		case 8:
			
			tag.bundle.software.sprice.visible = true;
			//tag.bundle.totprice2.visible = true;
			//tag.bundle.totprice.visible = true;
			//tag.bundle.totcents.visible = true;
			software.moRb.visible = false
			software.oneyrRb.visible = false
			software.twoyrRb.visible = false
			software.threeyrRb.visible = false
			break
	}
	updateSub();
			totalPrice = String(int((Number(price.text) + packPrice + Number(officePrice) + softPrice)*100)/100);
			
		if(totalPrice.length <= 6){
		   if(totalPrice.indexOf(".") > -1){
			   	tag.price2.text = "";
				tag.price.text = totalPrice.substr(0,totalPrice.indexOf("."));
				tag.cents.text = totalPrice.substring(totalPrice.indexOf(".") + 1,totalPrice.length);
		   }else if(totalPrice != ""){
			    tag.price2.text = "";
				tag.price.text = totalPrice;
				tag.cents.text = "00";
		   }else{
		   		tag.price2.text = "";
				tag.price.text = "";
				tag.cents.text = "";
		   }
		}else if(totalPrice.length > 6){
				tag.price.text = "";
				tag.price2.text = totalPrice.substr(0,totalPrice.indexOf("."));
				tag.cents.text = totalPrice.substring(totalPrice.indexOf(".") + 1,totalPrice.length);
		}
	
	   updateTag();
}
//////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////Subcription Pricing//////////////////////////
//////////////////////////////////////////////////////////////////////////////////

function updateSub():void {
	
	
	
	switch(Number(software.software.selectedItem.data)){
		case 0:
			softPrice = 0;
			break;
		
		case 1:
			//lineList.push("1YR. TREND MICRO AV");
			//lineList.push("1YR. SPY SWEEPER");
			break;
		case 2:
		//Trend IS
			switch(softSub){
				case 0:
					softPrice = 4.19;
					break;
				case 1:
					softPrice = 49.99;
					break;
				case 2:
					softPrice = 88.99;
					break;
				case 3:
					softPrice = 124.99;
					break;
			}
			break;
		case 3:
		//Kaspersky IS
			switch(softSub){
				case 0:
					softPrice = 5.79;
					break;
				case 1:
					softPrice = 69.99;
					break;
				case 2:
					softPrice = 124.99;
					break;
				case 3:
					softPrice = 174.99;
					break;
			}
			break;
		case 4:
		//Webroot AV & AS
			switch(softSub){
				case 0:
					softPrice = 3.39;
					break;
				case 1:
					softPrice = 39.99;
					break;
				case 2:
					softPrice = 69.99;
					break;
				case 3:
					softPrice = 99.99;
					break;
			}
			break;
		case 5:
			////Preloaded///
			softPrice = 0;
			break;
		case 6:
			////Preloaded////
			softPrice = 0;
			break;
		case 7:
		//Kaspersky AV & AS
			switch(softSub){
				case 0:
					softPrice = 4.19;
					break;
				case 1:
					softPrice = 49.99;
					break;
				case 2:
					softPrice = 104.99;
					break;
				case 3:
					softPrice = 149.99;
					break;
			}
			break;
		case 8:
			////Trend AV & AS////
			softPrice = 39.99;
			break;
	}
	if (softPrice > 0 ){
		tag.bundle.software.sprice.text = "$" + String(softPrice);
	} else{
		tag.bundle.software.sprice.text = "";
	}
	   trace(softPrice);
}

function updateTag():void {
	var lineList:Array = new Array();
	var lineListSp:Array = new Array();
	
	switch(Number(software.software.selectedItem.data)){
		case 1:
			lineList.push("1YR. TREND MICRO AV");
			lineList.push("1YR. SPY SWEEPER");
			break;
		case 2:
			lineList.push(term + " TREND MICRO IS");
			break;
		case 3:
			lineList.push(term + " KASPERSKY IS");
			break;
		case 4:
			lineList.push(term + " SPY SWEEPER WITH AV");
			break;
		case 5:
			lineList.push("1YR. TREND MICRO IS");
			break;
		case 6:
			lineList.push("1YR. NORTON IS");
			break;
		case 7:
			lineList.push(term + " KASPERSKY AV & AS");
			break;
		case 8:
			lineList.push("1YR. TREND MICRO AV & AS");
			break;
	}
	switch(Number(bundle.selectedItem.data)){
		case 1:
			lineList.push("COMPUTER OPTIMIZATION");
			lineList.push("SYSTEM RESTORE CD'S");
			break;
		case 2:
			lineList.push("COMPUTER OPTIMIZATION");
			break;
		case 3:
			lineList.push("COMPUTER OPTIMIZATION");
			lineList.push("OFFICE HOME & STUD 2007");
			break;
		case 4:
			lineList.push("COMPUTER OPTIMIZATION");
			lineList.push("SYSTEM RESTORE CD'S");
			lineList.push("OFFICE HOME & STUD 2007");
			break;
		case 5:
			lineList.push("COMPUTER OPTIMIZATION");
			lineList.push("SYSTEM RESTORE CD'S");
			lineList.push("OFFICE HOME & STUD 2007");
			break;
		case 6:
			lineList.push("COMPUTER OPTIMIZATION");
			lineList.push("SYSTEM RESTORE CD'S");
			break;
		case 7:
			lineList.push("INHOME ROUTER SETUP");
			lineList.push("INHOME NETWORK SECURITY");
			lineList.push("INHOME NEW PC SETUP");
			lineList.push("COMPUTER OPTIMIZATION");
			break;
		case 8:
			lineList.push("COMPUTER OPTIMIZATION");
			break;
	}
	if(tagLang == 2){
		
		switch(Number(software.software.selectedItem.data)){
		case 1:
			lineListSp.push("1YR. TREND MICRO AV");
			lineListSp.push("1YR. SPY SWEEPER");
			break;
		case 2:
			lineListSp.push(termS + " TREND MICRO IS");
			break;
		case 3:
			lineListSp.push(termS + " KASPERSKY IS");
			break;
		case 4:
			lineListSp.push(termS + " SPY SWEEPER WITH AV");
			break;
		case 5:
			lineListSp.push("1AÑO. TREND MICRO IS");
			break;
		case 6:
			lineListSp.push("1AÑO. NORTON IS");
			break;
		case 7:
			lineListSp.push(termS + " KASPERSKY AV & AS");
			break;
		case 8:
			lineListSp.push("1AÑO. TREND MICRO AV & AS");
			break;
	}
	
      switch(Number(bundle.selectedItem.data)){
		case 1:
			lineListSp.push("OPTIMIZACIÓN DE COMPUTADORA");
			lineListSp.push("DISCOS DE RESTAURACIÓN");
			break;
		case 2:
			lineListSp.push("OPTIMIZACIÓN DE COMPUTADORA");
			break;
		case 3:
			lineListSp.push("OPTIMIZACIÓN DE COMPUTADORA");
			lineListSp.push("OFFICE HOME & STUD 2007");
			break;
		case 4:
			lineListSp.push("OPTIMIZACIÓN DE COMPUTADORA");
			lineListSp.push("DISCOS DE RESTAURACIÓN");
			lineListSp.push("OFFICE CASA Y ESTUDIANTES 2007");
			break;
		case 5:
			lineListSp.push("OPTIMIZACIÓN DE COMPUTADORA");
			lineListSp.push("DISCOS DE RESTAURACIÓN");
			lineListSp.push("OFFICE CASA Y ESTUDIANTES 2007");
			break;
		case 6:
			lineListSp.push("OPTIMIZACIÓN DE COMPUTADORA");
			lineListSp.push("DISCOS DE RESTAURACIÓN");
			break;
		case 7:
			lineListSp.push("CONFIGURACIÓN DE ENRUTADOR EN CASA ");
			lineListSp.push("SEGURIDAD DE RED EN CASA");
			lineListSp.push("CONFIGURACIÓN DE COMPUTADORA EN CASA");
			lineListSp.push("OPTIMIZACIÓN DE COMPUTADORA");
			break;
		case 8:
			lineListSp.push("OPTIMIZACIÓN DE COMPUTADORA");
			break;
	}
	  lineListsSp = lineListSp;
	   writeLine2();
	}
	   lineLists = lineList;
	   writeLine();

updateSub()   
	   
}


function writeLine():void {
	trace(lineLists[4] != null);
	if( lineLists[0] != null){
	tag.line1.text = lineLists[0];
	tag.c1.visible = true;
	}else{
	tag.line1.text = "";
	tag.c1.visible = false;
	}
	if( lineLists[1] != null){
	tag.line2.text = lineLists[1];
	tag.c2.visible = true;
	}else{
	tag.line2.text = "";
	tag.c2.visible = false;
	}
	if( lineLists[2] != null){
	tag.line3.text = lineLists[2];
	tag.c3.visible = true;
	}else{
	tag.line3.text = "";
	tag.c3.visible = false;
	}
	if( lineLists[3] != null){
	tag.line4.text = lineLists[3];
	tag.c4.visible = true;
	}else{
	tag.line4.text = "";
	tag.c4.visible = false;
	}
	if( lineLists[4] != null){
	tag.line5.text = lineLists[4];
	tag.c5.visible = true;
	}else{
	tag.line5.text = "";
	tag.c5.visible = false;
	}
       
}

function writeLine2():void {
	if( lineListsSp[0] != null){
	tag.line1s.text = lineListsSp[0];
	tag.c1s.visible = true;
	}else{
	tag.line1s.text = "";
	tag.c1s.visible = false;
	}
	if( lineListsSp[1] != null){
	tag.line2s.text = lineListsSp[1];
	tag.c2s.visible = true;
	}else{
	tag.line2s.text = "";
	tag.c2s.visible = false;
	}
	if( lineListsSp[2] != null){
	tag.line3s.text = lineListsSp[2];
	tag.c3s.visible = true;
	}else{
	tag.line3s.text = "";
	tag.c3s.visible = false;
	}
	if( lineListsSp[3] != null){
	tag.line4s.text = lineListsSp[3];
	tag.c4s.visible = true;
	}else{
	tag.line4s.text = "";
	tag.c4s.visible = false;
	}
	if( lineListsSp[4] != null){
	tag.line5s.text = lineListsSp[4];
	tag.c5s.visible = true;
	}else{
	tag.line5s.text = "";
	tag.c5s.visible = false;
	}
       
}

function print_buttonClick(e:MouseEvent) {
	if(checkPrintValues()){
     var prints:Printing = new Printing(tagLang, tag.english.text, tag.spanish.text, "$" + String(softPrice), tag.ddr.text, lineListsSp, sku.text,cbBrand.selectedLabel.toUpperCase(),model.text.toUpperCase(),price.text, totalPrice, officePrice, titleT.text.toUpperCase(), ram.text, hd.text  + " " + hdT,Number(bundle.selectedItem.data) + 1,Number(software.software.selectedItem.data) + 1,lineLists);       
	}
}

function clear_buttonClick(e:MouseEvent) {

	sku.text = "";
	
	model.text = "";
	price.text = "";
	titleT.text = "";
	ram.text = "";
	hd.text = "";
	
	packPrice = 0;
	officePrice = "";
	office.office.text = "";
	software.visible = false;
	office.visible = false;
	software.software.selectedIndex = 0;
	tag.bundle.software.gotoAndStop(1);
	bundle.selectedIndex = 0;
	tag.bundle.gotoAndStop(1);
	
	tag.bundle.officeprice1.text = "";
	tag.bundle.officeprice2.text = "";
	tag.bundle.officeprice3.text = "";
	
	software.visible = false;
	office.visible = false;
	//tag.bundle.totprice2.visible = false;
	//tag.bundle.totprice.visible = false;
	//tag.bundle.totcents.visible = false;

	tag.c1.visible = false;
	tag.c2.visible = false;
	tag.c3.visible = false;
	tag.c4.visible = false;
	tag.c5.visible = false;
	
	tag.line1.text = "";
	tag.line2.text = "";
	tag.line3.text = "";
	tag.line4.text = "";
	tag.line5.text = "";
	
	tag.c1s.visible = false;
	tag.c2s.visible = false;
	tag.c3s.visible = false;
	tag.c4s.visible = false;
	tag.c5s.visible = false;
	
	tag.line1s.visible = false;
	tag.line2s.visible = false;
	tag.line3s.visible = false;
	tag.line4s.visible = false;
	tag.line5s.visible = false;
	tag.btp.visible = true;
	tag.btpe.visible = false;
	tag.btps.visible = false;

	tag.btp.text = "";
	tag.btpe.text = "";
	tag.btps.text = "";

	tag.bundle.software.sprice.visible = false;
	tag.bundle.software.sprice.text = ""
	
	tag.english.visible = false;
	tag.spanish.visible = false;
	
	softPrice = 0;
	
	cbBrand.selectedIndex = 0;
	
	ddrtype.selectedIndex = 0;
	hdtype.selectedIndex = 0;
	
	software.oneyrRb.selected = true;
	
	ddrT = 1;
	hdT = "GB";
	
	updateTagText()
	fm.setFocus(sku);
	status.gotoAndStop(1);
	onlineStatus.gotoAndStop(1);
	onlinePrice.text = "";
	browser_button.visible = false;
	replace_button.visible = false;
	
}


function save_buttonClick(e:MouseEvent) {
if(checkSkuValues()){
	loader2.addEventListener(Event.COMPLETE, onSComplete);
	loader2.addEventListener(IOErrorEvent.IO_ERROR, onIOError, false, 0, true);
	loader2.load( new URLRequest(File.documentsDirectory.resolvePath("xml/skulist.xml").url));
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

function onIOError3(e:IOErrorEvent):void {

	trace("Load 3 Error:\n" + e.text);
	createXml();
	   
}

function onSComplete(e:Event):void {
try{
	var loadXml = new XML(e.target.data);
	//var attributes:XMLList = loadXml.*.(@sku == sku.text);
	var cnt:Number = -1;
	for each (var node in loadXml.item)
{

	cnt += 1;
	if(node.@sku == sku.text){
			delete loadXml.item[cnt];
	}
	status.gotoAndStop(2);
	alertbox("Save succesful.");
}

	

	
	
	 
	
	var tmpSku:XML = <item/>
	tmpSku.@sku = sku.text;
	tmpSku.brand = cbBrand.selectedLabel;
	tmpSku.model = model.text.toUpperCase();
	tmpSku.price = price.text.toUpperCase();
	tmpSku.tittle = titleT.text.toUpperCase();
	tmpSku.ram = ram.text;
	tmpSku.ddr = ddrtype.selectedLabel;
	tmpSku.hd = hd.text;
	tmpSku.cap = hdtype.selectedLabel;
	
	
	loadXml.appendChild(tmpSku);
	
	//loadXml.prettyPrinting = true;

	var writefile:Writing = new Writing(loadXml.toString());
	status.gotoAndStop(2);
	loader2.removeEventListener(Event.COMPLETE, onComplete);
	loader2.removeEventListener (IOErrorEvent.IO_ERROR, onIOError);
}catch(err:Error){
	trace("Load 2 Error:\n" + err.message);
}
																				   
}
function createXml():void {

var writefile:Writing = new Writing("<skulist> </skulist>");
obj = sku;
alertbox("This is our first time running the PSD. A xml file has been created to store your items.");
}

function onIOError(e:IOErrorEvent):void {
trace("IO Error:\n" + e.text);
}

function searchSku(xml:XML):void{
	var brandStr:String
	var strXml:String = String(xml.*.(@sku == sku.text));
	trace("XML NODE" + strXml + "End");
	if( strXml == ""){
		//obj = brand;
			status.gotoAndStop(3);
		//alertbox("Sku not found. Please create the item info and save.")
	}else{
	brandStr = xml.*.(@sku == sku.text).brand;
	trace(brandStr);
	updateBrand(brandStr);
	model.text = xml.*.(@sku == sku.text).model;
	price.text = xml.*.(@sku == sku.text).price;
	titleT.text = xml.*.(@sku == sku.text).tittle;
	ram.text = xml.*.(@sku == sku.text).ram;
	updateDdr(xml.*.(@sku == sku.text).ddr);
	hd.text = xml.*.(@sku == sku.text).hd;
	updateHd(xml.*.(@sku == sku.text).cap);
	software.oneyrRb.selected = true;
	updateTagText();
	status.gotoAndStop(2);
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
	}
	
       
	
}


function updateDdr(tmpDdr:String):void{
	
	switch(tmpDdr){
		case "DDR2":
			ddrT = 1;
			ddrtype.selectedIndex = 0;
			break;
		case "DDR3":
			ddrT = 2;
			ddrtype.selectedIndex = 1;
			break;
		default:
			ddrT = 1;
			ddrtype.selectedIndex = 0;
			break;
	}
}

function updateHd(tmpCap:String):void{
	switch(tmpCap){
		case "GB":
			hdT = "GB";
			hdtype.selectedIndex = 0;
			break;
		case "TB":
			hdT = "TB";
			hdtype.selectedIndex = 1;
			break;
		default:
			hdT = "GB";
			hdtype.selectedIndex = 0;
			break;
	}
}

function updateBrand(tmpBrand:String):void{
	trace(tmpBrand);
	switch(tmpBrand){
		case "(Choose Brand)":
			cbBrand.selectedIndex = 0;
			break;
		case "ACER":
			cbBrand.selectedIndex = 1;
			break;
		case "ASUS":
			cbBrand.selectedIndex = 2;
			break;
		case "COMPAQ":
			cbBrand.selectedIndex = 3;
			break;
		case "DELL":
			cbBrand.selectedIndex = 4;
			break;
		case "EMACHINE":
			cbBrand.selectedIndex = 5;
			break;
		case "GATEWAY":
			cbBrand.selectedIndex = 6;
			break;
		case "HEWLETT PACKARD":
			cbBrand.selectedIndex = 7;
			break;
		case "SONY":
			cbBrand.selectedIndex = 8;
			break;
		case "TOSHIBA":
			cbBrand.selectedIndex = 9;
			break;
	}
	
	if (cbBrand.selectedLabel == "(Choose Brand)") {
			tag.brand.text = ""
	}else{
	   		tag.brand.text = cbBrand.selectedLabel;
	}
	
}


function updateTagText():void{
	tag.sku.text = sku.text;
		updateBrand(cbBrand.selectedLabel);
		
	   tag.model.text = model.text.toUpperCase();
	   /*
	   if(price.text.length <= 6){
		   if(price.text.indexOf(".") > -1){
			   	tag.price2.text = "";
				tag.price.text = price.text.substr(0,price.text.indexOf("."));
				tag.cents.text = price.text.substring(price.text.indexOf(".") + 1,price.text.length);
		   }else if(price.text != ""){
			    tag.price2.text = "";
				tag.price.text = price.text;
				tag.cents.text = "00";
		   }else{
		   		tag.price2.text = "";
				tag.price.text = "";
				tag.cents.text = "";
		   }
		}else if(price.text.length > 6){
				tag.price.text = "";
				tag.price2.text = price.text.substr(0,price.text.indexOf("."));
				tag.cents.text = price.text.substring(price.text.indexOf(".") + 1,price.text.length);
		}*/
		trace(price.text.length > 6);
	   tmpBTP = Number(price.text)
	   if(tmpBTP > 0 && tmpBTP <= 399.99){
				tag.btp.text = "229.99";
			}else if(tmpBTP >= 400 && tmpBTP <= 599.99){
				tag.btp.text = "269.99";
			}else if(tmpBTP >= 600 && tmpBTP <= 749.99){
				tag.btp.text = "299.99";
			}else if(tmpBTP >= 750 && tmpBTP <= 999.99){
				tag.btp.text = "329.99";
			}else if(tmpBTP >= 1000 && tmpBTP <= 1499.99){
				tag.btp.text = "399.99";
			}else if(tmpBTP >= 1500){
				tag.btp.text = "449.99";
			}
	   
	   tag.titleT.text = titleT.text.toUpperCase();
	   tag.ram.text = ram.text;
	   tag.hd.text = hd.text  + " " + hdT;
	   
	   if(ddrT == 1){
			tag.ddr.text = "DDR2";
		}else if(ddrT == 2){
			tag.ddr.text = "DDR3";
		}
	   
	   officePrice = office.office.text;
       totalPrice = String(int((Number(price.text) + packPrice + Number(officePrice) + softPrice)*100)/100);
		if(totalPrice.length <= 6){
		   if(totalPrice.indexOf(".") > -1){
			   	tag.price2.text = "";
				tag.price.text = totalPrice.substr(0,totalPrice.indexOf("."));
				tag.cents.text = totalPrice.substring(totalPrice.indexOf(".") + 1,totalPrice.length);
		   }else{
			    tag.price2.text = "";
				tag.price.text = totalPrice;
				tag.cents.text = "00";
		   }
		}else{
				tag.price.text = "";
				tag.price2.text = totalPrice.substr(0,totalPrice.indexOf("."));
				tag.cents.text = totalPrice.substring(totalPrice.indexOf(".") + 1,totalPrice.length);
		}


		if(tagLang == 2){
			if(ddrT == 1){
				tag.ddr.text = "DDR2";
				tag.ddrs.text = "DDR2";
			}else if(ddrT == 2){
				tag.ddr.text = "DDR3";
				tag.ddrs.text = "DDR3";
			}
			
		   if(tmpBTP > 0 && tmpBTP <= 399.99){
				tag.btps.text = "229.99";
				tag.btpe.text = "229.99";
			}else if(tmpBTP >= 400 && tmpBTP <= 599.99){
				tag.btps.text = "269.99";
				tag.btpe.text = "269.99";
			}else if(tmpBTP >= 600 && tmpBTP <= 749.99){
				tag.btps.text = "299.99";
				tag.btpe.text = "299.99";
			}else if(tmpBTP >= 750 && tmpBTP <= 999.99){
				tag.btps.text = "329.99";
				tag.btpe.text = "329.99";
			}else if(tmpBTP >= 1000 && tmpBTP <= 1499.99){
				tag.btps.text = "399.99";
				tag.btpe.text = "399.99";
			}else if(tmpBTP >= 1500){
				tag.btps.text = "449.99";
				tag.btpe.text = "449.99";
			}
			
		tag.rams.text = ram.text;
	   	tag.hds.text = hd.text + " " + hdT;
		tag.hde.text = hd.text + " " + hdT;
	   }
	   
		switch(Number(bundle.selectedItem.data)){
		case 3:
			tag.bundle.officeprice1.text = "$" + officePrice;
			tag.bundle.officeprice2.text = "";
			tag.bundle.officeprice3.text = "";
			break;
		case 4:
			tag.bundle.officeprice1.text = "";
			tag.bundle.officeprice2.text = "$" + officePrice;
			tag.bundle.officeprice3.text = "";
			break;
		case 5:
			tag.bundle.officeprice1.text = "";
			tag.bundle.officeprice2.text = "";
			tag.bundle.officeprice3.text = "$" + officePrice;
			break;
		default:
			tag.bundle.officeprice1.text = "";
			tag.bundle.officeprice2.text = "";
			tag.bundle.officeprice3.text = "";
			break;
	}
	
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

function checkPrintValues():Boolean{

	if(sku.text.length != 7 || isNaN(Number(sku.text))){
		obj = sku;
		alertbox("Please make sure to enter a correct sku before attempting to print.");
		return false;
	}else if(cbBrand.selectedIndex == 0){
		obj = cbBrand;
		alertbox("Please select a brand.");
		return false;
	}else if(model.text == ""){
		obj = model;
		alertbox("Please make sure to enter a model.");
		return false;
	}else if(price.text == "" || isNaN(Number(price.text))){
		obj = price;
		alertbox("Please make sure to enter a price.");
		return false;
	}else if(titleT.text == ""){
		obj = titleT;
		alertbox("Please make sure to enter a title.");
		return false;
	}else if(ram.text == "" || isNaN(Number(ram.text))){
		obj = ram;
		alertbox("Please make sure to enter amount of ram.");
		return false;
	}else if(hd.text == "" || isNaN(Number(hd.text))){
		obj = hd;
		alertbox("Please make sure to enter hard drive size.");
		return false;
	}else if(Number(bundle.selectedItem.data) == 0){
		obj = bundle;
		alertbox("Please make sure to select a package.");
		return false;
	}else if(((Number(bundle.selectedItem.data) >= 1 && Number(bundle.selectedItem.data) <= 4)) || Number(bundle.selectedItem.data) == 7){
		if(Number(software.software.selectedItem.data) == 0){
		obj = software.software;
		alertbox("Please make sure to select a software title for your package.");
		return false;}
	}
	
	if(Number(bundle.selectedItem.data) >= 3 && Number(bundle.selectedItem.data) <= 5){
		if(office.office.text == "" || isNaN(Number(office.office.text))){
		obj = office.office;
		alertbox("Please make sure to enter a price for office.");
		return false;}
	}
       
	return true;
}

function checkSkuValues():Boolean{
	
	if(sku.text.length != 7 || isNaN(Number(sku.text))){
		obj = sku;
		alertbox("Please make sure to enter a correct sku before attempting to save.");
		return false;
	}else if(cbBrand.selectedIndex == 0){
		obj = cbBrand;
		alertbox("Please select a brand.");
		return false;
	}else if(model.text == ""){
		obj = model;		
		alertbox("Please make sure to enter a model.");
		return false;
	}else if(price.text == "" || isNaN(Number(price.text))){
		obj = price;
		alertbox("Please make sure to enter a price.");
		return false;
	}else if(titleT.text == ""){
		obj = titleT
		alertbox("Please make sure to enter a title.");
		return false;
	}else if(ram.text == "" || isNaN(Number(ram.text))){
		obj = ram
		alertbox("Please make sure to enter amount of ram.");
		return false;
	}else if(hd.text == "" || isNaN(Number(hd.text))){
		obj = hd;
		alertbox("Please make sure to enter hard drive size.");
		return false;
	}
       trace("sku true");
	return true;
}


function ok_buttonClick(e:MouseEvent) {

disable_mc.visible = false;
popup.visible = false;

sku.enabled = true;
cbBrand.enabled = true;
model.enabled = true;
price.enabled = true;
titleT.enabled = true;
ram.enabled = true;
hd.enabled = true;
bundle.enabled = true;
software.software.enabled = true;
office.office.enabled = true;

ddrtype.enabled = true;
hdtype.enabled = true;
software.moRb.enabled = true;
software.oneyrRb.enabled = true;
software.twoyrRb.enabled = true;
software.threeyrRb.enabled = true;
//load_button.enabled = true;
save_button.enabled = true;
clear_button.enabled = true;
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
cbBrand.enabled = false;
model.enabled = false;
price.enabled = false;
titleT.enabled = false;
ram.enabled = false;
hd.enabled = false;
bundle.enabled = false;
software.software.enabled = false;
office.office.enabled = false;

ddrtype.enabled = false;
hdtype.enabled = false;
software.moRb.enabled = false;
software.oneyrRb.enabled = false;
software.twoyrRb.enabled = false;
software.threeyrRb.enabled = false;
//load_button.enabled = false;
save_button.enabled = false;
clear_button.enabled = false;
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