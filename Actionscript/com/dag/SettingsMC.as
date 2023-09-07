package dag
{
    import flash.display.MovieClip;
    import fl.controls.Button;
    import fl.controls.TextArea;
	import fl.controls.CheckBox;
	import fl.controls.ComboBox;
    import flash.events.Event;
	import flash.events.MouseEvent;
    import dag.GetDotaXML;
    import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.filesystem.*;
	import flash.xml.*;

	
	
    public class SettingsMC extends MovieClip
    {		
		private var getDotaXML = new GetDotaXML();
		private var tittleBarSize:Number = 20;
		private var directory:File = File.applicationDirectory;
		var xmlDes:String = "xml/getDota.xml";
		
		
        public function SettingsMC():void{
            if(!File.applicationStorageDirectory.resolvePath(xmlDes).exists){
				addEventListener(Event.ACTIVATE, function():void{
				txtPath.text = "C:\\Program Files\\Warcraft III\\Maps\\Download";
				cmbInterval.selectedIndex = 0;
				chkAlert.selected = true;
				chkRSS.selected = false;
				chkAutoDL.selected = true;
				chkStart.selected = true;
														   });
			}else{
				getDotaXML.addEventListener(Event.COMPLETE,function():void{
				txtPath.text = getDotaXML.xmlLocation;
				cmbInterval.selectedIndex = getDotaXML.xmlCheck;
				chkAlert.selected = getDotaXML.xmlAlert;
				chkRSS.selected = getDotaXML.xmlRSS;
				chkAutoDL.selected = getDotaXML.xmlAutoDL;
				chkStart.selected = getDotaXML.xmlStartup;});
			getDotaXML.getXML();
			
			}
			btnBrowse.addEventListener(MouseEvent.CLICK,onBrowse);
			btnOK.addEventListener(MouseEvent.CLICK,onOK);
			btnCancel.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void {stage.nativeWindow.close();});
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        }
        
        private function onMouseDown(e:Event):void
		{
			if (stage.mouseY >= 0 && stage.mouseY <= tittleBarSize)
			{
				stage.nativeWindow.startMove();
			}
		}
		
		 private function onBrowse(e:Event):void
		{
			try
			{
    			directory.browseForDirectory("Select Directory");
    			directory.addEventListener(Event.SELECT, directorySelected);
			}
			catch (error:Error)
			{
   				 trace("Failed:", error.message);
				 
			}
		}
		
		private function directorySelected(event:Event):void 
		{
    		directory = event.target as File;
    		txtPath.text = directory.nativePath;
        	trace(directory.nativePath);
    	}
		
		 private function onOK(e:Event):void
		{
			saveXML();
			if(chkStart.selected == true){
				NativeApplication.nativeApplication.startAtLogin = true;
				trace("startup enabled")
			}else{
				NativeApplication.nativeApplication.startAtLogin = false;
				trace("startup disabled")
			}
			
			stage.nativeWindow.close()
		}

		 private function saveXML():void
		{
			getDotaXML.xmlLocation = txtPath.text;
			getDotaXML.xmlAlert = chkAlert.selected;
			getDotaXML.xmlCheck = cmbInterval.selectedIndex;
			getDotaXML.xmlRSS = chkRSS.selected;
			getDotaXML.xmlAutoDL = chkAutoDL.selected;
			getDotaXML.xmlStartup = chkStart.selected;
			trace(chkStart.selected);
   			getDotaXML.saveXML();
		}


		
    }
}