package swagEngine.yoloController.playerSwag;

import openfl.events.TimerEvent;
import openfl.utils.Timer;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class AbilityManager
{
	private var player:PlayerRenderer;
	public var cards:CardManager;
	
	public var timer:Timer = new Timer(1000);
	private var intervalTimer:Timer = new Timer(1000);
	
	public function new(_player:PlayerRenderer) 
	{
		player = _player;
		
		cards = new CardManager();
		
		intervalTimer.addEventListener(TimerEvent.TIMER, counter);
	}
	
	public function shrink()
	{
		player.maxVelocity.x = 300;
		player.scale.set(0.5, 0.5);
		player.updateHitbox();
		player.scaled = true;
			
		timer.addEventListener(TimerEvent.TIMER, growUp);
		timer.reset();
		timer.start();		
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
	}
	
	public function rotate(_suit:Int)
	{
		cards.cardSlots[_suit].push(cards.cardSlots[_suit].shift());
		
		trace(cards.cardSlots[_suit]);
	}
	
	private function growUp(e)
	{
		timer.removeEventListener(TimerEvent.TIMER, growUp);
		timer.stop();
		
		player.maxVelocity.x = 200;
		player.y -= player.frameHeight * 0.5;
		player.scale.set(1, 1);
		player.updateHitbox();
		player.scaled = false;
	}
	
	private function counter(e)
	{
		trace(intervalTimer.currentCount);
	}
	
	public function destroy()
	{
		timer.removeEventListener(TimerEvent.TIMER, growUp);
		intervalTimer.removeEventListener(TimerEvent.TIMER, counter);
		
		timer = null;
		intervalTimer = null;
		player = null;	
	}
}