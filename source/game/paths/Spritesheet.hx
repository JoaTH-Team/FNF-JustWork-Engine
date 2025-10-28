package game.paths;

import flixel.graphics.frames.FlxAtlasFrames;

class Spritesheet {
    public static function altas(path:String):FlxAtlasFrames {
        return FlxAtlasFrames.fromSparrow(Paths.image('$path'), Paths.file('images/$path.xml'));
    }
}