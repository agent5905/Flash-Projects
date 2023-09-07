package dag.sf4
{
    import flash.display.MovieClip;
    import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.text.Font;

    public class playerWL extends MovieClip
    {	
	
		
           	public var pointsWins:Number;
			public var pointsLoss:Number;
			public var playerGames:Number;
			public var playerID:Number;
			public var pName:String;
			private var blackText:TextFormat = new TextFormat();
			private var greyText:TextFormat = new TextFormat();
			
		public function playerWL():void{
			
           pointsWins = 0;
		   pointsLoss = 0;
		   playerGames = 0;
		   player_selected.visible = false;
		   blackText.color = 0x000000;
		   blackText.font = "Calibri";
		   greyText.color = 0xD5D5D5
		   greyText.font = "Calibri";
        }
	
		public function addWin():void{
           pointsWins += 1;
		   playerGames += 1;
		   updatePoints();
        }
		public function addLoss():void{
           pointsLoss += 1;
		   playerGames += 1;
		   updatePoints();
        }
		
		public function updatePoints():void{
           if(pointsWins < 10){
           		wins.text = "0" + String(pointsWins);
			}else{
				wins.text = String(pointsWins);
			}
			if(pointsLoss < 10){
           		losses.text = "0" + String(pointsLoss);
			}else{
				losses.text = String(pointsLoss);
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
		  player_name.setTextFormat(blackText);
        }
		public function setPlayerLoser():void{
          this.gotoAndStop(3);
		  player_name.setTextFormat(greyText);
        }
		public function setPlayerGold():void{
          this.gotoAndStop(4);
		  player_name.setTextFormat(blackText);
        }
		public function setPlayerSilver():void{
          this.gotoAndStop(5);
		  player_name.setTextFormat(blackText);
        }
        public function setPlayerBronze():void{
          this.gotoAndStop(6);
		  player_name.setTextFormat(blackText);
        }
	
			
    }
}