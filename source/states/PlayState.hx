package states;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
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

	// Camera
	public var camGame:FlxCamera;
	public var camHUD:FlxCamera;
	public var camArray:Array<FlxCamera> = [];
	public var defaultCamZoom:Float = 1;
	public var camZooming:Bool = false;

	// HUD Gameplay
	public var healthBar:FlxBar;

	// Gameplay variables
	public var health:Float = 1;
	public var startingSong:Bool = false;

	override public function create()
	{
		super.create();
		persistentDraw = persistentUpdate = true;
		FlxG.fixedTimestep = false;
		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);
	
		// Create and Init camera
		camGame = new FlxCamera();
		camGame.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.reset(camGame);

		camHUD = new FlxCamera();
		camHUD.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(camHUD, false);

		FlxG.camera.zoom = defaultCamZoom;

		// Load stage script
		stageScript = new FunkinScript('stages/' + curStage);

		// Call create functions for script
		FlxG.signals.preStateCreate.addOnce(function(state) {
			callFunction('preCreate', []);
		});
		callFunction('create', []);

		// Create HUD
		healthBar = new FlxBar(10, 10, LEFT_TO_RIGHT, 200, 20, this, "health", 0, 2, true);
		healthBar.createFilledBar(0xffff0000, 0xff00ff00);
		healthBar.camera = camHUD;
		add(healthBar);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		// Call update functions for script
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
