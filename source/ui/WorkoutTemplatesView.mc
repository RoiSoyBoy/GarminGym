import Toybox.Graphics;
import Toybox.WatchUi;
import Rez;

class WorkoutTemplatesView extends WatchUi.View {
    private var _delegate as WorkoutTemplatesViewDelegate;

    function initialize(delegate as WorkoutTemplatesViewDelegate) {
        View.initialize();
        _delegate = delegate;
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WorkoutTemplatesLayout(dc));
    }

    function onShow() as Void {
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
        var title = _delegate.getTitle();
        var titleLabel = View.findDrawableById("title") as WatchUi.Text;
        titleLabel.setText(title);
    }

    function onHide() as Void {
    }
}
