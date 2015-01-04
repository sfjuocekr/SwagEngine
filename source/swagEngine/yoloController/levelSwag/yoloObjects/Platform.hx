package swagEngine.yoloController.levelSwag.yoloObjects ;

import flixel.addons.nape.FlxNapeSprite;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Polygon;
import flixel.FlxG;
import nape.dynamics.InteractionFilter;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Platform extends FlxNapeSprite
{
	private var min:Int = 0;
	private var max:Int = 0;
	private var xMovement:Float = 0;
	private var yMovement:Float = 0;
	
	public function new(x:Float = 0, y:Float = 0, SimpleGraphic:Dynamic, a:String, b:String, axis:Bool)
	{
		super(x, y, SimpleGraphic, false, false);
		
		body = new Body(BodyType.KINEMATIC);
		body.position.setxy(x, y);
		
		body.shapes.add(new Polygon(Polygon.rect(-width * 0.5,		-height * 0.5,			width,				2),						new Material(0, 0.15, 0.1, 1, 0)));		// TOP
		body.shapes.add(new Polygon(Polygon.rect(-width * 0.5, 		-height * 0.5 + 2,		width,				height - 2),			new Material(0, 0, 0, 1, 0))); 			// BOTTOM
		
		body.setShapeFilters(new InteractionFilter(1, -1, 0, 0, 0, 0));
		physicsEnabled = true;
		
		if (axis) yMovement = 1;
		else xMovement = 1;
		
		min = Std.parseInt(a);
		max = Std.parseInt(b);
	}
	
	override public function update (elapsed:Float)
	{
		if (xMovement != 0)
		{
			if (body.position.x < min * 32 + width * 0.5) xMovement = 1;
			else if (body.position.x > max * 32 + width * 0.5) xMovement = -1;
		
			body.velocity.x = xMovement * 64;
		}
		
		if (yMovement != 0)
		{
			if (body.position.y < (min * 32) + height * 0.5) yMovement = 1;
			else if (body.position.y > (max * 32) + height * 0.5) yMovement = -1;
			
			body.velocity.y = yMovement * 64;
		}
		
		super.update(FlxG.elapsed);
	}
}