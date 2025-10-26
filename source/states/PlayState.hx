package states;

import flixel.util.FlxScriptUtil;
import game.objects.Character;

class PlayState extends MusicBeatState
{
	// Instance variables
	public static var instance:PlayState = null;

	override public function new() {
		super();
		instance = this;
	}
	
	// Characters
	public var boyfriend:Character;
	public var gf:Character;
	public var dad:Character;

	// Stages
	public var curStage:String = "stage";

	override public function create()
	{
		super.create();

		// Build stage script
		Paths.DATA_EXT = '';
		FlxScriptUtil.buildRuleScript(Paths.data('stages/$curStage'));
		FlxScriptUtil.getRuleScript(Paths.data('stages/$curStage')).setVariable("PlayState", this);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
