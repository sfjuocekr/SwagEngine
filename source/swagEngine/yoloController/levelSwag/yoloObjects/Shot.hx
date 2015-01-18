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
	public var timer:Timer = new Timer(1000);
	
	public function new(X:Float=0, Y:Float=0, ?_SimpleGraphic:Dynamic) 
	{
		super(X, Y, _SimpleGraphic);
		
		makeGraphic(4, 4);
		
		exists = false;
		
		timer.addEventListener(TimerEvent.TIMER, stop);
	}
	
	private function stop(e)
	{
		timer.stop();
		timer.reset();
		
		kill();
	}
}