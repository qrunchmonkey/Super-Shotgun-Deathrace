package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Kris Harris
	 */
	public class Overlay extends FlxSprite 
	{
		private var callback:Function;
		private var counter:Number;
		private var transitionLength:Number;
		private var done:Boolean;
		
		public function Overlay() 
		{
			super(0, 0);
			scrollFactor.x = 0;
			scrollFactor.y = 0;
			makeGraphic(320, 240);
			alpha = 0;
		}
		
		override public function update():void 
		{
			if (!done && counter > transitionLength) {
				callback.call();
				done = true;

			}
			
			if (!done) {
				counter += FlxG.elapsed;
				alpha = counter / transitionLength;
			}
			
			super.update();
		}
		
		
		public function fadeIn(time:Number, _callback:Function):void {
			callback = _callback;
			transitionLength = time;
			done = false;
			counter = 0;
		}
		
		public function isFading():Boolean
		{
			if (!done && counter < transitionLength) return true;
			else return false;
		}
	}

}