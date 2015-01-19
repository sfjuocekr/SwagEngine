package swagEngine.yoloController.levelSwag;

import flash.display.BitmapData;
import flash.display.Sprite;
import flixel.FlxSprite;
import format.SVG;
import openfl.Assets;

/**
 * ...
 * @author ...
 */

class Fireball extends FlxSprite
{
	public function new(_x:Float=0, _y:Float=0) 
	{
		super(0, 0);
		
		frameWidth = 128;
		frameWidth = 64;
		
		pixels = getBitmapFromSvg("assets/images/Fireball.svg", 0, 0, 128, 64);
	}
	
	public function getBitmapFromSvg(id:String, X:Int = 0, Y:Float = 0, Width:Int = -1, Height:Int = -1):BitmapData
	{
		var svgText:String = Assets.getText(id);
		var svg:SVG = new SVG(svgText);
		var spr:Sprite = new Sprite();
		svg.render(spr.graphics, X, Y, Width, Height);
		var bd:BitmapData = new BitmapData(Std.int(spr.width),Std.int(spr.height),true, 0x0);
		bd.draw(spr);
		return bd;
	}
}