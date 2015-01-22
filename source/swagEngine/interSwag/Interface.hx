package swagEngine.interSwag;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup;
import swagEngine.yoloController.playerSwag.PlayerRenderer;

/**
* ...
* @author Sjoer van der Ploeg
*/

class Interface	extends FlxSpriteGroup
{
	private var player:PlayerRenderer;
	
	public var cardOverlay:FlxSprite = new FlxSprite();
	public var escapeMenu:FlxSprite = new FlxSprite();
	
	private var healthText:FlxText;
	
	private var diamondText:FlxText;
	private var clubText:FlxText;
	private var heartText:FlxText;
	private var spadeText:FlxText;
	
	private var cardsText:FlxText;	
	
	private var diamondsText:FlxText;
	private var clubsText:FlxText;
	private var heartsText:FlxText;
	private var spadesText:FlxText;
	
	public var red:FlxSprite = new FlxSprite(FlxG.width * 0.5 - 32, FlxG.height - 128, "assets/images/red_ball.png");
	public var silver:FlxSprite = new FlxSprite(FlxG.width * 0.5, FlxG.height - 128, "assets/images/silver_ball.png");
	public var gold:FlxSprite = new FlxSprite(FlxG.width * 0.5 - 16, FlxG.height - 128, "assets/images/gold_ball.png");
	
	public var A:FlxSprite = new FlxSprite(FlxG.width * 0.5 -	128, FlxG.height - 96, "assets/images/A.png");
	public var S:FlxSprite = new FlxSprite(FlxG.width * 0.5 -	64, FlxG.height - 96, "assets/images/S.png");
	public var D:FlxSprite = new FlxSprite(FlxG.width * 0.5, FlxG.height - 96, "assets/images/D.png");
	public var F:FlxSprite = new FlxSprite(FlxG.width * 0.5 +	64, FlxG.height - 96, "assets/images/F.png");
	
	public function new(_player:PlayerRenderer) 
	{
		super();
		
		player = _player;
		
		scrollFactor.set(0, 0);
		
			cardOverlay.makeGraphic(384, 128, FlxColor.BLACK);
			cardOverlay.x = FlxG.width - cardOverlay.width;
			cardOverlay.y = FlxG.height - cardOverlay.height;
		add(cardOverlay);
		
			escapeMenu.loadGraphic("assets/images/pause_menu.png");
			escapeMenu.x = (FlxG.width * 0.5) - (escapeMenu.width * 0.5);
			escapeMenu.y = (FlxG.height * 0.5) - (escapeMenu.height * 0.5);
			escapeMenu.visible = false;
		add(escapeMenu);
		
		
		// energy
			healthText = 	new FlxText(cardOverlay.x + 8,	cardOverlay.y + 8,	368, null, 16, true);
		add(healthText);
		
			diamondText = 	new FlxText(healthText.x,		healthText.y + 28,	368, null, 16, true);
		add(diamondText);
		
			clubText = 		new FlxText(healthText.x,		diamondText.y + 20,	368, null, 16, true);
		add(clubText);
		
			heartText = 	new FlxText(healthText.x,		clubText.y + 20,	368, null, 16, true);
		add(heartText);
		
			spadeText = 	new FlxText(healthText.x,		heartText.y + 20,	368, null, 16, true);
		add(spadeText);
		
		
			cardsText = 	new FlxText(cardOverlay.x + 8,	cardOverlay.y + 8,	368, null, 16, true);
			cardsText.alignment = "right";
		add(cardsText);
		
		
		// slots
			diamondsText = 	new FlxText(healthText.x,		healthText.y + 28,	368, null, 16, true);
			diamondsText.alignment = "right";
		add(diamondsText);
		
			clubsText = 	new FlxText(healthText.x,		diamondText.y + 20,	368, null, 16, true);
			clubsText.alignment = "right";
		add(clubsText);
		
			heartsText = 	new FlxText(healthText.x,		clubText.y + 20,	368, null, 16, true);
			heartsText.alignment = "right";
		add(heartsText);
		
			spadesText = 	new FlxText(healthText.x,		heartText.y + 20,	368, null, 16, true);
			spadesText.alignment = "right";
		add(spadesText);
		
		add(red);
		add(silver);
		add(gold);
		
		add(A);
		add(S);
		add(D);
		add(F);
	}
	
	override public function update(e:Float)
	{
		healthText.text =	"Health: " +		Std.string((player.health < 0) ? 0 : player.health);
		
		cardsText.text =	"Collection: " +	"B: " + Std.string(player.abilities.cards.collected[0]) + " S: " + Std.string(player.abilities.cards.collected[1]) + " G: " + Std.string(player.abilities.cards.collected[2]);
		
		diamondText.text =	"Diamonds: " +		Std.string(player.abilities.cards.energy[0]);
		clubText.text =		"Clubs: " +			Std.string(player.abilities.cards.energy[1]);
		heartText.text =	"Hearts: " +		Std.string(player.abilities.cards.energy[2]);
		spadeText.text =	"Spades: " +		Std.string(player.abilities.cards.energy[3]);
		
		diamondsText.text =	player.abilities.cards.slots[0].toString();
		clubsText.text =	player.abilities.cards.slots[1].toString();
		heartsText.text =	player.abilities.cards.slots[2].toString();
		spadesText.text =	player.abilities.cards.slots[3].toString();
		
		//ADD SOMETHING TO HANDLE THE PAUSE MENU
		if (FlxG.keys.justPressed.P) escapeMenu.visible = !escapeMenu.visible;
		if (escapeMenu.visible && FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu());
		
		//BALLZ
		red.alpha = (player.abilities.cards.collected[2] >= 1) ? 0 : 1 - (10 - player.abilities.cards.collected[0]) / 10;
		silver.alpha = (player.abilities.cards.collected[2] >= 1) ? 0 : 1 - (3 - player.abilities.cards.collected[1]) / 3;
		gold.alpha = (player.abilities.cards.collected[2] >= 1) ? 1 : 0;
		
		// BUTTANZ
		if (player.abilities.cards.energy[0] > 0) A.visible = true;
		else A.visible = false;
		
		if (player.abilities.cards.energy[1] > 0) S.visible = true;
		else S.visible = false;
		
		if (player.abilities.cards.energy[2] > 0) D.visible = true;
		else D.visible = false;
		
		if (player.abilities.cards.energy[3] > 0) F.visible = true;
		else F.visible = false;
		
		
		//ADD SOMETHING TO HANDLE UI UPDATES OR DO IT SOMEWHERE ELSE
		
		super.update(e);
	}
}