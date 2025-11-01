package game.objects;

import flixel.FlxSprite;
import game.paths.Spritesheet;
import haxe.Json;
import openfl.Assets;

typedef CharacterData = {
    var name:String;
    var assetsPath:String;
    var icon:String;
    var color:String;
    var animations:Array<AnimationData>;
}

typedef AnimationData = {
    var name:String;
    var animPrefix:String;
    var animOffset:Array<Int>;
    var frameRate:Int;
    var looped:Bool;
}

class Character extends FlxSprite
{
    public var characterData:CharacterData;
    public var animationsData:Array<AnimationData>;
    public var animOffset:Map<String, Array<Int>> = new Map();

    public function new(name:String, x:Float = 0, y:Float = 0, isPlayer:Bool = false) {
        super(x, y);

        // Parse character data from JSON
        var jsonContent:String = Assets.getText(Paths.data('characters/' + name.toLowerCase() + '.json'));
        characterData = Json.parse(jsonContent);

        // Load config from the JSON data
        frames = Spritesheet.atlas('characters/${characterData.assetsPath}');
        animationsData = characterData.animations;

        for (animData in animationsData) {
            animation.addByPrefix(animData.name, animData.animPrefix, animData.frameRate, animData.looped);
            animOffset.set(animData.name, animData.animOffset);
        }
    }

    public function playAnim(animName:String, force:Bool = false):Void {
        animation.play(animName, force);
        if (animOffset.exists(animName)) {
            var offset = animOffset.get(animName);
            this.offset.set(offset[0], offset[1]);
        } else {
            this.offset.set(0, 0);
        }
    }
}