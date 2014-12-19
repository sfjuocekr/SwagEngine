package swagEngine.yoloController.levelSwag.objects;

import flixel.addons.nape.FlxNapeSprite;
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
		super(x, y, SimpleGraphic);
		
		body.position.x += graphic.width / 2;
		body.position.y -= graphic.height / 2;
		
		body.type = BodyType.KINEMATIC;
		
		body.shapes.pop();
		
		body.shapes.add(new Polygon(Polygon.rect(-width / 2, -height / 2 + 0.1, 1, 3.9), new Material(0, 0, 0, 1, 0))); // TOPLEFT
		body.shapes.add(new Polygon(Polygon.rect(-width / 2 + 1, -height / 2, width - 2, 4), new Material(0, 1, 0, 1, 0))); // TOP
		body.shapes.add(new Polygon(Polygon.rect(width / 2 - 1, -height / 2 + 0.1, 1, 3.9), new Material(0, 0, 0, 1, 0))); // TOPRIGHT
		body.shapes.add(new Polygon(Polygon.rect(-width / 2, -height / 2 + 4, width, height - 4), new Material(0, 0, 0, 1, 0))); // REST
		
		body.setShapeFilters(new InteractionFilter(1, -1, 0, 0, 0, 0));
		body.type = BodyType.KINEMATIC;
		
		if (axis) yMovement = 1;
		else xMovement = 1;
		
		min = Std.parseInt(a);
		max = Std.parseInt(b);
	}
	
	override public function update (elapsed:Float)
	{
		if (xMovement != 0)
		{
			if (body.position.x < min * 32 + width / 2) xMovement = 1;
			else if (body.position.x > max * 32 + width / 2) xMovement = -1;
		
			body.velocity.x = xMovement * 64;
		}
		
		if (yMovement != 0)
		{
			if (body.position.y < (min * 32) + height / 2) yMovement = 1;
			else if (body.position.y > (max * 32) + height / 2) yMovement = -1;
			
			body.velocity.y = yMovement * 64;
		}
		
		super.update(FlxG.elapsed);
	}
}