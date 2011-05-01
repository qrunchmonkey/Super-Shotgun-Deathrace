package  
{
	import org.flixel.FlxEmitter;
	
	/**
	 * ...
	 * @author Kris Harris
	 */
	public class CrateExplosion extends FlxEmitter 
	{
		[Embed(source = "data/crate_gibs.png")] protected var IMG_CRATE_GIBS:Class;

		public function CrateExplosion() 
		{
			super();
			setSize(16, 16);
			setXSpeed( -90, 90);
			setYSpeed( -150, 0);
			gravity = 300;
			bounce = .4;
			makeParticles(IMG_CRATE_GIBS, 10, 16, true);
		}
		
	}

}