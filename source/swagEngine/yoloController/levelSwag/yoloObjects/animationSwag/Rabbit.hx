package swagEngine.yoloController.levelSwag.yoloObjects.animationSwag ;

import flixel.addons.nape.FlxNapeSprite;
import nape.dynamics.InteractionFilter;
import nape.phys.Body;
import nape.phys.BodyType;

/**
 * ...
 * @author ...
 */

class Rabbit extends FlxNapeSprite
{

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y, null, false, false);
		
		loadGraphic("assets/animations/rabbit.png", true, 64, 128);
		
		body = new Body(BodyType.KINEMATIC);
		body.position.setxy(x, y);
		
		body.setShapeFilters(new InteractionFilter(1, -1, 0, 0, 0, 0));
		
		var framesArray = new Array();
		
		for (i in 0...137) framesArray[i] = i;
		
		animation.add("pop", framesArray, 30, true);
		animation.play("pop");
	}
}