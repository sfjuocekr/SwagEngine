package swagEngine.yoloController.levelSwag.yoloObjects ;

import flixel.group.FlxGroup;
import swagEngine.yoloController.levelSwag.yoloObjects.animationSwag.*;
import flixel.FlxSprite;
import swagEngine.yoloController.playerSwag.PlayerRenderer;

/**
 * ...
 * @author ...
 */

class Enemy extends FlxGroup
{
	public function new(x:Float, y:Float, yolo:String, ?a:Int, ?b:Int, ?player:PlayerRenderer)
	{
		super();
		
		switch (yolo)
		{
			case "bird":
				add(new Dove(x, y, Std.string(a), Std.string(b), player));
			
			case "rabbit":
				add(new Rabbit(x, y));
		}
	}
}