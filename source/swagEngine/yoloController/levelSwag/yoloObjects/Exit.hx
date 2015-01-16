package swagEngine.yoloController.levelSwag.yoloObjects;

import flixel.FlxSprite;

/**
* ...
* @author Sjoer van der Ploeg
*/

class Exit extends FlxSprite
{
	public function new(x:Float = 0, y:Float = 0, SimpleGraphic:Dynamic) 
	{
		super(x, y, SimpleGraphic);
		
		this.y -= height;
		this.exists = false;
	}	
}