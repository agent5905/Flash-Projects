package dag{ 
    import flash.display.Loader; 
    import flash.display.NativeMenu; 
    import flash.display.NativeMenuItem; 
    import flash.display.NativeWindow; 
    import flash.display.Sprite; 
    import flash.desktop.DockIcon; 
    import flash.desktop.SystemTrayIcon; 
    import flash.events.Event; 
    import flash.net.URLRequest; 
    import flash.desktop.NativeApplication; 
 
    public class DotaSysTray extends Sprite 
    { 
        public function DotaSysTray():void{ 
            NativeApplication.nativeApplication.autoExit = false; 
            var icon:Loader = new Loader(); 
            var iconMenu:NativeMenu = new NativeMenu(); 
            var exitCommand:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Exit")); 
                exitCommand.addEventListener(Event.SELECT, function(event:Event):void { 
                    NativeApplication.nativeApplication.icon.bitmaps = []; 
                    NativeApplication.nativeApplication.exit(); 
                }); 
 
            if (NativeApplication.supportsSystemTrayIcon) { 
                NativeApplication.nativeApplication.autoExit = false; 
                icon.contentLoaderInfo.addEventListener(Event.COMPLETE, iconLoadComplete); 
                icon.load(new URLRequest("icons/icefrog_16.png")); 
                 
                var systray:SystemTrayIcon =  
                    NativeApplication.nativeApplication.icon as SystemTrayIcon; 
                systray.tooltip = "AIR application";
                systray.menu = iconMenu; 
            } 
 
            if (NativeApplication.supportsDockIcon){ 
                icon.contentLoaderInfo.addEventListener(Event.COMPLETE,iconLoadComplete); 
                icon.load(new URLRequest("icons/icefrog_128.png")); 
                var dock:DockIcon = NativeApplication.nativeApplication.icon as DockIcon;  
                dock.menu = iconMenu; 
            } 
            stage.nativeWindow.close(); 
        } 
         
        private function iconLoadComplete(event:Event):void 
        { 
            NativeApplication.nativeApplication.icon.bitmaps = 
                [event.target.content.bitmapData]; 
        } 
    } 
} 