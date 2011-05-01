package  
{
	/**
	 * ...
	 * @author Kris Harris
	 */
	public class Sounds 
	{
		
		[Embed(source = "data/zomb1.mp3")]			public static var ZOMBIE_GROWL_1:Class;
		[Embed(source = "data/zomb2.mp3")]			public static var ZOMBIE_GROWL_2:Class;
		[Embed(source = "data/zomb3.mp3")]			public static var ZOMBIE_GROWL_3:Class;
		
		[Embed(source = "data/omnom1.mp3")]			public static var ZOMBIE_NOM_1:Class;
		[Embed(source = "data/omnom2.mp3")]			public static var ZOMBIE_NOM_2:Class;
		[Embed(source = "data/omnom3.mp3")]			public static var ZOMBIE_NOM_3:Class;
		
		
		[Embed(source = "data/fall.mp3")]			public static var PLAYER_HIT:Class;
		[Embed(source = "data/uhoh.mp3")]			public static var PLAYER_FELL_TO_DEATH:Class;
		[Embed(source = "data/jump1.mp3")]			public static var PLAYER_JUMP1:Class;
		[Embed(source = "data/jump2.mp3")]			public static var PLAYER_JUMP2:Class;
		[Embed(source = "data/jump3.mp3")]			public static var PLAYER_JUMP3:Class;
		
		[Embed(source = "data/paper.mp3")]			public static var PAPER:Class;
		[Embed(source = "data/crate_deny.mp3")]		public static var CRATE:Class;
		
		[Embed(source = "data/exitopen.mp3")]		public static var EXIT_OPENED:Class;

		[Embed(source = "data/teleport.mp3")]		public static var TELEPORT:Class;

		[Embed(source = "data/bgm.mp3")]			public static var MUSIC:Class;
		
		public function Sounds() 
		{
			
		}
		
	}

}