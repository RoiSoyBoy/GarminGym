import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class Button extends WatchUi.Drawable {

    private var _label as Lang.String;
    private var _width as Lang.Number;
    private var _height as Lang.Number;
    private var _backgroundColor as Lang.Number;
    private var _foregroundColor as Lang.Number;

    function initialize(options as {
        :label as Lang.String,
        :width as Lang.Number,
        :height as Lang.Number,
        :backgroundColor as Lang.Number,
        :foregroundColor as Lang.Number
    }) {
        Drawable.initialize(options);

        _label = options[:label];
        _width = options[:width];
        _height = options[:height];
        _backgroundColor = options[:backgroundColor];
        _foregroundColor = options[:foregroundColor];
    }

    function draw(dc as Dc) as Void {
        var x = (dc.getWidth() - _width) / 2;
        var y = (dc.getHeight() - _height) / 2;

        dc.setColor(_backgroundColor, _backgroundColor);
        dc.fillRectangle(x, y, _width, _height);

        dc.setColor(_foregroundColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x + (_width / 2), y + (_height / 2), Graphics.FONT_MEDIUM, _label, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}
