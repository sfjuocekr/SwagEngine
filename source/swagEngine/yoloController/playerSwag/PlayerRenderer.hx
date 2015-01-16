package swagEngine.yoloController.playerSwag;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class PlayerRenderer extends FlxSprite
{
	public var scaled:Bool = false;
	public var cards:CardManager;
	private var timer:Timer = new Timer(5000);
	private var walkingArray = new Array();
	private var restingArray = new Array();
	
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		
		loadGraphic("assets/animations/player.png", true, 64, 128);
		
		this.x -= width * 0.25;
		this.y -= height;
		
		var cunt:Int = 0;
		
		for (i in 0...19)
		{
			walkingArray[cunt] = i;
			
			cunt++;
		}
		animation.add("walking", walkingArray, 30, true);
		
		cunt = 0;
		
		for (i in 20...33)
		{
			restingArray[cunt] = i;
			
			cunt++;
		}
		animation.add("resting", restingArray, 6, true);
		
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
		
		cards = new CardManager();
		
		timer.removeEventListener(TimerEvent.TIMER, growUp);
		timer.stop();
		
		animation.play("resting");
	}
	
	override public function update(e)
	{
		acceleration.x = 0;
		
		if (FlxG.keys.justPressed.UP)
		{
			velocity.y -= scaled ? 500 : 400;
		}
		
		if (FlxG.keys.justPressed.DOWN && !scaled)
		{
			maxVelocity.x = 300;
			velocity.y += 100;
			
			scale.set(0.5, 0.5);
			updateHitbox();
			
			scaled = true;
			
			timer.addEventListener(TimerEvent.TIMER, growUp);
			timer.start();
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
		
		super.update(e);	
	}
	
	function growUp(e)
	{
		trace(scaled);
		
		timer.removeEventListener(TimerEvent.TIMER, growUp);
		timer.stop();
		
		maxVelocity.x = 200;
		
		y -= frameHeight * 0.5;
		
		scale.set(1, 1);
		updateHitbox();
		
		scaled = false;
	}
	
	override public function destroy()
	{
		scaled = false;
		timer.removeEventListener(TimerEvent.TIMER, growUp);
		
		super.destroy();
	}
}