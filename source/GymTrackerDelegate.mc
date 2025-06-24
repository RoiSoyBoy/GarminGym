import Toybox.Lang;
import Toybox.WatchUi;

class GymTrackerDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new GymTrackerMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}