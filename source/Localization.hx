#if sys
import sys.io.File;
import sys.FileSystem;
#end
import flixel.FlxG;
import haxe.Json;

using StringTools;

class Localization 
{
    public static var currentLanguage:String = "en-US";
    public static var texts:Map<String, Map<String, String>>;

    public static function loadLanguages(directory:String):Void 
    {
        var files:Array<String> = FileSystem.readDirectory(directory);
        for (file in files) {
            var filePath:String = '$directory/$file';
            if (FileSystem.exists(filePath) && StringTools.endsWith(file, '.json')) {
                try {
                    var languageCode:String = file.substring(0, file.indexOf("."));
                    var jsonString:String = File.getContent(filePath);
                    texts.set(languageCode, Json.parse(jsonString));
                } catch(e:Dynamic) {
                    trace('uh oh! there was an error loading $filePath' + ': $e');
                }
            }
        }
    }

    public static function getText(key:String):String 
    {
        var languageMap = texts.get(currentLanguage);
        if (languageMap != null) {
            return languageMap.get(key);
        }
        trace('oops! it returned null!');
        return null;
    }

    public static function switchToLanguage(language:String)
    {
        if (texts.exists(language)) {
            currentLanguage = language;
        } else {
            trace('sorry! $language isnt supported!');
        }
    }

    public static function getLocalizedText(key:String)
    {
        var text:String = getText(key);
        if (text == 'oops! it returned null!') {
            trace('$key doesnt exist. sorry!');
            return 'oops! it returned null!';
        }
        return text;
    }
}