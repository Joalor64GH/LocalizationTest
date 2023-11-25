package;

import flixel.input.keyboard.FlxKey;
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

        daText = new FlxText(0, 0, 0, Localization.getText("greeting"), 12);
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

        final keyPressed:FlxKey = FlxG.keys.firstJustPressed();
        if (keyPressed != FlxKey.NONE) {
            daText.text = Localization.getText('greeting');
            switch (keyPressed) {
                case ONE:
                    Localization.switchLanguage("en-US");
                case TWO:
                    Localization.switchLanguage("es-ES");
                case THREE:
                    Localization.switchLanguage("fr-FR");
                case FOUR:
                    Localization.switchLanguage("pt-BR");
                case FIVE:
                    Localization.switchLanguage("yr-HR");
            }
        }
    }
}