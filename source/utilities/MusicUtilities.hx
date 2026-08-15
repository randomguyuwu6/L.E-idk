package utilities;

import flixel.FlxG;
#if sys
import sys.FileSystem;
#end

using StringTools;

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

		var menuList:Array<String> = [];

		#if sys
		// Rutas relativas para que funcione en cualquier PC, apuntando directo a tu mod
		var pathsToCheck:Array<String> = [
			"assets/music", // El juego base
			"mods/music" // Por las dudas si en algún momento los ponés en la general
		];

		// Escaneamos las carpetas en el disco duro
		for (folderPath in pathsToCheck)
		{
			if (FileSystem.exists(folderPath) && FileSystem.isDirectory(folderPath))
			{
				for (file in FileSystem.readDirectory(folderPath))
				{
					// Si encuentra un freakyMenu que sea .ogg, lo agrega solo a la lista
					if (file.startsWith("freakyMenu") && file.endsWith(".ogg"))
					{
						var cleanName = file.substr(0, file.length - 4); // Le quita el .ogg
						if (!menuList.contains(cleanName))
						{
							menuList.push(cleanName);
						}
					}
				}
			}
		}
		#end

		// Seguridad por si borrás los archivos por error, usa el base
		if (menuList.length == 0)
		{
			menuList.push("freakyMenu");
		}

		// Elige uno al azar de todos los que encontró
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
