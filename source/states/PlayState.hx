package states;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.sound.FlxSound;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import game.objects.Character;
import game.scripts.FunkinScript;
import game.scripts.PolymodHandler;
import moonchart.formats.fnf.legacy.FNFLegacy;
import sys.FileSystem;

using StringTools;

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

	// Scriptes
	public var gameScript:Array<FunkinScript> = [];

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

	// Song
	public var vocals:Array<FlxSound> = [];
	public var chart:FNFLegacy;
	public var curSong:String = 'bopeebo';
	public var curDifficulty:String = 'normal';

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

		// Song and Chart
		// chart = cast new FNFLegacy().fromFile(Paths.data('songs/${curSong.toLowerCase()}'), null, curDifficulty.toLowerCase());

		// Load stage script
		stageScript = new FunkinScript('stages/' + curStage);

		// Load scripts thought folder
		var foldersToCheck:Array<String> = [Paths.file('songs/${chart.data.song.song.toLowerCase()}/')];
		for (mod in PolymodHandler.getModIDs())
			foldersToCheck.push('mods/$mod/data/songs/${chart.data.song.song.toLowerCase()}/');
		for (folder in foldersToCheck)
		{
			if (FileSystem.exists(folder) && FileSystem.isDirectory(folder))
			{
				for (file in FileSystem.readDirectory(folder))
				{
					if (file.endsWith('.hxs'))
						gameScript.push(new FunkinScript(folder + file));
				}
			}
		}

		// Call create functions for script
		FlxG.signals.preStateCreate.addOnce(function(state) {
			callFunction('preCreate', []);
		});
		callFunction('create', []);

		// Create HUD
		healthBar = new FlxBar(0, FlxG.height * 0.9, LEFT_TO_RIGHT, 601, 19, this, "health", 0, 2, true);
		healthBar.createFilledBar(0xff00ff00, 0xffff0000);
		healthBar.screenCenter(X);
		healthBar.solid = true;
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

	public function callFunction(name:String, args:Array<Dynamic>)
	{
		stageScript.executeFunc(name, args);
	}
}
