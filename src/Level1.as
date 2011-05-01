package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxCamera;
	import org.flixel.FlxU;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.plugin.photonstorm.FlxDelay;
	/**
	 * ...
	 * @author Kris Harris
	 */
	public class Level1 extends FlxState 
	{
		[Embed(source = "data/bg_tiles.png")] 		protected var IMG_BACKGROUND_TILES:Class;
		[Embed(source = "data/fg_autotiles.png")]	protected var IMG_FOREGROUND_TILES:Class;
		[Embed(source = "data/map2.png")] 			protected var IMG_LEVEL1_MAP:Class;
		[Embed(source = "data/map2_zombies.png")] 	protected var IMG_LEVEL1_ZOMBIE_MAP:Class;
		[Embed(source = "data/map2_crates.png")] 	protected var IMG_LEVEL1_CRATE_MAP:Class;


		[Embed(source = "data/dude.png")] 			protected var IMG_HERO:Class;
		[Embed(source = "data/crate.png")] 			protected var IMG_CRATE:Class;
		[Embed(source = "data/Background2.csv", mimeType = "application/octet-stream")] protected var CSV_BACKGROUND_MAP:Class;

		private var CRATE_SAYINGS:Array = ["You're not getting a shotgun.", "There's nothing in this crate.", "This one is empty too.", "Look, just leave the crates alone.", "Nothing to see here.", "You got the shotgun! Just kidding, it's empty.",
		"All of the crates on this level are empty.", "Do you realize how many bits you're wasting?", "Nada.", "Nope.", "Nothing.", "Zilch.", "Empty.", "Barren.", "Nuh-uh.", "Hey look! Oh wait, it's empty.", "Boom.", "Kapow.", "Kaboom.",
		"Poof.", "Denied", "Nil.", "NULL.", "UNDEFINED_JOKE_EXCEPTION", "UNDEFINED_TAUNT", "EAX_BAD_JOKE", "Nothing here.", "This one has a brain in it. Gross.","You found Expired zombie repellent!","You found 10 shotgun shells!","You found 50 shotgun shells!"];
		
		
		protected var _level:FlxTilemap;
		protected var _hero:FlxSprite;
		protected var _overlay:Overlay;
		protected var _proxy:FlxObject;
		protected var _crates:FlxGroup;
		protected var _gibs:FlxGroup;
		
		protected var _foundCrates:int;
		
		protected var zombie:ZombieManager;
		protected var _thoughtMgr:ThoughtManager;
		
		protected var playerCamMaxLeft:Number;
		protected var minLookX:Number;
		protected var minLookVelocity:Number;
		protected var maxPlayerX:Number;
		
		private var playTime:Number;
		override public function create():void 
		{
			playTime = 0;
			playerCamMaxLeft = 0;
			minLookX = 0;
			minLookVelocity = 10;
			maxPlayerX = 0;
			
			_gibs = new FlxGroup(6);
			
			var background:FlxTilemap;
			background = new FlxTilemap();
			background.loadMap(new CSV_BACKGROUND_MAP, IMG_BACKGROUND_TILES, 48, 48,0,0,0);
			
			add(background);
			
			_level = new FlxTilemap();
			_level.loadMap(FlxTilemap.imageToCSV(IMG_LEVEL1_MAP, false, 1), IMG_FOREGROUND_TILES, 8, 8, FlxTilemap.ALT);
			_level.follow();
			add(_level);
			
			
			_crates = new FlxGroup();
			add(_crates);
			
			var crateCSV:String = FlxTilemap.imageToCSV(IMG_LEVEL1_CRATE_MAP);
			if (crateCSV) {
				var crate:FlxSprite;
				
				var rows:Array = crateCSV.split("\n");
				var cols:Array;
				for (var y:int = 0; y < rows.length; y++ ) {
					cols = rows[y].split(",");
					for (var x:int = 0; x < cols.length; x++) {
						if (cols[x] > 0) {
						crate = new FlxSprite((x * 8)-4 , (y * 8) - 2, IMG_CRATE); 
						_crates.add(crate);
						}
					}
				}
			}
			
			
			_hero = new FlxSprite(96, 0, IMG_HERO);
			_hero.maxVelocity.x = 120;
			_hero.maxVelocity.y = 1600;
			_hero.acceleration.y = 800;
			_hero.width = 4;
			_hero.offset.x = 4;
			_hero.height = 10;
			_hero.offset.y = 13;
			
			_hero.drag.x = _hero.maxVelocity.x * 4;
			
			_proxy = new FlxObject(_hero.x, _hero.y);
			_proxy.velocity.x = 15;
			
			FlxG.camera.follow(_hero);
			add(_hero);
			add(_proxy);
			
			_thoughtMgr = new ThoughtManager();
			zombie = new ZombieManager(_level,_thoughtMgr,_hero);
			zombie.PutZombie(500, 200);
			add(zombie);
			add(_thoughtMgr);
			
			
			
			
			var zombieCSV:String = FlxTilemap.imageToCSV(IMG_LEVEL1_ZOMBIE_MAP);
			if (zombieCSV) {
				rows = zombieCSV.split("\n");
				cols = null;
				for (y = 0; y < rows.length; y++ ) {
					cols = rows[y].split(",");
					for (x = 0; x < cols.length; x++) {
						if (cols[x] > 0) {
						zombie.PutZombie(x * 8, (y * 8) - 8);
						}
					}
				}
			}

			
		
			
			
			
			
			
			add(_gibs);
			_overlay = new Overlay();
			add(_overlay);
			
			
		}
		
		
		override public function update():void 
		{
			if (_hero.justTouched(FlxObject.FLOOR)) FlxG.play(Sounds.PLAYER_HIT);
			
			maxPlayerX = _hero.x;
			
			if (minLookVelocity < 20) minLookVelocity += FlxG.elapsed;
			
			minLookX += minLookVelocity * FlxG.elapsed;
			if (_hero.x - 160 > playerCamMaxLeft) playerCamMaxLeft = _hero.x - 160;
			var minX:Number = FlxU.max(minLookX, playerCamMaxLeft);
			FlxG.camera.setBounds(minX, 0, _level.width, _level.height);
			FlxG.worldBounds.x = minX - 160;
			playTime += FlxG.elapsed;
			minLookX = minX;
			
			_hero.acceleration.x = 0;
			if (FlxG.keys.LEFT)
					_hero.acceleration.x = -_hero.maxVelocity.x * 4;
			
				if (FlxG.keys.RIGHT)
					_hero.acceleration.x = _hero.maxVelocity.x * 4;
				
				if ((FlxG.keys.SPACE || FlxG.keys.X || FlxG.keys.UP))
				{
					if (_hero.isTouching(FlxObject.FLOOR)){
						_hero.velocity.y = -295;
						var r:int = FlxG.random() * 3;
						if (r == 0) FlxG.play(Sounds.PLAYER_JUMP1);
						else if (r == 1) FlxG.play(Sounds.PLAYER_JUMP2);
						else FlxG.play(Sounds.PLAYER_JUMP3);
					}
					
				}
					
			if (_hero.exists && (_hero.y > _level.height || _hero.x < minX - 15) ) {
				_hero.kill();
				_overlay.fadeIn(3, killPlayerByFalling);
				FlxG.play(Sounds.PLAYER_FELL_TO_DEATH);
				trace("Should be dead");
			}
			if (_hero.exists && _hero.x > (_level.width - 100)) {
				_hero.kill();
				_overlay.fadeIn(3, killPlayerByWinning);
			}
			
			if (_hero.x > FlxG.camera.scroll.x + FlxG.camera.width - _hero.width) _hero.x = FlxG.camera.scroll.x + FlxG.camera.width - _hero.width;
			
			super.update();
			_proxy.y = _hero.y;
			
			
			FlxG.collide(_level, _hero);
			FlxG.collide(_level, zombie);
			FlxG.collide(_level, _gibs);
			FlxG.overlap(_hero, zombie, killPlayerWithZombie);
			FlxG.overlap(_hero, _crates, explodeCrate);
		}
		
		public function  killPlayerWithZombie(obj1:FlxObject, obj2:FlxObject):void 
		{
			_hero.kill();
			
			if (_hero.velocity.x < 0)
				zombie.PutZombie(_hero.x, _hero.y, true);
			else
				zombie.PutZombie(_hero.x, _hero.y);
				
			var r:int = FlxG.random() * 3;
			if (r == 0) FlxG.play(Sounds.ZOMBIE_NOM_1);
			else if (r == 1) FlxG.play(Sounds.ZOMBIE_NOM_2);
			else FlxG.play(Sounds.ZOMBIE_NOM_3);
			
			_overlay.fadeIn(3, killPlayerByZombie);
		}
		
		public function killPlayerByFalling():void
		{
			var gameover:GameOverScreen = new GameOverScreen();
			gameover.livedFor = playTime;
			gameover.becameAZombie = false;
			gameover.traveled = maxPlayerX;
			gameover.wonTheGame = false;
			FlxG.switchState(gameover);
		}
		
		public function killPlayerByZombie():void
		{
			var gameover:GameOverScreen = new GameOverScreen();
			gameover.livedFor = playTime;
			gameover.becameAZombie = true;
			gameover.traveled = maxPlayerX;
			gameover.wonTheGame = false;
			FlxG.switchState(gameover);
		}
		
		public function killPlayerByWinning():void 
		{
			var gameover:GameOverScreen = new GameOverScreen();
			gameover.livedFor = playTime;
			gameover.becameAZombie = false;
			gameover.traveled = maxPlayerX;
			gameover.wonTheGame = true;
			FlxG.switchState(gameover);
		}
		
		public function explodeCrate(player:FlxObject, crate:FlxObject):void {
			crate.kill();
			var gibs:CrateExplosion = _gibs.recycle(CrateExplosion) as CrateExplosion;
	
			gibs.x = crate.x
			gibs.y = crate.y-10;
			
			gibs.start(true, 20, 0, 10);
			FlxG.play(Sounds.CRATE);
			_foundCrates++;
			if (_foundCrates < 3) {
				_thoughtMgr.say(CRATE_SAYINGS[_foundCrates-1] as String, crate.x, crate.y - 20);
			}else {
				_thoughtMgr.say(FlxG.getRandom(CRATE_SAYINGS) as String, crate.x, crate.y - 20);
			}
		}
	}

}