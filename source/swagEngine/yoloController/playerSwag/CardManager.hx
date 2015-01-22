package swagEngine.yoloController.playerSwag;

import openfl.events.TimerEvent;
import openfl.utils.Timer;

/**
* ...
* @author Sjoer van der Ploeg
*/

class CardManager
{
	public var slots:Array<Array<String>> =			[[],	// 0 = Diamonds
													 [],	// 1 = Clubs
													 [],	// 2 = Hearts
													 []];	// 3 = Spades
	
	public var energy:Array<Int> = [1, 1, 1, 1];
	
	public var collected:Array<Int> = [0, 0, 0];
	
	public var timer:Timer = new Timer(2000);
	
	public function new() 
	{
		timer.addEventListener(TimerEvent.TIMER, powerUp);
		timer.start();	
	}
	
	public function collect(_suit:String)
	{
	/*	switch (_suit)				// HACK ENERGY, ONLY ONE CARD ATM
		{
			case "diamond":
				energy[0]++;
				
			case "club":
				energy[1]++;
				
			case "heart":
				energy[2]++;
				
			case "spade":
				energy[3]++;
		}	*/
		
		collected[0]++;
		
		if (collected[0] == 10)
		{
			collected[0] = 0;
			collected[1]++;
		}
		if (collected[1] == 3)
		{
			collected[1] = 0;
			collected[2]++;
		}
		if (collected[2] == 1)
		{
			trace("GAME OVER!");
			
			// play titlescreen animation or whatever.
		}
	}
	
	private function powerUp(e)
	{
		for (i in 0...4)
			if (energy[i] == 0) energy[i]++;
	}
	
	public function destroy()
	{
		timer.removeEventListener(TimerEvent.TIMER, powerUp);
		
		slots = null;
		energy = null;
		timer = null;
	}
}