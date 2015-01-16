package swagEngine.yoloController.playerSwag;

/**
* ...
* @author Sjoer van der Ploeg
*/

class CardManager
{
	private var cardOne:String = "Diamonds";
	private var cardTwo:String = "Clubs";
	private var cardThree:String = "Hearths";
	private var cardFour:String = "Spades";
	
	public var cardSlots:Array<Array<Int>> =	[[0],
												 [0],
												 [0],
												 [0]];
	
	public var cardEnergy:Array<Int> = [1, 1, 1, 1];
	
	public function new() 
	{
		
	}
}