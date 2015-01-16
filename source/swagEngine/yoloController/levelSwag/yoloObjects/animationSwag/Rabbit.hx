package swagEngine.yoloController.levelSwag.yoloObjects.animationSwag ;

import flixel.FlxSprite;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Rabbit extends FlxSprite
{

	public function new(_x:Float = 0, _y:Float = 0)
	{
		super(_x, _y);
		
		loadGraphic("assets/animations/rabbit.png", true, 64, 128);
		
		y -= height;
		
		var framesArray = new Array();
			for (i in 0...137) framesArray[i] = i;
		
		animation.add("pop", framesArray, 30, true);
		animation.play("pop");
	}
}