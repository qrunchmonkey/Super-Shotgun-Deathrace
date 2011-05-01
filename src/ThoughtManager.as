package  
{
	import org.flixel.FlxGroup;
	
	/**
	 * ...
	 * @author Kris Harris
	 */
	public class ThoughtManager extends FlxGroup 
	{
		
		public function ThoughtManager() 
		{
			super();
			var bubble:ThoughtBubble;
			for (var i:int = 0; i < 20; i++) {
				bubble = new ThoughtBubble();
				add(bubble);
				bubble.exists = false;
			}
		}
		
		public function say(what:String,x:Number,y:Number):void 
		{
			var bubble:ThoughtBubble = getFirstAvailable() as ThoughtBubble;
			if (bubble) {
				bubble.reset(x- (bubble.width/2), y);
				bubble.text = what;
			}
		}
		
	}

}