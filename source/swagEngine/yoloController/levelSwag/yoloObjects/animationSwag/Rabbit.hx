package swagEngine.yoloController.levelSwag.yoloObjects.animationSwag ;

import nape.dynamics.InteractionFilter;
import nape.phys.BodyType;
import flixel.addons.nape.FlxNapeSprite;

/**
 * ...
 * @author ...
 */

class Rabbit extends FlxNapeSprite
{

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		
		this.loadGraphic("assets/animations/rabbit.png", true, 64, 128);
		
		this.body.type = BodyType.KINEMATIC;
		this.body.setShapeFilters(new InteractionFilter(1, -1, 0, 0, 0, 0));
		
		var framesArray = new Array();
		
		for (i in 0...137) framesArray[i] = i;
		
		this.animation.add("pop", framesArray, 30, true);
		this.animation.play("pop");
	}
}