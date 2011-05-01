package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.plugin.photonstorm.FlxColor;
	
	/**
	 * ...
	 * @author Kris Harris
	 */
	public class ThoughtBubble extends FlxText 
	{
		
		protected var _timeLeft:Number;
		
		public function ThoughtBubble() 
		{
			super(0, 0, 180);
			alignment = "center";
			exists = false;
		}
		
		public override function reset(X:Number, Y:Number):void
		{
			super.reset(X, Y);
			_timeLeft = 2.5;
			alpha = 1;
			color = FlxColor.HSVtoRGB(FlxG.random() * 180, 1, .5);
			shadow = 0xff000000;
		}
		
		public override function update():void
		{
			_timeLeft -= FlxG.elapsed;
			if (_timeLeft < .5) alpha = _timeLeft * 2;
			if (_timeLeft < 0) kill();
			super.update();
			
		}
	}

}