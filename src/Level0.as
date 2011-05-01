package  
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.plugin.photonstorm.FlxDelay;
	/**
	 * ...
	 * @author Kris Harris
	 */
	public class Level0 extends FlxState 
	{
		[Embed(source = "data/bg_tiles.png")] 		protected var IMG_BACKGROUND_TILES:Class;
		[Embed(source = "data/fg_autotiles.png")]	protected var IMG_FOREGROUND_TILES:Class;
		[Embed(source = "data/map1.png")] 			protected var IMG_LEVEL0_MAP:Class;
		[Embed(source = "data/dude.png")] 			protected var IMG_HERO:Class;
		[Embed(source = "data/floor_button.png")] 	protected var IMG_BUTTON:Class;
		[Embed(source = "data/pipe.png")] 			protected var IMG_PIPE:Class;
		[Embed(source = "data/postit.png")] 		protected var IMG_NOTE:Class;
		[Embed(source = "data/light.png")] 			protected var IMG_LIGHT:Class;
		[Embed(source = "data/gateway.png")] 		protected var IMG_DOOR:Class;
		[Embed(source = "data/go_alone.png")] 		protected var IMG_WALL_NOTE_0:Class;
		[Embed(source = "data/take_this.png")] 		protected var IMG_WALL_NOTE_1:Class;
		[Embed(source = "data/wall_arrow_down.png")] protected var IMG_WALL_ARROW:Class;
		[Embed(source = "data/pipe_gibs.png")] 		protected var IMG_PIPE_GIBS:Class;
		
		[Embed(source = "data/button_click.mp3")] 	protected var FLOOR_BTN_CLICK:Class;
		[Embed(source = "data/woosh.mp3")]			protected var WOOSH:Class;
		
		
		
		[Embed(source = "data/Background0.csv", mimeType = "application/octet-stream")] protected var CSV_BACKGROUND_MAP:Class;
		
		private var NOTE_TEXT:Array = [
		"The note reads:\n\n\"Originally this tube dispensed free shotguns. However, in the dystopian future that this game is set in, violence - especially in video games - is strictly forbidden.\"\n\n\n                    PRESS [x] TO CONTINUE",
		"\"One thing we do have here in the future is Zombies - and lots of 'em. So, good luck with that.\n\n\nPS: Please try not to get bitten. The last thing we need is more Zombies running around down here.\"\n\n                    PRESS [x] TO CONTINUE"
		];
		
		
		protected var _level:FlxTilemap;
		protected var _hero:FlxSprite;
		protected var _button:FlxSprite;
		protected var _note:FlxSprite;
		protected var _exit:FlxSprite;
		
		protected var _overlay:Overlay;
		
		protected var zombie:ZombieManager;
		protected var _thoughtMgr:ThoughtManager;

		protected var _textWindow:Note;
	
		
		//game state
		protected var _triggeredButton:Boolean;
		protected var _playerIsReadingNote:Boolean;
		protected var _exitIsOpen:Boolean;
		protected var _timer:FlxDelay;
		protected var _emitter:FlxEmitter;
		
		override public function create():void 
		{
			
			var background:FlxTilemap;
			background = new FlxTilemap();
			background.loadMap(new CSV_BACKGROUND_MAP, IMG_BACKGROUND_TILES, 48, 48);
			
			add(background);
			
			//decorations
			add(new FlxSprite(260, 85, IMG_WALL_NOTE_0));
			add(new FlxSprite(450, 165, IMG_WALL_ARROW));
			add(new FlxSprite(70, 225, IMG_WALL_NOTE_1));
			
			add(new FlxSprite(250, 16, IMG_LIGHT));
			add(new FlxSprite(350, 16, IMG_LIGHT));
			add(new FlxSprite(450, 16, IMG_LIGHT));
						
			add(new FlxSprite(250, 176, IMG_LIGHT));
			add(new FlxSprite(350, 176, IMG_LIGHT));
			
			_level = new FlxTilemap();
			_level.loadMap(FlxTilemap.imageToCSV(IMG_LEVEL0_MAP, false, 2), IMG_FOREGROUND_TILES, 8, 8, FlxTilemap.ALT);
			_level.follow();
			add(_level);
			
			_hero = new FlxSprite(300, 0, IMG_HERO);
			_hero.maxVelocity.x = 120;
			_hero.maxVelocity.y = 1600;
			_hero.acceleration.y = 800;
			_hero.drag.x = _hero.maxVelocity.x * 4;
			
			
			FlxG.camera.target = _hero;
			add(_hero);
			
			_button = new FlxSprite(154, 270 );
			_button.loadGraphic(IMG_BUTTON, true, false, 27, 3);
			_button.frame = 1;
			add(_button);
			
			_note = new FlxSprite(75, 0, IMG_NOTE);
			add(_note);
			
			var pipe:FlxSprite;
			pipe = new FlxSprite(50, 0, IMG_PIPE);
			add(pipe);
			
			_thoughtMgr = new ThoughtManager(); 
			zombie = new ZombieManager(_level,_thoughtMgr,_hero);
			zombie.PutZombie(500, 260);
			add(zombie);
			add(_thoughtMgr);
			
			_emitter = new FlxEmitter(100,0,30);
			_emitter.setSize(5, 125);
			_emitter.setXSpeed( -90, 90);
			_emitter.setYSpeed( -25, 0);
			_emitter.gravity = 300;
			_emitter.bounce = .4;
			_emitter.particleDrag.x = 50;
			_emitter.particleDrag.y = 50;
			
			_emitter.makeParticles(IMG_PIPE_GIBS, 30, 16, true);
			add(_emitter);
			
			_overlay = new Overlay();
			add(_overlay);
			
			
			
		}

		override public function update():void 
		{
			_hero.acceleration.x = 0;
			if (!_playerIsReadingNote && !_overlay.isFading()) {
				if (FlxG.keys.LEFT)
					_hero.acceleration.x = -_hero.maxVelocity.x * 4;
			
				if (FlxG.keys.RIGHT)
					_hero.acceleration.x = _hero.maxVelocity.x * 4;
				
				if ((FlxG.keys.SPACE || FlxG.keys.X || FlxG.keys.UP) && _hero.isTouching(FlxObject.FLOOR)) {
					_hero.velocity.y = -225;	
					var r:int = FlxG.random() * 3;
					if (r == 0) FlxG.play(Sounds.PLAYER_JUMP1);
					else if (r == 1) FlxG.play(Sounds.PLAYER_JUMP2);
					else FlxG.play(Sounds.PLAYER_JUMP3);
				}
					
			}else if (_playerIsReadingNote ) //player is reading note
			{
				if (!_textWindow.alive) {
					_playerIsReadingNote = false;
					AddExit();
				}
			}
			
			if (_exit && _hero.alive && _hero.overlaps(_exit) && !_overlay.isFading()) {
				_overlay.fadeIn(1.75, nextLevel);
				_hero.kill();
				FlxG.play(Sounds.TELEPORT);
			}
			
			if (_button.overlaps(_hero)) 
			{
				if (_button.frame) {
					FlxG.play(FLOOR_BTN_CLICK,.75);
					_button.frame = 0;
				}
				if (!_triggeredButton) {
					trace("Trigger hit");
					FlxG.play(WOOSH,.75);
					_triggeredButton = true;
					_note.acceleration.y = 100;
					_emitter.start(true, 20, .01, 0);
					
					
				}
			}else 
			{
				if (_button.frame == 0) {
					FlxG.play(FLOOR_BTN_CLICK,.5);
					_button.frame = 1;
				}
			}
			
			if (_note.exists && _hero.overlaps(_note)) {
				_note.kill();
				_playerIsReadingNote = true;
				_textWindow = new Note();
				_textWindow.SetPages(NOTE_TEXT);
				FlxG.play(Sounds.PAPER, 1.0);
				add(_textWindow);
				trace("Got note");
			}
			
			if (_timer && _timer.hasExpired) {
				_timer = null;
				_exit.play("Flicker");
				_exitIsOpen = true;
			}
			if (_exit) {
				_exit.alpha = .5 + FlxG.random() / 2.0;
			}
			super.update();
			
			
			FlxG.collide(_level, _hero);
			FlxG.collide(_level, _note);
			FlxG.collide(_level, zombie);
			FlxG.collide(_level, _emitter);
			
			FlxG.overlap(_hero, zombie, killPlayerWithZombie);
			
			if (_hero.justTouched(FlxObject.FLOOR)) FlxG.play(Sounds.PLAYER_HIT);
		}
	
		private function AddExit():void 
		{
			_exit = new FlxSprite(48, 264);
			_exit.loadGraphic(IMG_DOOR, true, false, 17, 24);
			_exit.addAnimation("Open", [0, 1, 2, 3, 4, 5, 6, 7], 5, false);
			_exit.addAnimation("Flicker", [6, 7], 5);
			_exit.blend = "add";
			_exit.play("Open");
			add(_exit);
			_timer = new FlxDelay(1400);
			_timer.start();
			FlxG.play(Sounds.EXIT_OPENED);
			_thoughtMgr.say("I wonder where that leads?", _hero.x, _hero.y - 10);
			
		}
		
		public function  killPlayerWithZombie(obj1:FlxObject, obj2:FlxObject):void 
		{
			_hero.kill();
			_overlay.fadeIn(1, transitionToTitle);
		}
		
		
		public function transitionToTitle():void
		{
			FlxG.switchState(new TitleScreen());
		}
		
		public function nextLevel():void {
			FlxG.switchState(new Level1());
		}
	
	
	}
}