package swagEngine.yoloController.levelSwag.yoloObjects.animationSwag ;

import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */

class Rabbit extends FlxSprite
{

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		
		loadGraphic("assets/animations/rabbit.png", true, 64, 128);
		
		var framesArray = new Array();
		
		for (i in 0...137) framesArray[i] = i;
		
		animation.add("pop", framesArray, 30, true);
		animation.play("pop");
	}
	
}