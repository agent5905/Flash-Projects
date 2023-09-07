package dag.sf4
{
    import flash.display.MovieClip;
    import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.text.Font;
	
    public class playerPoints extends MovieClip
    {	
		public var pointsValue:Number;
		public var playerGames:Number;
		public var pName:String;
		private var whiteText:TextFormat = new TextFormat();
		private var greyText:TextFormat = new TextFormat();
		
		public function playerPoints():void{
			
           pointsValue = 0;
		   playerGames = 0;
		   player_selected.visible = false;
		   whiteText.color = 0xFFFFFFF;
		   whiteText.font = "Calibri";
		   greyText.color = 0xD5D5D5
		   greyText.font = "Calibri";
        }
	
		public function addWin():void{
           pointsValue += 3;
		   playerGames += 1;
		   updatePoints();
        }
		public function addLoss():void{
           pointsValue += 0;
		   playerGames += 1;
		   updatePoints();
        }
		public function addDraw():void{
           pointsValue += 1;
		   playerGames += 1;
		   updatePoints();
        }
		public function updatePoints():void{
			if(pointsValue < 10){
           		points.text = "0" + String(pointsValue);
			}else{
				points.text = String(pointsValue);
			}
        }
		public function setPlayerName(playerName:String):void{
           player_name.text = playerName;
		   pName = playerName;
        }
		public function setPlayerSelected(sel:Boolean):void{
           player_selected.visible = sel;
        }
		public function setPlayerWinner():void{
          this.gotoAndStop(2);
		  player_name.setTextFormat(whiteText);
        }
		public function setPlayerLoser():void{
          this.gotoAndStop(3);
		  player_name.setTextFormat(greyText);

        }
    }
}