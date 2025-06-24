import Toybox.Graphics;
import Toybox.WatchUi;
import Rez;

class AnalyticsView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.AnalyticsLayout(dc));
    }

    function onShow() as Void {
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);

        var analytics = DataManager.getAnalytics();

        var weeklyVolumeLabel = View.findDrawableById("weeklyVolume") as WatchUi.Text;
        weeklyVolumeLabel.setText("Weekly Volume: " + analytics["weeklyVolume"]);

        var squatPrLabel = View.findDrawableById("squatPr") as WatchUi.Text;
        squatPrLabel.setText("Squat PR: " + analytics["squatPr"]);

        var benchPrLabel = View.findDrawableById("benchPr") as WatchUi.Text;
        benchPrLabel.setText("Bench PR: " + analytics["benchPr"]);

        var deadliftPrLabel = View.findDrawableById("deadliftPr") as WatchUi.Text;
        deadliftPrLabel.setText("Deadlift PR: " + analytics["deadliftPr"]);
    }

    function onHide() as Void {
    }
}
