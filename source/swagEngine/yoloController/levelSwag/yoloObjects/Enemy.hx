package swagEngine.yoloController.levelSwag.yoloObjects ;

import flixel.addons.nape.FlxNapeSprite;
import flixel.group.FlxGroup;
import swagEngine.yoloController.levelSwag.yoloObjects.animationSwag.*;

/**
 * ...
 * @author ...
 */

class Enemy extends FlxGroup
{
	public function new(x:Float, y:Float, yolo:String)
	{
		super();
		
		switch (yolo)
		{
			case "bird":
				add(new Dove(x, y));
			
			case "rabbit":
				add(new Rabbit(x, y));
		}
	}
}