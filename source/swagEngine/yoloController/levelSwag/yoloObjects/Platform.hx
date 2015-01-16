package swagEngine.yoloController.levelSwag.yoloObjects ;

import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Platform extends FlxSprite
{
	private var min:Int = 0;
	private var max:Int = 0;
	private var xMovement:Float = 0;
	private var yMovement:Float = 0;
	
	public function new(x:Float = 0, y:Float = 0, SimpleGraphic:Dynamic, a:String, b:String, axis:Bool)
	{
		super(x, y, SimpleGraphic);
		
		this.y -= height;
		
		if (axis) yMovement = 1;
		else xMovement = 1;
		
		
		min = Std.parseInt(a);
		max = Std.parseInt(b);
		
		collisonXDrag = false;
		immovable = true;
	}
	
	override public function update(e)
	{
		if (xMovement != 0)
		{
			if (x < min * 32) xMovement = 1;
			else if (x > max * 32) xMovement = -1;
			
			velocity.x = xMovement * 64;
		}
		
		if (yMovement != 0)
		{
			if (y < min * 32) yMovement = 1;
			else if (y > max * 32) yMovement = -1;
			
			velocity.y = yMovement * 64;
		}
		
		super.update(e);
	}
}