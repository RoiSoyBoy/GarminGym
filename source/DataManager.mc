import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Rez;

module DataManager {

    // TODO: Implement data versioning and migration
    // When the data schema changes, we will need to migrate the user's data to the new schema.
    // We can store a version number in the application storage, and check it when the application starts.
    // If the version number is old, we can run a migration script to update the data.

    function saveData(key as Lang.String, data as Lang.Object) as Void {
        Application.Storage.setValue(key, data);
    }

    function loadData(key as Lang.String) as Lang.Object {
        return Application.Storage.getValue(key);
    }

    function loadPrebuiltTemplates() as Lang.Array<DataModels.WorkoutTemplate> {
        var templates = WatchUi.loadResource(Rez.JsonData.templates) as Lang.Array<Lang.Dictionary>;
        var result = new Lang.Array<DataModels.WorkoutTemplate>[0];


        for (var i = 0; i < templates.size(); i++) {
            var template = templates[i];
            var exercisesData = template["exercises"] as Lang.Array<Lang.Dictionary>;
            var exercises = new Lang.Array<DataModels.ExerciseLog>[0];


            for (var j = 0; j < exercisesData.size(); j++) {
                var exerciseData = exercisesData[j];
                var setsData = exerciseData["sets"] as Lang.Array<Lang.Dictionary>;
                var sets = new Lang.Array<DataModels.SetLog>[0];

                if (setsData != null) {
                    for (var k = 0; k < setsData.size(); k++) {
                        var setData = setsData[k];
                        var reps = setData["reps"] as Lang.Number;
                        var weight = setData["weight"] as Lang.Number;
                        var rpe = setData["rpe"] as Lang.Number?;
                        sets.add(new DataModels.SetLog(reps, weight, rpe));
                    }
                }

                var exerciseName = exerciseData["name"] as Lang.String;
                var exercise = new DataModels.Exercise(exerciseName, null, null, null, null);
                exercises.add(new DataModels.ExerciseLog(exercise, sets));
            }

            var templateName = template["name"] as Lang.String;
            var programType = template["programType"] as Lang.String?;
            result.add(new DataModels.WorkoutTemplate(templateName, exercises, programType));
        }
        return result;
    }

    function saveWorkoutLog(log as DataModels.WorkoutLog) as Void {
        var workoutLogs = loadData("workout_logs") as Lang.Array<DataModels.WorkoutLog>?;
        if (workoutLogs == null) {
            workoutLogs = new Lang.Array<DataModels.WorkoutLog>[0];
        }
        workoutLogs.add(log);
        saveData("workout_logs", workoutLogs);
    }

    function getLastWorkoutForExercise(exerciseName as Lang.String) as DataModels.WorkoutLog or Null {
        var workoutLogs = loadData("workout_logs") as Lang.Array<DataModels.WorkoutLog>?;
        if (workoutLogs == null) {
            return null;
        }

        for (var i = workoutLogs.size() - 1; i >= 0; i--) {
            var log = workoutLogs[i];
            if (log != null && log.exerciseDetails != null) {
                for (var j = 0; j < log.exerciseDetails.size(); j++) {
                    var exerciseLog = log.exerciseDetails[j];
                    if (exerciseLog != null && exerciseLog.exercise != null && exerciseLog.exercise.name.equals(exerciseName)) {
                        return log;
                    }
                }
            }
        }

        return null;
    }

    function getAnalytics() as Lang.Dictionary {
        var workoutLogs = loadData("workout_logs") as Lang.Array<DataModels.WorkoutLog>?;
        var weeklyVolume = 0;
        var squatPr = 0;
        var benchPr = 0;
        var deadliftPr = 0;

        if (workoutLogs == null) {
            return {
                "weeklyVolume" => weeklyVolume,
                "squatPr" => squatPr,
                "benchPr" => benchPr,
                "deadliftPr" => deadliftPr
            };
        }

        for (var i = 0; i < workoutLogs.size(); i++) {
            var log = workoutLogs[i];
            if (log == null || log.exerciseDetails == null || log.setsData == null) {
                continue;
            }

            for (var j = 0; j < log.exerciseDetails.size(); j++) {
                var exerciseLog = log.exerciseDetails[j];
                if (exerciseLog == null || exerciseLog.exercise == null || exerciseLog.exercise.name == null) {
                    continue;
                }

                var exerciseName = exerciseLog.exercise.name;
                
                for (var k = 0; k < log.setsData.size(); k++) {
                    var set = log.setsData[k];
                    if (set != null && set.reps != null && set.weight != null) {
                        weeklyVolume += set.reps * set.weight;

                        if (exerciseName.equals("Squat")) {
                            if (set.weight > squatPr) {
                                squatPr = set.weight;
                            }
                        } else if (exerciseName.equals("Barbell Bench Press")) {
                            if (set.weight > benchPr) {
                                benchPr = set.weight;
                            }
                        } else if (exerciseName.equals("Deadlift")) {
                            if (set.weight > deadliftPr) {
                                deadliftPr = set.weight;
                            }
                        }
                    }
                }
            }
        }

        return {
            "weeklyVolume" => weeklyVolume,
            "squatPr" => squatPr,
            "benchPr" => benchPr,
            "deadliftPr" => deadliftPr
        };
    }
}
