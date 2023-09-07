package dag.dinosmasher {
	import flash.display.MovieClip;
	
	public class Building extends MovieClip {
		
		public var buildingHealth:int = 100;
		public var BuildingDamageType:int;
		private var BuildingAttackable:Boolean = false;
		//private var shrubbery:Shrubbery;
		private var SPRITE_WIDTH:int;
				
		private static const DAMAGE_STOMP:int = 1;
		private static const DAMAGE_LASER:int = 2;
		private static const DAMAGE_ROAR:int = 3;
		
		public function Building() {
			
			//BuildingDamageType = DamageType;
			
			
			
			
			//shrub_position = BuildingArray[1];
			
			//SPRITE_BUFFER = BuildingArray[3];
		}
		
		public function attacked(DamageType:int):void
		{
			if(DamageType == BuildingDamageType)
				buildingHealth -= 10;
			
			if(buildingHealth <=70 && buildingHealth >=40)
			{
				this.gotoAndStop(2);
			}else if(buildingHealth <=30 && buildingHealth >=10)
			{
				this.gotoAndStop(3)
			}else if(buildingHealth == 0)
			{
				death();
			}
			
		}
		
		public function death():void
		{
			//death of a building animation
			
		}

	}
	
}
