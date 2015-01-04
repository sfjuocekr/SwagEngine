package swagEngine.yoloController.playerSwag;

import flixel.addons.nape.FlxNapeSprite;
import flixel.FlxG;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Polygon;
import nape.dynamics.InteractionFilter;
import flixel.FlxObject;
import flixel.addons.nape.FlxNapeSpace;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class PlayerRenderer extends FlxNapeSprite
{
	private var controller:PlayerController;
	public var cards:CardManager;
	
	public function new(x:Float = 0, y:Float = 0, SimpleGraphic:Dynamic)
	{
		super(x, y, SimpleGraphic, false, false);
		
		body = new Body(BodyType.DYNAMIC);
		body.position.setxy(x, y);
		
		body.shapes.add(new Polygon(Polygon.rect(-width * 0.5,		-height * 0.5,			width, 		height - 2), 		new Material(0, 0, 0, 1, 0))); 		// BODY
		body.shapes.add(new Polygon(Polygon.rect(-width * 0.5,		 height * 0.5 - 2,		width, 				 2),		new Material(0, 0.1, 0, 1, 0))); // FEET
		
		body.allowRotation = false;
		body.setShapeFilters(new InteractionFilter(1, -1, 0, 0, 0, 0));
		physicsEnabled = true;
		
		facing = FlxObject.RIGHT;
		
		controller = new PlayerController(this);
		cards = new CardManager();
	}
	
	override public function update(elapsed:Float)
	{		
		controller.update();
		
		if (body.velocity.x > 300 && body.velocity.x > 10) body.velocity.x = 300;
		else if (body.velocity.x < -300 && body.velocity.x < -10) body.velocity.x = -300;
		
		if (!(FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT) && body.velocity.x != 0) body.velocity.x *= 0.9;
		
		super.update(FlxG.elapsed);	
	}
}