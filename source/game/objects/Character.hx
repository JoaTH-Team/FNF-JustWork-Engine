package game.objects;

import flixel.FlxSprite;

typedef CharacterData = {
    var name:String;
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
    public var characterName:String = "bf";
    public var animations:Array<AnimationData>;
    public var curIcon:String = "bf";
    public var curColor:String = "FFFFFF";
    public var isPlayer:Bool = false;

    public function new(name:String, x:Float = 0, y:Float = 0, isPlayer:Bool = false) {
        super(x, y);
    }
}