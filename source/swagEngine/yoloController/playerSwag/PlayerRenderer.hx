package swagEngine.yoloController.playerSwag;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import openfl.events.TimerEvent;
import openfl.utils.Timer;
import swagEngine.swagHandler.Settings;
import flixel.group.FlxGroup;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class PlayerRenderer extends FlxSprite
{
	private var timer:Timer = new Timer(1000);
	public var portalTimer:Timer = new Timer(100);
	
	public var abilities:AbilityManager;
	
	public var portaling:Bool = false;
	
	public function new(_x:Float = 0, _y:Float = 0, _shots:FlxGroup)
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
		
		drag.x = Settings.drag * 2;
		drag.y = Settings.drag;
		
		//acceleration.y = 0;
		acceleration.y = Settings.acceleration;
		acceleration.x = 0;
		
		maxVelocity.x = Settings.maxVelocity;
		maxVelocity.y = Settings.maxVelocity * 2;
		
		abilities = new AbilityManager(this, _shots);
		
		animation.play("resting");
		
		timer.addEventListener(TimerEvent.TIMER, healthUp);
		timer.start();
		
		portalTimer.addEventListener(TimerEvent.TIMER, didPortal);
	}
	
	private function healthUp(e)
	{
		if (health < 990) health += 10;
		else if (health >= 990) health = 1000;
	}
	
	private function didPortal(e)
	{
		portalTimer.stop();
		
		portaling = false;
	}
	
	override public function update(e:Float)
	{
		//health = 1000;
		//for (i in 0...abilities.cards.energy.length)
		//	abilities.cards.energy[i] = 1;
		
		if (e == 0 || portaling) return;
		
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
			facing = FlxObject.LEFT;
			
			velocity.x -= 100;
			animation.play("walking");
		}
		else if (FlxG.keys.pressed.RIGHT)
		{
			flipX = false;
			facing = FlxObject.RIGHT;
			
			velocity.x += 100;
			animation.play("walking");
		}
		else animation.play("resting");
		
		
		// ROTATE CARDS
		if (FlxG.keys.justPressed.Q)
			abilities.rotate(0);
			
		if (FlxG.keys.justPressed.W)
			abilities.rotate(1);
			
		if (FlxG.keys.justPressed.E)
			abilities.rotate(2);
			
		if (FlxG.keys.justPressed.R)		// Probably useless will never rotate spades
			abilities.rotate(3);
		
		
		// USE ABILITY
		if (FlxG.keys.justPressed.A)
			abilities.diamonds();
			
		if (FlxG.keys.justPressed.S)
			abilities.clubs();
			
		if (FlxG.keys.justPressed.D)
			abilities.hearts();
			
		if (FlxG.keys.justPressed.F)		// Probably useless space = spades
			abilities.spades();
		
		if (FlxG.keys.justPressed.I)
		{
			animation.curAnim.frameRate++;
			trace(animation.curAnim.frameRate);
		}
		else if (FlxG.keys.justPressed.K)
		{
			animation.curAnim.frameRate--;
			trace(animation.curAnim.frameRate);
		}
		
		super.update(e);
	}
	
	override public function destroy()
	{
		abilities.destroy();
		
		portaling = false;
		
		portalTimer.removeEventListener(TimerEvent.TIMER, didPortal);
		portalTimer = null;
		
		super.destroy();
	}
}