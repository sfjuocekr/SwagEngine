package swagEngine.yoloController.levelSwag.yoloObjects.animationSwag ;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import swagEngine.yoloController.playerSwag.PlayerRenderer;
import swagEngine.yoloController.levelSwag.yoloObjects.EnemyBehavior;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Dove extends FlxSprite
{
	private var behavior:EnemyBehavior;
	private var player:PlayerRenderer;
	
	public var type:String;
	
	public function new(_x:Float = 0, _y:Float = 0, _min:String, _max:String, _player:PlayerRenderer, _type:String)
	{
		super(_x, _y);
		
		loadGraphic("assets/animations/dove.png", true, 64, 64);
		y -= height;
		
		var framesArray = new Array();
			for (i in 0...27) framesArray[i] = i;
		
		animation.add("fly", framesArray, 30, true);
		animation.play("fly");
		
		facing = FlxObject.RIGHT;
		
		type = _type;
		
		drag.x = 1000;
		drag.y = 1000;
		
		maxVelocity.x = 200;
		maxVelocity.y = 200;
		
		player = _player;
		
		behavior = new EnemyBehavior(type, this, player, Std.parseInt(_min), Std.parseInt(_max));
	}
	
	override public function update(e)
	{
		behavior.type = type;
		behavior.update();
		
		if (overlaps(player)) player.hurt(10);
		
		if (velocity.x > 0) flipX = false;
		else flipX = true;
		
		super.update(e);
	}
}