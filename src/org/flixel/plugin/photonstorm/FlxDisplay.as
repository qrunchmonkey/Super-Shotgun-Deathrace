/**
 * FlxDisplay
 * -- Part of the Flixel Power Tools set
 * 
 * Updated for the Flixel 2.5 Plugin system
 * 
 * @version 1.1 - May 23rd 2011
 * @link http://www.photonstorm.com
 * @author Richard Davey / Photon Storm
*/

package org.flixel.plugin.photonstorm 
{
	import org.flixel.*;
	
	public class FlxDisplay 
	{
		
		public function FlxDisplay() 
		{
		}
		
		/**
		 * Centers the given FlxSprite on the screen, either by the X axis, Y axis, or both
		 * 
		 * @param	source	The FlxSprite to center
		 * @param	xAxis	Boolean true if you want it centered on X (i.e. in the middle of the screen)
		 * @param	yAxis	Boolean	true if you want it centered on Y
		 * 
		 * @return	The FlxSprite for chaining
		 */
		public static function screenCenter(source:FlxSprite, xAxis:Boolean = true, yAxis:Boolean = false):FlxSprite
		{
			if (xAxis)
			{
				source.x = (FlxG.width / 2) - (source.width / 2);
			}
			
			if (yAxis)
			{
				source.y = (FlxG.height / 2) - (source.height / 2);
			}

			return source;
		}
		
		// TODO: Flip, Mirror, Expand, Contract
		
	}

}