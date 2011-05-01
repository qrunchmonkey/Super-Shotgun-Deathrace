package  
{
	import org.flixel.FlxG;
	
	import org.flixel.FlxU;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSave;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import org.flixel.plugin.photonstorm.FlxDelay;
	
	/**
	 * ...
	 * @author Kris Harris
	 */
	public class ZombieManager extends FlxGroup 
	{
		protected var _level:FlxTilemap;
		protected var _timer:FlxDelay;
		protected var _thoughtMgr:ThoughtManager;
		protected var _growls:Array;
		protected var _hero:FlxSprite;
		
		
		private var ZOMBIE_THOUGHTS:Array = [
		"MMM, BRAINS!", "BRAINS!", "DELICIOUS BRAINS","I LOVE BRAINS","BBRRAAIIINNNSS.","WHO SAID BRAINS?","DID YOU SAY BRAINS?","WHERE'S THE BRAIN?","WHERE'S THE BRAINS?","BRAINS? WHERE?",
		"SOMEONE SAID BRAINS!","WANT TO EAT BRAINS","CAN I HAZ BRAINS?","MAYBE THAT GUY HAS BRAINS!","NO BRAINS HERE","GIMME BRAINS","WANT BRAINS","GOTTA HAVE BRAINS",
		"NEED BRAINS","NEED MORE BRAINS","NEED BRAINS HERE","NOT ENOUGH BRAINS","I WANT YOUR BRAINS","I'M THE KING OF BRAINS","THE BRAIN BONE'S CONNECTED TO DELICIOUS","I WANT TO EAT YOU IN THE BRAIN"
		];
		
		public function ZombieManager(level:FlxTilemap, thoughtMrg:ThoughtManager, hero:FlxSprite) 
		{
			super()
			_level = level;
			_thoughtMgr = thoughtMrg;
			_timer = new FlxDelay(1000);
			_timer.start();
			
			_hero = hero;
			
			var growl1:FlxSound;
			growl1 = new FlxSound;
			growl1.loadEmbedded(Sounds.ZOMBIE_GROWL_1);
			
			var growl2:FlxSound;
			growl2 = new FlxSound;
			growl2.loadEmbedded(Sounds.ZOMBIE_GROWL_2);
			
			var growl3:FlxSound;
			growl3 = new FlxSound;
			growl3.loadEmbedded(Sounds.ZOMBIE_GROWL_3);
			
			_growls = [growl1, growl2, growl3];
		}
		
		public function PutZombie(x:Number, y:Number, facingLeft:Boolean = false):Zombie
		{
			var zombie:Zombie = recycle(Zombie) as Zombie;
			if (zombie) {
				zombie.resetZombie(x, y, facingLeft);
				zombie.setLevel(_level);
			}
			return zombie;
		}
		
		public override function update():void
		{
			
			if (_timer.hasExpired) {
				if (countLiving() > 0) {
					
					var zombie:Zombie
					zombie = getRandom() as Zombie;
					if (zombie && zombie.exists && zombie._talkTimeout <= 0 && FlxU.getDistance(zombie.last,_hero.last) < 240) {
						
						_thoughtMgr.say(FlxG.getRandom(ZOMBIE_THOUGHTS) as String, zombie.x + zombie.width / 2, zombie.y - 24) ;
						zombie._talkTimeout = 5;
						
						var snd:FlxSound = FlxG.getRandom(_growls) as FlxSound;
						
						snd.proximity(zombie.x, zombie.y, _hero, 320);
						snd.play();
						_timer.reset(FlxG.random() * 2000);
						_timer.start();
					}else {
						_timer.reset(75);
						_timer.start();
					}
					
				}
				
			}
			
			var growl:FlxSound;
			for (var i:int; i < _growls.length; i++) {
				growl = _growls[i] as FlxSound;
				growl.update();
			}
			super.update();
		}
	}

}