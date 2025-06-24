import Toybox.Lang;

class WorkoutEngine {
    private var _template as DataModels.WorkoutTemplate;
    private var _exerciseIndex as Lang.Number;
    private var _setIndex as Lang.Number;

    public function initialize(template as DataModels.WorkoutTemplate) {
        _template = template;
        _exerciseIndex = 0;
        _setIndex = 0;
    }

    public function getCurrentExercise() as DataModels.ExerciseLog {
        return _template.exercises[_exerciseIndex];
    }

    public function getCurrentSet() as DataModels.SetLog {
        return _template.exercises[_exerciseIndex].sets[_setIndex];
    }

    public function nextExercise() as Void {
        if (_exerciseIndex < _template.exercises.size() - 1) {
            _exerciseIndex++;
            _setIndex = 0;
        }
    }

    public function nextSet() as Void {
        if (_setIndex < _template.exercises[_exerciseIndex].sets.size() - 1) {
            _setIndex++;
        }
    }

    public function previousSet() as Void {
        if (_setIndex > 0) {
            _setIndex--;
        }
    }

    public function getCurrentSetIndex() as Lang.Number {
        return _setIndex;
    }
}
