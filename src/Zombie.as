package  
{
	import flash.geom.Point;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxTilemap;
	/**
	 * ...
	 * @author Kris Harris
	 */
	
	public class Zombie extends FlxSprite 
	{
		public static var ZOMBIE_SPEED:Number = 30;
	
		[Embed(source = "data/zombie.png")] 		protected var IMG_ZOMBIE:Class;
		private var _level:FlxTilemap;
		public var _talkTimeout:Number;
		
		public function Zombie() 
		{
			super(0, 0, IMG_ZOMBIE);
			_talkTimeout = 0;
			width = 6;
			height = 10;
			offset.x = 1
			offset.y = 14;
			exists = false;
		}
		
		public override function update():void
		{
			if (exists && isTouching(FlxObject.FLOOR)) {
				if(isTouching(FlxObject.LEFT)) {
					velocity.x = ZOMBIE_SPEED;
				}else if (isTouching(FlxObject.RIGHT)) {
					velocity.x = -ZOMBIE_SPEED;
				}
				
				var lookAt:FlxPoint = new FlxPoint(x, y);
				if (velocity.x > 0) lookAt.x += width + 1;
				else lookAt.x -= 1;
				lookAt.y += height + 2;
				
				if (!_level.overlapsPoint(lookAt)) velocity.x *= -1;
				
				if (velocity.x < 0) scale.x = -1;
				else scale.x = 1;
				
				if (y > _level.height) kill();
			}
			_talkTimeout -= FlxG.elapsed;

			
			super.update();
		}
		
		public function  setLevel(level:FlxTilemap):void 
		{
			_level = level;
		}
		
		public function resetZombie(X:Number, Y:Number, facingLeft:Boolean = false):void {
			super.reset(X, Y);
			acceleration.y = 800;
			maxVelocity.y = 1600;
			velocity.x = (facingLeft)? -ZOMBIE_SPEED : ZOMBIE_SPEED;
			
		}
	
	}

}