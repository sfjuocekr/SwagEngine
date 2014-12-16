package swagEngine.yoloController.levelSwag.objects;

import nape.dynamics.InteractionFilter;
import flixel.addons.nape.FlxNapeSprite;
import nape.phys.BodyType;
import flixel.FlxSprite;

/**
* ...
* @author Sjoer van der Ploeg
*/

class Coin extends FlxNapeSprite
{
	public function new(x:Float = 0, y:Float = 0, SimpleGraphic:Dynamic)
	{
		super(x, y, SimpleGraphic);
		
		body.position.x += graphic.width / 2;
		body.position.y -= graphic.height / 2;
		
		body.type = BodyType.KINEMATIC;
		
		body.setShapeFilters(new InteractionFilter(0, 0, 0, 0, 0, 0));
	}	
}