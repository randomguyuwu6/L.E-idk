package utilities;

import flixel.FlxG;
#if sys
import sys.FileSystem;
#end

using StringTools;

class MusicUtilities
{
	// Variable de sesión: se mantiene fija mientras jugás (para que no se reinicie al dar Enter),
	// pero se reinicia sola cada vez que cerrás y volvés a abrir el juego para elegir otro al azar.
	public static var currentMusic:String = null;

	/**
	 * This function returns the string path of the current music that should be played (as a replacement for the title screen music)
	 */
	public static function getTitleMusic():String
	{
		// Si ya se eligió una música en esta sesión, la mantenemos sonando sin reiniciar
		if (currentMusic != null)
		{
			return Paths.music(currentMusic);
		}

		var menuList:Array<String> = [];

		#if sys
		// Rutas donde buscará automáticamente los archivos reales en tu PC
		var pathsToCheck:Array<String> = [
			"assets/music",
			"mods/music"
		];

		// Escaneamos el disco duro en busca de los freakyMenu que realmente existan hoy
		for (folderPath in pathsToCheck)
		{
			if (FileSystem.exists(folderPath) && FileSystem.isDirectory(folderPath))
			{
				for (file in FileSystem.readDirectory(folderPath))
				{
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

		// Seguridad por si no encuentra ninguno
		if (menuList.length == 0)
		{
			menuList.push("freakyMenu");
		}

		// Elige uno al azar exclusivamente entre los archivos que SÍ existen en la carpeta
		currentMusic = FlxG.random.getObject(menuList);

		if (Date.now().getDay() == 5 && Date.now().getHours() >= 18 || Options.getData("nightMusic"))
			return Paths.music('freakyNightMenu');

		return Paths.music(currentMusic);
	}

	/**
	 * This function returns the string path of the current options menu music.
	 */
	public static inline function getOptionsMusic():String
	{
		return Paths.music('optionsMenu');
	}
}
