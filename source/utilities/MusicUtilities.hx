package utilities;

import flixel.FlxG;
import openfl.utils.Assets;

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

		// --- DYNAMIC AUTOMATIC DETECTION ---
		var menuList:Array<String> = [];

		// 1. Add the original freakyMenu if it exists in the assets
		if (Assets.exists(Paths.music("freakyMenu")))
		{
			menuList.push("freakyMenu");
		}

		// 2. Automatically search for all numbered variants (freakyMenu2, freakyMenu3, freakyMenu4...)
		var i:Int = 2;
		while (true)
		{
			var testName = "freakyMenu" + i;
			if (Assets.exists(Paths.music(testName)))
			{
				menuList.push(testName);
				i++;
			}
			else
			{
				break; // Stops when sequential numbering ends
			}
		}

		// Fallback to default if no menus were found
		if (menuList.length == 0)
		{
			menuList.push("freakyMenu");
		}

		// Pick one randomly from the pool (including the original and custom ones)
		FlxG.save.data.myMusic = FlxG.random.getObject(menuList);
		FlxG.save.flush();

		if (Date.now().getDay() == 5 && Date.now().getHours() >= 18 || Options.getData("nightMusic"))
			return Paths.music('freakyNightMenu');

		return Paths.music(FlxG.save.data.myMusic);
	}

	/**
	 * This function returns the string path of the current options menu music.
	 */
	public static inline function getOptionsMusic():String
	{
		return Paths.music('optionsMenu');
	}
}
