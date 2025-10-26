package game.states;

import flixel.FlxG;
import game.controls.Controls;
import haxe.ui.backend.flixel.FlxHaxeUIAppState;

class MusicBeatState extends FlxHaxeUIAppState
{
    var controls:Controls;

    override function create() {
        super.create();
    
        controls = new Controls("Main");
        FlxG.inputs.addInput(controls);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}