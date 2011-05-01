package 
{
	import org.flixel.FlxGame;
	import org.flixel.FlxG;
	import org.flixel.*;
	import Preloader;
	[SWF(width = "640", height = "480")]
	[Frame(factoryClass="Preloader")]
	/**
	 * ...
	 * @author Kris Harris
	 */
	public class MainGame extends FlxGame 
	{
		
		public function MainGame():void 
		{
			super(320, 240, TitleScreen, 2);
			
		}
		

	}
	
}