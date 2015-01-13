package swagEngine.yoloController.levelSwag.yoloObjects ;

import nape.dynamics.InteractionFilter;
import flixel.addons.nape.FlxNapeSprite;
import nape.phys.BodyType;
import flixel.FlxSprite;
import flixel.addons.effects.FlxWaveSprite;

/**
* ...
* @author Sjoer van der Ploeg
*/

class Card extends FlxNapeSprite
{
	public function new(x:Float = 0, y:Float = 0, SimpleGraphic:Dynamic)
	{
		super(x, y, null, false, false);
		
		loadGraphic(SimpleGraphic);
		
		createRectangularBody(width, height, BodyType.KINEMATIC);
		physicsEnabled = true;
		
		body.setShapeFilters(new InteractionFilter(0, 0, 0, 0, 0, 0));
	}	
}