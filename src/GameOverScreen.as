package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxGradient;

	/**
	 * ...
	 * @author Kris Harris
	 */
	public class GameOverScreen extends FlxState 
	{
		
		public var livedFor:Number; //seconds
		public var traveled:int; //Distance, pixels
		public var becameAZombie:Boolean;
		public var wonTheGame:Boolean;
		
		private var ARMED_SAYINGS:Array = ["armed only with your wits", "armed with nothing at all", "without a weapon", "without using your shotgun", "without firing a shot", "without violating statute 1121.1/c"];
		private var ZOMBIE_DEATH_SAYINGS:Array = ["becoming a zombie.", "being bitten.", "discovering your love for brains.", "joining team zombie.", "becoming one of the hoard.", "discovering your hunger for brains.",
		"finding out how tasty brains are.","learning what a brain tastes like.","having your brains eaten.","getting infected.","asking everyone you met if they knew where you could find some tasty, tasty brains.",
		"hungering for brains.", "being zombified.", "getting your zombie on."];
		
		private var NATURAL_DEATH_SAYINGS:Array = ["dying.", "expiring.", "passing on.", "ceasing to be.", "falling to your death.", "becoming an ex-person", "pining for the fjords.", "pushing up the daises.", "meeting your maker.", "kicking the bucket.","donating your body to science."];
		private var ENCOURAGEMENT_SAYINGS:Array = ["Nice job.","Good job.","Good times.","(Which is better than we expected you'd do with no shotgun.)","Fairly impressive...for an unarmed stick figure flailing about like mad.",
		"Not bad.", "Well played.", "Way to go.", "Next time, try shooting them.", "Next time, try it backwards.", "Next time, try it with a slice of lemon.","Next time, try harder.","Next time, try it with your eyes closed.", "Did you know brains are an important part of your daily brains brains brains? This message brought to you by the U.S. Brains Council."];
		
		private var WIN_CONDITION_SAYINGS:Array = ["making like Charlie Sheen and #WINNING.", "beating the game.", "somehow escaping the zombies.", "impressing us with your great success.", "discovering the supply depot.",
		"discovering the vault.","discovering the end of the map. We agree, this game would be even cooler if the map was infinite, but unfortunately time is not.","discovering what lies at the end of the rainbow.","winning.",
		"winning. It took me two days to write, I figured it would have taken you two days to beat.", "finding a bunch of empty crates.", "discovering a bunch of empty boxes. You hopped over all those zombies for THIS?!",
		"learning that the shotgun was a lie.", "getting away.", "escaping.", "finishing the level.", "finishing the game."];
		
		public override function create():void
		{
			
		add(FlxGradient.createGradientFlxSprite(320, 240, [0x2f4faa, 0x031440], 8));

			var text:String;
			text = "You survived for " + FlxU.formatTime(livedFor) + " ";
			text = text + "and traveled " + FlxU.round(traveled/2)/4.0 + "m ";
			text = text + FlxG.getRandom(ARMED_SAYINGS) as String;
			text = text + " before ";
			if (becameAZombie) {
				text = text + FlxG.getRandom(ZOMBIE_DEATH_SAYINGS) as String;
			}else if (wonTheGame) {
				text = text + FlxG.getRandom(WIN_CONDITION_SAYINGS) as String;
			}else {
				text = text + FlxG.getRandom(NATURAL_DEATH_SAYINGS) as String;
			}
			text = text + " " + FlxG.getRandom(ENCOURAGEMENT_SAYINGS) as String;
			
			add(new FlxText(40, 40, 240, text));
			
			var label:FlxText;
			label = new FlxText(0, 170, 320, "PRESS [x] TO REPLAY OR [space] TO RETURN TO MENU");
			label.alignment = "center";
			add(label);
			
			
		}
		
		public override function update():void
		{
			if (FlxG.keys.X ) FlxG.switchState(new Level1());
			if (FlxG.keys.SPACE) FlxG.switchState(new TitleScreen());
			super.update();
		}
		
	}

}