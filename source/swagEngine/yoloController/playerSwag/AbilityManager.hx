package swagEngine.yoloController.playerSwag;

import flixel.FlxObject;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class AbilityManager
{
	private var player:PlayerRenderer;
	private var timer:Timer = new Timer(1000);
	
	public var scaled:Bool = false;
	public var jumping:Bool = false;
	public var cards:CardManager;
	
	public function new(_player:PlayerRenderer) 
	{
		player = _player;
		
		cards = new CardManager();
	}
	
	public function diamonds()
	{
		trace("DIAMONDS ARE FOREVER");
	}
	
	public function clubs()
	{
		trace("GOLFCLUBS!");
	}
	
	public function hearths()
	{
		trace("OLIVEJUICE!");
	}
	
	public function spades()
	{
		trace("DIGLETT!");
		
		jump();
	}
	
	public function jump()
	{
		if (player.isTouching(FlxObject.FLOOR))	player.velocity.y -= scaled ? 500 : 400;
		else if (cards.cardEnergy[3] > 0 && !player.isTouching(FlxObject.FLOOR) && cards.cardSlots[3][0] == 1)
		{
			cards.cardEnergy[3]--;
			
			cards.timer.reset();
			cards.timer.start();
			
			player.velocity.y = 0;
			player.velocity.y -= scaled ? 400 : 300;
		}
	}
	
	public function shrink()
	{
		if (jumping) return;
		
		player.maxVelocity.x = 300;
		player.scale.set(0.5, 0.5);
		player.updateHitbox();
		
		scaled = true;
			
		timer.addEventListener(TimerEvent.TIMER, growUp);
		timer.reset();
		timer.start();		
	}
	
	private function growUp(e)
	{
		timer.removeEventListener(TimerEvent.TIMER, growUp);
		timer.stop();
		
		player.maxVelocity.x = 200;
		player.y -= player.frameHeight * 0.5;
		player.scale.set(1, 1);
		player.updateHitbox();
		scaled = false;
	}
	
	public function destroy()
	{
		timer.removeEventListener(TimerEvent.TIMER, growUp);
		
		cards.destroy();
		
		player = null;
		timer = null;
		scaled = null;
		jumping = null;
		cards = null;
	}
}