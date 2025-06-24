import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class GymTrackerApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        var homeView = new HomeView();
        var homeViewDelegate = new HomeViewDelegate();
        return [ homeView, homeViewDelegate ];
    }

}

function getApp() as GymTrackerApp {
    return Application.getApp() as GymTrackerApp;
}
