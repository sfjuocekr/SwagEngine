package swagEngine.yoloController.levelSwag.yoloObjects ;

import flixel.FlxSprite;
import flixel.addons.effects.FlxWaveSprite;

/**
* ...
* @author Sjoer van der Ploeg
*/

class Card extends FlxSprite
{
	public function new(x:Float = 0, y:Float = 0, SimpleGraphic:Dynamic)
	{
		super(x, y, SimpleGraphic);
		
		this.y -= height;
	}	
}