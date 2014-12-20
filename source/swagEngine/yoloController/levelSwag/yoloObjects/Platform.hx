package swagEngine.yoloController.levelSwag.yoloObjects ;

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
		
		//body.position.x += graphic.width * 0.5;
		//body.position.y -= graphic.height * 0.5;
		
		this.body.type = BodyType.KINEMATIC;
		
		this.body.shapes.pop();
		
		this.body.shapes.add(new Polygon(Polygon.rect(-this.width * 0.5, -this.height * 0.5 + 0.1, 1, 3.9), new Material(0, 0, 0, 1, 0))); // TOPLEFT
		this.body.shapes.add(new Polygon(Polygon.rect(-this.width * 0.5 + 1, -this.height * 0.5, this.width - 2, 4), new Material(0, 1, 0, 1, 0))); // TOP
		this.body.shapes.add(new Polygon(Polygon.rect(this.width * 0.5 - 1, -this.height * 0.5 + 0.1, 1, 3.9), new Material(0, 0, 0, 1, 0))); // TOPRIGHT
		this.body.shapes.add(new Polygon(Polygon.rect(-this.width * 0.5, -this.height * 0.5 + 4, this.width, this.height - 4), new Material(0, 0, 0, 1, 0))); // REST
		
		this.body.setShapeFilters(new InteractionFilter(1, -1, 0, 0, 0, 0));
		this.body.type = BodyType.KINEMATIC;
		
		if (axis) this.yMovement = 1;
		else this.xMovement = 1;
		
		this.min = Std.parseInt(a);
		this.max = Std.parseInt(b);
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