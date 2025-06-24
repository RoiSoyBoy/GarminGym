import Toybox.WatchUi;
import Toybox.Lang;

class ActiveWorkoutViewDelegate extends WatchUi.BehaviorDelegate {

    private var _view as ActiveWorkoutView;

    public function initialize(view as ActiveWorkoutView) {
        BehaviorDelegate.initialize();
        _view = view;
    }

    public function onSelect() as Lang.Boolean {
        _view.nextExercise();
        return true;
    }

    public function onNextPage() as Lang.Boolean {
        _view.nextSet();
        return true;
    }

    public function onPreviousPage() as Lang.Boolean {
        _view.previousSet();
        return true;
    }
}
