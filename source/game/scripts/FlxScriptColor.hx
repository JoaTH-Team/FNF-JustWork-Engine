package game.scripts;

import flixel.util.FlxColor;

class FlxScriptColor
{
    public static function main() {
        return {
            'BLACK': FlxColor.BLACK,
			'BLUE': FlxColor.BLUE,
			'BROWN': FlxColor.BROWN,
			'CYAN': FlxColor.CYAN,
			'GRAY': FlxColor.GRAY,
			'GREEN': FlxColor.GREEN,
			'LIME': FlxColor.LIME,
			'MAGENTA': FlxColor.MAGENTA,
			'ORANGE': FlxColor.ORANGE,
			'PINK': FlxColor.PINK,
			'PURPLE': FlxColor.PURPLE,
			'RED': FlxColor.RED,
			'TRANSPARENT': FlxColor.TRANSPARENT,
			'WHITE': FlxColor.WHITE,
			'YELLOW': FlxColor.YELLOW,
			'add': FlxColor.add,
			'fromCMYK': FlxColor.fromCMYK,
			'fromHSB': FlxColor.fromHSB,
			'fromHSL': FlxColor.fromHSL,
			'fromInt': FlxColor.fromInt,
			'fromRGB': FlxColor.fromRGB,
			'fromRGBFloat': FlxColor.fromRGBFloat,
			'fromString': FlxColor.fromString,
			'interpolate': FlxColor.interpolate,
			'to24Bit': function(color:Int) return color & 0xffffff
        };
    }
}