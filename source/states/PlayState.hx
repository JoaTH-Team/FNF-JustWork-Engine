package states;

import flixel.FlxG;
import game.objects.Character;
import game.scripts.FunkinScript;

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
	public var stageScript:FunkinScript;

	override public function create()
	{
		super.create();
	
		stageScript = new FunkinScript('stages/' + curStage);

		FlxG.signals.preStateCreate.addOnce(function(state) {
			callFunction('preCreate', []);
		});
		callFunction('create', []);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		FlxG.signals.preUpdate.addOnce(function() {
			callFunction('preUpdate', [elapsed]);
		});
		callFunction('update', [elapsed]);
	}

	public function callFunction(name:String, args:Array<Dynamic>):Dynamic
	{
		return stageScript.executeFunc(name, args);
	}
}
