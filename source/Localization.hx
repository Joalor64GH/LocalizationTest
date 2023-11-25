package;

#if sys
import sys.io.File;
import sys.FileSystem;
#end
import flixel.FlxG;
import haxe.Json;

/**
 * A simple localization system
 * @author Joalor64GH
 */

class Localization 
{
    /**
     * Contains data for different languages.
     * The outer map's key represent the language code, and the inner map contains the key-value pairs for localized strings.
     */
    private static var data:Map<String, Map<String, String>>;

    private static var currentLanguage:String; // Stores the currently selected language
    private static var DEFAULT_LANGUAGE:String = "en-us"; // The default language (English)

    /**
     * Simply loads languages based on an array of codes.
     * @param languages An array containing the language codes (Example: ["en-us", "es-es", "fr-fr"])
     * @return Whether or not all languages were successfully loaded.
     */

    public static function loadLanguages(languages:Array<String>):Bool
    {
        var allLoaded:Bool = true;

        data = new Map<String, Map<String, String>>();

        for (language in languages) {
            var languageData:Map<String, String> = loadLanguageData(language);
            if (languageData != null && loadLanguageData(language) != null && !loadLanguageData(language).iterator().hasNext()) {
                trace("successfully loaded language: " + language + "!");
                data.set(language, languageData);
            } else {
                trace("oh no! failed to load language: " + language + "!");
                allLoaded = false;
            }
        }

        return allLoaded;
    }

    /**
     * Loads the data for the specified language, but falls back to English if it's not found.
     * @param language The language code (Example: "en-us" for English).
     * @return The map containing the language data.
     */

    private static function loadLanguageData(language:String):Map<String, String>
    {
        var languageData:Map<String, String> = new Map<String, String>();
        var path:String = Paths.locale(language);

        // Attempt to load the requested file
        if (!FileSystem.exists(path)) {
            // If the requested file is not found, uses the default language as a fallback
            trace("oops! file not found for: " + language + "!");
            path = Paths.locale(DEFAULT_LANGUAGE);
            currentLanguage = DEFAULT_LANGUAGE;
        } else {
            // Use the requested language if the file is found
            currentLanguage = language; // Updates current language to the requested one
        }

        // Load language from the determined path
        var jsonContent:String = File.getContent(path);
        languageData = Json.parse(jsonContent);

        return languageData;
    }

    /**
     * Used to switch languages to a specified code.
     * @param newLanguage The new language to switch to.
     * @return Whether or not the switch was successful.
     */

    public static function switchLanguage(newLanguage:String):Bool
    {
        // Check if requested language is the same as the current language 
        if (newLanguage == currentLanguage) {
            trace("hey! you're already using the language: " + newLanguage);
            return true; // Language is already selected, so no change is needed
        }

        // Attempt to load data for requested language
        var languageData:Map<String, String> = loadLanguageData(newLanguage);

        // Check if the data was successfully loaded
        if (languageData == null || languageData.iterator().hasNext()) {
            trace("whoops! failed to load data for: " + newLanguage);
            return false; // Failed to load data for requested language
        }

        // Update current language code to the requested code
        currentLanguage = newLanguage;

        return true; // The switch was successful
    }

    /**
     * Retrieves a localized string for a specified key in a language.
     * But if the translation doesn't exist, it returns the key itself as a fallback.
     * @param key The key for the text to be translated.
     * @param language The language code in which the translation is requested.
     * @return The translated text if available, otherwise, returns the key.
     */

    public static function get(key:String, language:String = "en-us"):String
    {
        var targetLanguage:String = language.toLowerCase();
        var languageData:Map<String, String> = data.get(targetLanguage);
        var localizedString:String = languageData.get(key);
        
        if (data == null || languageData == null) {
            return key; // If data or languageData map is null, returns the key itself.
        }

        return localizedString != null ? localizedString : key; 
    }
}