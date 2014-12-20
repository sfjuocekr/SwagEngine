package swagEngine.yoloController.levelSwag.yoloObjects.animationSwag ;

import nape.dynamics.InteractionFilter;
import nape.phys.BodyType;
import flixel.addons.nape.FlxNapeSprite;
import flixel.FlxG;
import flixel.FlxObject;

/**
 * ...
 * @author ...
 */

class Dove extends FlxNapeSprite
{
	private var xMovement:Float = 1;
	
	override public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		
		this.loadGraphic("assets/animations/dove.png", true, 64, 64);
		
		this.body.type = BodyType.KINEMATIC;
		this.body.setShapeFilters(new InteractionFilter(1, -1, 0, 0, 0, 0));
		
		var framesArray = new Array();
		
		for (i in 0...27) framesArray[i] = i;
		
		this.animation.add("fly", framesArray, 30, true);
		this.animation.play("fly");
		
		this.facing = FlxObject.RIGHT;
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