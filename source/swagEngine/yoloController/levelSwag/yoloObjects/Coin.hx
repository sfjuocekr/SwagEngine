package swagEngine.yoloController.levelSwag.yoloObjects ;

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
	public function new(x:Float = 0, y:Float = 0, ?SimpleGraphic:Dynamic)
	{
		super(x, y, SimpleGraphic);
		
		//this.body.position.x += graphic.width * 0.5;
		//this.body.position.y -= graphic.height * 0.5;
		
		this.body.type = BodyType.KINEMATIC;
		
		this.body.setShapeFilters(new InteractionFilter(0, 0, 0, 0, 0, 0));
	}	
}