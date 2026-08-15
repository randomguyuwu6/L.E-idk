package utilities;

import flixel.FlxG;

class MusicUtilities
{
	/**
	 * This function returns the string path of the current music that should be played (as a replacement for the title screen music)
	 */
	public static function getTitleMusic():String
	{
		
		if (FlxG.save.data.myMusic != null)
		{
			return Paths.music(FlxG.save.data.myMusic);
		}

		if (Date.now().getDay() == 5 && Date.now().getHours() >= 18 || Options.getData("nightMusic"))
			return Paths.music('freakyNightMenu');

		return Paths.music('freakyMenu');
	}

	/**
	 * This function returns the string path of the current options menu music.
	 */
	public static inline function getOptionsMusic():String
	{
		return Paths.music('optionsMenu');
	}
}
