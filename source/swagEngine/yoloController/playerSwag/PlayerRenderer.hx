package swagEngine.yoloController.playerSwag;

import flixel.addons.nape.FlxNapeSprite;
import flixel.FlxG;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Polygon;
import nape.dynamics.InteractionFilter;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class PlayerRenderer extends FlxNapeSprite
{
	private var controller:PlayerController;
	
	private function init()
	{
		body.type = BodyType.DYNAMIC;
		body.setShapeFilters(new InteractionFilter(1, -1, 0, 0, 0, 0));
		
		body.shapes.pop();
		body.shapes.add(new Polygon(Polygon.rect(-width / 2 + 4, -width, width - 8, height - 4), new Material(0, 0, 0, .25, 0))); // BODY
		body.shapes.add(new Polygon(Polygon.rect(-width / 2, -width, 4, height - 4), new Material(0, 0, 0, .25, 0))); // LEFT
		body.shapes.add(new Polygon(Polygon.rect(width / 2 - 4, -width, 4, height - 4), new Material(0, 0, 0, .25, 0))); // RIGHT
		body.shapes.add(new Polygon(Polygon.rect(-width / 2 + 1, width -4, width - 2, 4), new Material(0, 1, 0, .25, 0))); // FEET
		
		body.allowRotation = false;
	}
	
	public function new(X:Float = 0, Y:Float = 0, SimpleGraphic:Dynamic, CreateRectangularBody:Bool = true, EnablePhysics:Bool = true)
	{
		super(X, Y, SimpleGraphic);
		
		FlxG.camera.follow(this);
		
		init();
		
		controller = new PlayerController(this);
	}
	
	override public function update(elapsed:Float)
	{
		controller.update();
		
		if (body.velocity.x > 200 && body.velocity.x > 10) body.velocity.x = 200;
		else if (body.velocity.x < -200 && body.velocity.x < -10) body.velocity.x = -200;
		
		if (!(FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT) && body.velocity.x != 0) body.velocity.x *= 0.95;
		
		super.update(FlxG.elapsed);
	}
}