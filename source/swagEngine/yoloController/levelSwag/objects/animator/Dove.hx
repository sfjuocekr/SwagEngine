package swagEngine.yoloController.levelSwag.objects.animator;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

/**
 * ...
 * @author ...
 */

class Dove extends FlxSprite
{
	private var xMovement:Float = 1;
	
	override public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		
		loadGraphic("assets/animations/dove.png", true, 64, 64);
		
		var framesArray = new Array();
		
		for (i in 0...27) framesArray[i] = i;
		
		animation.add("fly", framesArray, 30, true);
		animation.play("fly");
		
		facing = FlxObject.RIGHT;
	}
	
	override public function update(elapsed:Float)
	{
		if (x < 1 * 32 + width / 2) xMovement = 1;
		else if (x > 8 * 32 + width / 2) xMovement = -1;
		
		velocity.x = xMovement * 64;
		
		if (xMovement == 1) flipX = false;
		else flipX = true;
		
		super.update(FlxG.elapsed);
	}
}