import Toybox.Graphics;
import Toybox.WatchUi;
import Rez;

class ActiveWorkoutView extends WatchUi.View {
    private var _workoutEngine as WorkoutEngine;
    private var _currentSet as DataModels.SetLog;

    function initialize(template as DataModels.WorkoutTemplate) {
        View.initialize();
        _workoutEngine = new WorkoutEngine(template);
        _currentSet = _workoutEngine.getCurrentSet();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.ActiveWorkoutLayout(dc));
    }

    function onShow() as Void {
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);

        var exerciseName = _workoutEngine.getCurrentExercise().exercise.name;
        var lastWorkout = DataManager.getLastWorkoutForExercise(exerciseName);
        if (lastWorkout != null) {
            var historyLabel = View.findDrawableById("history") as WatchUi.Text;
            var lastSet = lastWorkout.setsData[lastWorkout.setsData.size() - 1];
            historyLabel.setText("Last: " + lastWorkout.setsData.size() + "x" + lastSet.reps + " @ " + lastSet.weight + "kg");
        }

        (View.findDrawableById("exerciseName") as WatchUi.Text).setText(exerciseName);
        (View.findDrawableById("sets") as WatchUi.Text).setText("Set " + (_workoutEngine.getCurrentSetIndex() + 1));
        (View.findDrawableById("reps") as WatchUi.Text).setText(_currentSet.reps.toString());
        (View.findDrawableById("weight") as WatchUi.Text).setText(_currentSet.weight.toString() + "kg");
    }

    function onHide() as Void {
    }

    public function nextExercise() as Void {
        _workoutEngine.nextExercise();
        _currentSet = _workoutEngine.getCurrentSet();
        WatchUi.requestUpdate();
    }

    public function nextSet() as Void {
        _workoutEngine.nextSet();
        _currentSet = _workoutEngine.getCurrentSet();
        WatchUi.requestUpdate();
    }

    public function previousSet() as Void {
        _workoutEngine.previousSet();
        _currentSet = _workoutEngine.getCurrentSet();
        WatchUi.requestUpdate();
    }
}
