package swagEngine.yoloController.levelSwag.yoloObjects.animationSwag ;

import flixel.addons.nape.FlxNapeSprite;
import flixel.FlxG;
import flixel.FlxObject;
import nape.dynamics.InteractionFilter;
import nape.phys.Body;
import nape.phys.BodyType;

/**
 * ...
 * @author ...
 */

class Dove extends FlxNapeSprite
{
	private var xMovement:Float = 1;
	private var min:Int = 0;
	private var max:Int = 0;
	
	public function new(x:Float = 0, y:Float = 0, a:String, b:String)
	{
		super(x, y, null, false, false);
		
		loadGraphic("assets/animations/dove.png", true, 64, 64);
		
		body = new Body(BodyType.KINEMATIC);
		body.position.setxy(x, y);
		
		body.setShapeFilters(new InteractionFilter(1, -1, 0, 0, 0, 0));
		
		var framesArray = new Array();
		
		for (i in 0...27) framesArray[i] = i;
		
		animation.add("fly", framesArray, 30, true);
		animation.play("fly");
		
		facing = FlxObject.RIGHT;
		
		min = Std.parseInt(a);
		max = Std.parseInt(b);
	}
	
	override public function update(elapsed:Float)
	{
		if (body.position.x < 1 * 32 + width * 0.5) xMovement = 1;
		else if (body.position.x > 8 * 32 + width * 0.5) xMovement = -1;
		
		body.velocity.x = xMovement * 64;
		
		if (xMovement == 1) flipX = false;
		else flipX = true;
		
		super.update(FlxG.elapsed);
	}
}