package swagEngine.yoloController.playerSwag;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class PlayerRenderer extends FlxSprite
{
	public var abilities:AbilityManager;
	
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
		
		maxVelocity.x = 250;
		maxVelocity.y = 500;
		
		abilities = new AbilityManager(this);
		
		animation.play("resting");
	}
	
	override public function update(e)
	{
		if (e == 0.0) return;
		
		acceleration.x = 0;
		
		if (FlxG.keys.justPressed.UP)
		{
			abilities.spades();
		}
		else if (FlxG.keys.justPressed.DOWN)
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
		else animation.play("resting");
		
		
		// ROTATE CARDS
		if (FlxG.keys.justPressed.Q)
			abilities.cards.rotate(0);
			
		if (FlxG.keys.justPressed.W)
			abilities.cards.rotate(1);
			
		if (FlxG.keys.justPressed.E)
			abilities.cards.rotate(2);
			
		//if (FlxG.keys.justPressed.R)		// Probably useless will never rotate spades
		//	abilities.cards.rotate(3);
		
		
		// USE ABILITY
		if (FlxG.keys.justPressed.A)
			abilities.diamonds();
			
		if (FlxG.keys.justPressed.S)
			abilities.clubs();
			
		if (FlxG.keys.justPressed.D)
			abilities.hearths();
			
		//if (FlxG.keys.justPressed.F)		// Probably useless space = spades
		//	abilities.spades();
		
		trace(abilities.cards.cardEnergy);
		trace(abilities.cards.cardSlots);
		
		super.update(e);	
	}
	
	override public function destroy()
	{
		abilities.destroy();
		
		super.destroy();
	}
}