package game.paths;

using StringTools;

class Paths {
    public static var IMAGES_DIR:String = "assets/images/";
    public static var SOUNDS_DIR:String = "assets/sounds/";
    public static var MUSIC_DIR:String = "assets/music/";
    public static var DATA_DIR:String = "assets/data/";
    
    public static var IMAGE_EXT:String = "png";
    public static var SOUND_EXT:String = "ogg";
    public static var MUSIC_EXT:String = "ogg";
    public static var DATA_EXT:String = "json";
    
    /**
     * Generic file path resolver
     * @param name File name (with or without extension)
     * @param directory Target directory
     * @param defaultExtension Default file extension
     * @return Full file path
     */
    public static function file(name:String, ?directory:String = "", ?defaultExtension:String = ""):String {
        if (directory != null && directory.length > 0) {
            directory = directory.replace("^[/\\\\]+|[/\\\\]+$", "g");
            if (directory.length > 0) directory += "/";
        }
        
        if (defaultExtension != null && defaultExtension.length > 0) {
            var extReg = ~/\.[^\.]+$/;
            if (!extReg.match(name)) {
                name += "." + defaultExtension;
            }
        }
        
        return directory + name;
    }
    
    /**
     * Get path to an image file
     * @param imageName Image file name (with or without extension)
     * @return Full path to image file
     */
    public static function image(imageName:String):String {
        return file(imageName, IMAGES_DIR, IMAGE_EXT);
    }
    
    /**
     * Get path to a music file
     * @param musicName Music file name (with or without extension)
     * @return Full path to music file
     */
    public static function music(musicName:String):String {
        return file(musicName, MUSIC_DIR, MUSIC_EXT);
    }
    
    /**
     * Get path to a sound file
     * @param soundName Sound file name (with or without extension)
     * @return Full path to sound file
     */
    public static function sound(soundName:String):String {
        return file(soundName, SOUNDS_DIR, SOUND_EXT);
    }
    
    /**
     * Get path to a data file
     * @param dataName Data file name (with or without extension)
     * @return Full path to data file
     */
    public static function data(dataName:String):String {
        return file(dataName, DATA_DIR, DATA_EXT);
    }
    
    /**
     * Utility function to get path for sprites (images with specific subdirectory)
     * @param spriteName Sprite file name
     * @param subdir Subdirectory within images (e.g., "characters", "ui")
     * @return Full path to sprite file
     */
    public static function sprite(spriteName:String, subdir:String = "sprites"):String {
        return file(spriteName, '${IMAGES_DIR}${subdir}', IMAGE_EXT);
    }
    
    /**
     * Utility function to get path for fonts
     * @param fontName Font file name
     * @return Full path to font file (TTF/OTF)
     */
    public static function font(fontName:String):String {
        return file(fontName, "assets/fonts", "ttf");
    }
    
    /**
     * Check if a file exists (useful for conditional loading)
     * @param path The file path to check
     * @return Bool indicating if file exists
     */
    public static function exists(path:String):Bool {
        return sys.FileSystem.exists(path);
    }
}