import Toybox.WatchUi;

class NavigationController {
    function initialize() {
    }

    function pushView(view, delegate, transition) {
        WatchUi.pushView(view, delegate, transition);
    }

    function popView(transition) {
        WatchUi.popView(transition);
    }
}
