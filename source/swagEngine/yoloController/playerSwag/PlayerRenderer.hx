package swagEngine.yoloController.playerSwag;

import flixel.addons.nape.FlxNapeSprite;
import flixel.FlxG;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Polygon;
import nape.dynamics.InteractionFilter;
import flixel.FlxObject;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class PlayerRenderer extends FlxNapeSprite
{
	private var controller:PlayerController;
	public var cards:CardManager;
	
	private function init()
	{
		body.type = BodyType.DYNAMIC;
		body.setShapeFilters(new InteractionFilter(1, -1, 0, 0, 0, 0));
		
		body.shapes.pop();
		body.shapes.add(new Polygon(Polygon.rect(-width * 0.5 + 4, -width, width - 8, height - 4), new Material(0, 0, 0, .25, 0))); // BODY
		body.shapes.add(new Polygon(Polygon.rect(-width * 0.5, -width, 4, height - 4), new Material(0, 0, 0, .25, 0))); // LEFT
		body.shapes.add(new Polygon(Polygon.rect(width * 0.5 - 4, -width, 4, height - 4), new Material(0, 0, 0, .25, 0))); // RIGHT
		body.shapes.add(new Polygon(Polygon.rect(-width * 0.5, width - 4, 1, 4), new Material(0, 1, 0, .25, 0))); // FEETLEFT
		body.shapes.add(new Polygon(Polygon.rect(-width * 0.5 + 1, width - 4, width - 2, 4), new Material(0, 1, 0, .25, 0))); // FEET
		body.shapes.add(new Polygon(Polygon.rect(width * 0.5 - 1, width - 4, 1, 4), new Material(0, 1, 0, .25, 0))); // RIGHTLEFT
		
		body.allowRotation = false;
		
		facing = FlxObject.RIGHT;
	}
	
	override public function new(x:Float = 0, y:Float = 0, SimpleGraphic:Dynamic)
	{
		super(x, y, SimpleGraphic);
		
		init();
		
		controller = new PlayerController(this);
		cards = new CardManager();
	}
	
	override public function update(elapsed:Float)
	{
        if(this != null && body != null)
        {
            x = body.position.x;
            y = body.position.y;
            angle = body.rotation;
        }
		
		controller.update();
		
		if (body.velocity.x > 200 && body.velocity.x > 10) body.velocity.x = 200;
		else if (body.velocity.x < -200 && body.velocity.x < -10) body.velocity.x = -200;
		
		if (!(FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT) && body.velocity.x != 0) body.velocity.x *= 0.95;
		
		super.update(FlxG.elapsed);
	}
}