package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.plugin.photonstorm.FlxGradient;
	
	/**
	 * ...
	 * @author Kris Harris
	 */
	public class TitleScreen extends FlxState 
	{
		[Embed(source = "data/ssd-logo.png")] 		protected var IMG_GAME_LOGO:Class;
		
		public override function create():void
		{
			add(FlxGradient.createGradientFlxSprite(320, 240, [0x2f4faa, 0x031440], 8));
			add(new FlxSprite(6, 72, IMG_GAME_LOGO));
			var text:FlxText;
			text = new FlxText(0, 170, 320, "PRESS [space] or [x] TO BEGIN");
			text.alignment = "center";
			add(text);
			
			text = new FlxText(10, 220, 200, "(c) 2011 Kris Harris");
			text.alpha = .25;
			add(text);
			
			FlxG.playMusic(Sounds.MUSIC);
		}
		
		public override function update():void
		{
			if (FlxG.keys.X || FlxG.keys.SPACE || FlxG.keys.ENTER) FlxG.switchState(new Level0());
			super.update();
		}
	}

}