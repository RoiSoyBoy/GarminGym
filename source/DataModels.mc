import Toybox.Lang;

module DataModels {

    class Exercise {
        var name as Lang.String;
        var muscleGroups as Lang.Array<Lang.String>;
        var equipment as Lang.String;
        var customTags as Lang.Array<Lang.String>;
        var formCuesRef as Lang.String;
        var targetReps as Lang.Number or Null;
        var targetWeight as Lang.Number or Null;

        function initialize(name, muscleGroups, equipment, customTags, formCuesRef) {
            self.name = name;
            self.muscleGroups = muscleGroups;
            self.equipment = equipment;
            self.customTags = customTags;
            self.formCuesRef = formCuesRef;
            self.targetReps = null;
            self.targetWeight = null;
        }
    }

    class WorkoutTemplate {
        var name as Lang.String;
        var exercises as Lang.Array<ExerciseLog>;
        var programType as Lang.String;

        function initialize(name, exercises, programType) {
            self.name = name;
            self.exercises = exercises;
            self.programType = programType;
        }
    }

    class WorkoutLog {
        var timestamp as Lang.Number;
        var templateUsed as WorkoutTemplate;
        var exerciseDetails as Lang.Array<ExerciseLog>;
        var setsData as Lang.Array<SetLog>;

        function initialize(timestamp, templateUsed, exerciseDetails, setsData) {
            self.timestamp = timestamp;
            self.templateUsed = templateUsed;
            self.exerciseDetails = exerciseDetails;
            self.setsData = setsData;
        }
    }

    class ExerciseLog {
        var exercise as Exercise;
        var sets as Lang.Array<SetLog>;

        function initialize(exercise, sets) {
            self.exercise = exercise;
            self.sets = sets;
        }
    }

    class SetLog {
        var reps as Lang.Number;
        var weight as Lang.Number;
        var rpe as Lang.Number;

        function initialize(reps, weight, rpe) {
            self.reps = reps;
            self.weight = weight;
            self.rpe = rpe;
        }
    }

    class UserSettings {
        var preferences as Lang.Dictionary;
        var deviceConfig as Lang.Dictionary;

        function initialize(preferences, deviceConfig) {
            self.preferences = preferences;
            self.deviceConfig = deviceConfig;
        }
    }

    class BiometricCache {
        var hrv as Lang.Number;
        var bodyBattery as Lang.Number;

        function initialize(hrv, bodyBattery) {
            self.hrv = hrv;
            self.bodyBattery = bodyBattery;
        }
    }
}
