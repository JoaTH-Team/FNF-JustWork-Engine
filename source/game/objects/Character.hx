package game.objects;

import flixel.FlxSprite;
import game.paths.Spritesheet;
import haxe.Json;

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

    var animationsData:Array<AnimationData>;
    var animOffset:Map<String, Array<Int>> = new Map();

    public function new(name:String, x:Float = 0, y:Float = 0, isPlayer:Bool = false) {
        super(x, y);

        // Parse character data from JSON
        characterData = Json.parse(Paths.data('characters/' + name + '.json'));

        // Load config from the JSON data
        frames = Spritesheet.altas('characters/${characterData.assetsPath}');
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