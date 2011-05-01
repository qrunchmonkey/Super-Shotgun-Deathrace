package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Kris Harris
	 */
	public class Note extends FlxGroup 
	{
		[Embed(source = "data/text_bubble.png")] 		protected var IMG_BG:Class;
		
		protected var _done:Boolean;
		protected var _text:FlxText;
		
		protected var _pages:Array;
		protected var _curPage:uint;
		
		public function Note():void 
		{
			var background:FlxSprite;
			
			background = new FlxSprite(FlxG.camera.width / 2 - 132, FlxG.camera.height / 2 - 66, IMG_BG);
			background.scrollFactor.x = 0;
			background.scrollFactor.y = 0;
			add(background);
			_done = true;
			
			_text = new FlxText(FlxG.camera.width / 2 - 132 + 16, FlxG.camera.height / 2 - 66 + 16, 232, "Hey yo yo, this is a whole bunch of text, and I'ma see what the F flixel can do with all this text if I give it all at once.\n press [x] to continue");
			_text.scrollFactor.x = 0;
			_text.scrollFactor.y = 0;
			add(_text);
		}
		
		public function SetPages(strings:Array):void {
			_pages = strings;
			_done = false;
			_curPage = 0;
			_text.text = _pages[_curPage];
		}
		
		override public function update():void 
		{
			if (FlxG.keys.justPressed("X") || FlxG.keys.justPressed("SPACE")) {
				_curPage++;
				if (_curPage < _pages.length) {
					_text.text = _pages[_curPage];
				}else {
					_done = true;
					kill();
				}
			}
			
			super.update();
		}
	}

}