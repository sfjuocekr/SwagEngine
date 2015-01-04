package swagEngine.swagHandler ;

import flixel.util.FlxSave;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Settings
{
	public static var gameWidth:Int = 1280;
	public static var gameHeight:Int = 736;
	public static var zoom:Int = 1;
	public static var levels:Array<Int> = [0, 1];
	public static var level:Int = 0;
	public static var saves:Array<FlxSave> = new Array();
	public static var fullscreen:Bool = false;
	public static var tileSize:Int = 16;
}