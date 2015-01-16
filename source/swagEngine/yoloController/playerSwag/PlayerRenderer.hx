package swagEngine.yoloController.playerSwag;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import openfl.events.TimerEvent;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class PlayerRenderer extends FlxSprite
{
	public var scaled:Bool = false;
	
	private var walkingArray = new Array();
	private var restingArray = new Array();
	private var abilities:AbilityManager;
	
	public function new(_x:Float = 0, _y:Float = 0)
	{
		super(_x, _y);
		
		loadGraphic("assets/animations/player.png", true, 64, 128);
		
		x -= width * 0.25;
		y -= height;
		
		var framesArray = new Array();
			for (i in 0...19)
				framesArray[i] = i;
		animation.add("walking", framesArray, 30, true);
		
		var framesArray = new Array();
			for (i in 20...33)
				framesArray[i - 20] = i;
		animation.add("resting", framesArray, 5, true);
		
		facing = FlxObject.RIGHT;
		
		collisonXDrag = true;
		solid = true;
		
		drag.x = 2000;
		drag.y = 1000;
		
		//acceleration.y = 0;
		acceleration.y = 1000;
		acceleration.x = 0;
		
		maxVelocity.x = 200;
		maxVelocity.y = 1000;
		
		abilities = new AbilityManager(this);
		
		animation.play("resting");
	}
	
	override public function update(e)
	{
		acceleration.x = 0;
		
		if (FlxG.keys.justPressed.UP)
		{
			velocity.y -= scaled ? 500 : 400;
		}
		else if (FlxG.keys.justPressed.DOWN && !scaled)
		{
			velocity.y += 100;
		}
		
		if (FlxG.keys.pressed.LEFT)
		{
			flipX = true;
			velocity.x -= 100;
			animation.play("walking");
		}
		else if (FlxG.keys.pressed.RIGHT)
		{
			flipX = false;
			velocity.x += 100;
			animation.play("walking");
		}
		else { animation.play("resting"); }
		
		if (FlxG.keys.justPressed.Q)
			abilities.rotate(0);
			
		if (FlxG.keys.justPressed.W)
			abilities.rotate(1);
			
		if (FlxG.keys.justPressed.E)
			abilities.rotate(2);
			
		if (FlxG.keys.justPressed.R)
			abilities.rotate(3);
		
		if (FlxG.keys.justPressed.A)
			abilities.diamonds();
			
		if (FlxG.keys.justPressed.S)
			abilities.clubs();
			
		if (FlxG.keys.justPressed.D)
			abilities.hearths();
			
		if (FlxG.keys.justPressed.F)
			abilities.spades();
			
		super.update(e);	
	}
	
	override public function destroy()
	{
		abilities.destroy();
		
		super.destroy();
	}
}