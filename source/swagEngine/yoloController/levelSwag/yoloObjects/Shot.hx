package swagEngine.yoloController.levelSwag.yoloObjects;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Shot extends FlxSprite
{
	private var travel:Int = 0;
	
	public var timer:Timer = new Timer(10);
	
	public function new(_x:Float=0, _y:Float=0) 
	{
		super(_x, _y, "assets/images/fireball.png");
		
		exists = false;
		
		timer.addEventListener(TimerEvent.TIMER, stop);
		
		scale.x = 0.25;
		scale.y = 0.25;
		
		updateHitbox();
	}
	
	private function stop(e)
	{
		if (travel == 100)
		{
			timer.stop();
			timer.reset();
			
			travel = 0;
			
			kill();
		}
		
		alpha *= 0.98;
		
/*		var yDiff:Float = (height - (height * 0.975)) * 0.5;
			scale.y *= 0.975;
			height *= 0.975;
			offset.y += yDiff;
			y += yDiff;
	*/	
		//updateHitbox();
		
		travel++;
	}
}