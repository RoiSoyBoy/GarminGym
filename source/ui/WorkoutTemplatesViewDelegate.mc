import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Application;

class WorkoutTemplatesViewDelegate extends WatchUi.BehaviorDelegate {
    private var _templates as Lang.Array<DataModels.WorkoutTemplate>;
    private var _currentIndex as Lang.Number;

    function initialize() {
        BehaviorDelegate.initialize();
        _templates = DataManager.loadPrebuiltTemplates();
        _currentIndex = 0;
    }

    function onSelect() as Lang.Boolean {
        var template = _templates[_currentIndex];
        var activeWorkoutView = new ActiveWorkoutView(template);
        WatchUi.pushView(activeWorkoutView, new ActiveWorkoutViewDelegate(activeWorkoutView), WatchUi.SLIDE_UP);
        return true;
    }

    function onNextPage() as Lang.Boolean {
        _currentIndex = (_currentIndex + 1) % _templates.size();
        WatchUi.requestUpdate();
        return true;
    }

    function onPreviousPage() as Lang.Boolean {
        _currentIndex = (_currentIndex - 1 + _templates.size()) % _templates.size();
        WatchUi.requestUpdate();
        return true;
    }

    function getTitle() as Lang.String {
        return _templates[_currentIndex].name;
    }
}
