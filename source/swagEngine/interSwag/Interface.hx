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
	public var actionBar:FlxSprite = new FlxSprite();
	public var minimap:FlxSprite = new FlxSprite();
	public var escapeMenu:FlxSprite = new FlxSprite();
	
	private var healthText:FlxText;
	
	private var diamondText:FlxText;
	private var clubText:FlxText;
	private var heartText:FlxText;
	private var spadeText:FlxText;
	
	
	private var diamondsText:FlxText;
	private var clubsText:FlxText;
	private var heartsText:FlxText;
	private var spadesText:FlxText;
	
	public function new(_player:PlayerRenderer) 
	{
		super();
		
		player = _player;
		
		scrollFactor.set(0, 0);
		
			cardOverlay.makeGraphic(384, 128, FlxColor.BLACK);
			cardOverlay.x = FlxG.width - cardOverlay.width;
			cardOverlay.y = FlxG.height - cardOverlay.height;
		add(cardOverlay);
		
			actionBar.makeGraphic(256, 32, FlxColor.BLACK);
			actionBar.x = 0;
			actionBar.y = FlxG.height - actionBar.height;
		add(actionBar);
		
			minimap.makeGraphic(128, 128, FlxColor.BLACK);
			minimap.x = FlxG.width - minimap.width;
			minimap.y = 0;
		add(minimap);
		
			escapeMenu.makeGraphic(256, 384, FlxColor.BLACK);
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
	}
	
	override public function update(e)
	{
		healthText.text =	"Health: " +	Std.string((player.health < 0) ? 0 : player.health);
		
		diamondText.text =	"Diamonds: " +	Std.string(player.abilities.cards.energy[0]);
		clubText.text =		"Clubs: " +		Std.string(player.abilities.cards.energy[1]);
		heartText.text =	"Hearts: " +	Std.string(player.abilities.cards.energy[2]);
		spadeText.text =	"Spades: " +	Std.string(player.abilities.cards.energy[3]);
		
		diamondsText.text =	player.abilities.cards.slots[0].toString();
		clubsText.text =	player.abilities.cards.slots[1].toString();
		heartsText.text =	player.abilities.cards.slots[2].toString();
		spadesText.text =	player.abilities.cards.slots[3].toString();
		
		//ADD SOMETHING TO HANDLE THE PAUSE MENU
		if (FlxG.keys.justPressed.P) escapeMenu.visible = !escapeMenu.visible;
		if (escapeMenu.visible && FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu());
		
		//ADD SOMETHING TO HANDLE UI UPDATES OR DO IT SOMEWHERE ELSE
		
		super.update(e);
	}
}