package;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;
import Localization;

class PlayState extends FlxState
{
    var daText:FlxText;

    override public function create()
    {
        Localization.loadLanguages(["en-US", "es-ES", "fr-FR", "pt-BR", "yr-HR"]);
        Localization.switchLanguage("en-US"); // Default language

        daText = new FlxText(0, 0, 0, Localization.get("greeting"), 12);
        daText.setFormat(Paths.font("vcr.ttf"), 64, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        daText.screenCenter(XY);
        add(daText);

        var daText2:FlxText = new FlxText(4, FlxG.height - 24, 0, 'Use 1-5 to switch languages.', 12);
        daText2.setFormat(Paths.font("vcr.ttf"), 26, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        daText2.scrollFactor.set();
        add(daText2);

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ONE) {
            Localization.switchLanguage("en-US");
            daText.text = Localization.get('greeting');
        } else if (FlxG.keys.justPressed.TWO) {
            Localization.switchLanguage("es-ES");
            daText.text = Localization.get('greeting');
        } else if (FlxG.keys.justPressed.THREE) {
            Localization.switchLanguage("fr-FR");
            daText.text = Localization.get('greeting');
        } else if (FlxG.keys.justPressed.FOUR) {
            Localization.switchLanguage("pt-BR");
            daText.text = Localization.get('greeting');
        } else if (FlxG.keys.justPressed.FIVE) {
            Localization.switchLanguage("yr-HR");
            daText.text = Localization.get('greeting');
        }
    }
}