package  
{
	import org.flixel.system.FlxPreloader;
	
	/**
	 * ...
	 * @author Kris Harris
	 */
	public class Preloader extends FlxPreloader 
	{
		
		public function Preloader() 
		{
			trace("Hit the preloader");
			className = "MainGame";
			super();
		}
		
	}

}