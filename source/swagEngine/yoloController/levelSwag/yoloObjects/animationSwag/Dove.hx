package swagEngine.yoloController.levelSwag.yoloObjects.animationSwag ;

import flixel.FlxObject;
import flixel.FlxSprite;
import swagEngine.yoloController.playerSwag.PlayerRenderer;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Dove extends FlxSprite
{
	private var xMovement:Float = 1;
	private var min:Int = 0;
	private var max:Int = 0;
	private var player:PlayerRenderer;
	
	public function new(x:Float = 0, y:Float = 0, a:String, b:String, _player:PlayerRenderer)
	{
		super(x, y);
		
		loadGraphic("assets/animations/dove.png", true, 64, 64);
		
		this.y -= height;
		
		var framesArray = new Array();
		
		for (i in 0...27) framesArray[i] = i;
		
		animation.add("fly", framesArray, 30, true);
		animation.play("fly");
		
		facing = FlxObject.RIGHT;
		
		min = Std.parseInt(a);
		max = Std.parseInt(b);
		
		player = _player;
	}
	
	override public function update(e)
	{		// NEEDS A FIX
		if (xMovement != 0)
		{
			if (x < min * 32) xMovement = 1;
			else if (x > max * 32) xMovement = -1;
			
			velocity.x = xMovement * 64;
		}
		
		if (xMovement == 1) flipX = false;
		else flipX = true;
		
		super.update(e);
	}
}