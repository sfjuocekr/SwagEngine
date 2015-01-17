package swagEngine.yoloController.levelSwag.yoloObjects.animationSwag ;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import swagEngine.yoloController.playerSwag.PlayerRenderer;
import swagEngine.yoloController.levelSwag.yoloObjects.behavior.BirdBehavior;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Dove extends FlxSprite
{
	private var behavior:BirdBehavior;
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
		player = _player;
		
		drag.x = drag.y = 2000;
		
		maxVelocity.x = maxVelocity.y = 300;
		
		behavior = new BirdBehavior(type, this, player, Std.parseInt(_min), Std.parseInt(_max));
	}
	
	override public function destroy()
	{
		behavior.destroy();
		
		behavior = null;
		player = null;
		type = null;
		
		super.destroy();
	}
	
	override public function update(e)
	{
		if (e == 0.0) return;
		
		behavior.type = type;
		behavior.update();
		
		if 		(overlaps(player) && player.abilities.cards.cardEnergy[2] >  0) player.abilities.cards.cardEnergy[2]--;
		else if (overlaps(player) && player.abilities.cards.cardEnergy[2] == 0)	player.hurt(10);
		
		if (velocity.x > 0) flipX = false;
		else flipX = true;
		
		super.update(e);
	}
}