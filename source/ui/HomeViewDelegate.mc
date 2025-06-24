import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class HomeViewDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Lang.Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new GymTrackerMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onSelect() as Lang.Boolean {
        var delegate = new WorkoutTemplatesViewDelegate();
        var view = new WorkoutTemplatesView(delegate);
        WatchUi.pushView(view, delegate, WatchUi.SLIDE_UP);
        return true;
    }

    function onKey(keyEvent as KeyEvent) as Lang.Boolean {
        if (keyEvent.getKey() == WatchUi.KEY_UP) {
            return onSelect();
        }
        return false;
    }
}
