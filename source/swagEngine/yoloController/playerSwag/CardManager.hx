package swagEngine.yoloController.playerSwag;

import openfl.events.TimerEvent;
import openfl.utils.Timer;

/**
* ...
* @author Sjoer van der Ploeg
*/

class CardManager
{
	public var cardSlots:Array<Array<Int>> =	[[null],	// 0 = Diamonds
												 [null],	// 1 = Clubs
												 [null],	// 2 = Hearts
												 [1]];		// 3 = Spades
	
	public var cardEnergy:Array<Int> = [0, 0, 0, 1];
	
	public var timer:Timer = new Timer(2000);
	
	public function new() 
	{
		timer.addEventListener(TimerEvent.TIMER, powerUp);
		timer.start();	
	}
	
	private function powerUp(e)
	{
		if (cardEnergy[3] == 0) cardEnergy[3]++;
	}
	
	public function rotate(_suit:Int)
	{
		cardSlots[_suit].push(cardSlots[_suit].shift());
	}
	
	public function destroy()
	{
		timer.removeEventListener(TimerEvent.TIMER, powerUp);
		
		cardSlots = null;
		cardEnergy = null;
		timer = null;
	}
}