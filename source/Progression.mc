import Toybox.Lang;
import Toybox.System;

module Progression {

    class ProgressionScheme {
        function suggestNextWorkout(lastWorkout as DataModels.WorkoutLog) as DataModels.WorkoutTemplate {
            // This is a placeholder implementation.
            // A real implementation would analyze the last workout and suggest the next one.
            return lastWorkout.templateUsed;
        }
    }

    class LinearProgression extends ProgressionScheme {
        private var _increment as Lang.Number;

        function initialize(options as {
            :increment as Lang.Number
        }) {
            ProgressionScheme.initialize();
            _increment = options[:increment];
        }

        function suggestNextWorkout(lastWorkout as DataModels.WorkoutLog) as DataModels.WorkoutTemplate {
            System.println("Suggesting next workout with linear progression");
            var nextTemplate = lastWorkout.templateUsed;
            var newExercises = new Lang.Array<DataModels.ExerciseLog>[0];
            for (var i = 0; i < nextTemplate.exercises.size(); i++) {
                var exerciseLog = lastWorkout.exerciseDetails[i];
                var lastSet = exerciseLog.sets[exerciseLog.sets.size() - 1];
                var newExercise = new DataModels.Exercise(
                    exerciseLog.exercise.name,
                    exerciseLog.exercise.muscleGroups,
                    exerciseLog.exercise.equipment,
                    exerciseLog.exercise.customTags,
                    exerciseLog.exercise.formCuesRef
                );
                
                var newSets = new Lang.Array<DataModels.SetLog>[0];
                for (var j = 0; j < exerciseLog.sets.size(); j++) {
                    newSets.add(new DataModels.SetLog(lastSet.reps, lastSet.weight + _increment, null));
                }

                newExercises.add(new DataModels.ExerciseLog(newExercise, newSets));
            }
            nextTemplate.exercises = newExercises;
            return nextTemplate;
        }
    }

    class DoubleProgression extends ProgressionScheme {
        private var _minReps as Lang.Number;
        private var _maxReps as Lang.Number;
        private var _increment as Lang.Number;

        function initialize(options as {
            :minReps as Lang.Number,
            :maxReps as Lang.Number,
            :increment as Lang.Number
        }) {
            ProgressionScheme.initialize();
            _minReps = options[:minReps];
            _maxReps = options[:maxReps];
            _increment = options[:increment];
        }

        function suggestNextWorkout(lastWorkout as DataModels.WorkoutLog) as DataModels.WorkoutTemplate {
            System.println("Suggesting next workout with double progression");
            var nextTemplate = lastWorkout.templateUsed;
            var newExercises = new Lang.Array<DataModels.ExerciseLog>[0];
            for (var i = 0; i < nextTemplate.exercises.size(); i++) {
                var exerciseLog = lastWorkout.exerciseDetails[i];
                var lastSet = exerciseLog.sets[exerciseLog.sets.size() - 1];
                var newExercise = new DataModels.Exercise(
                    exerciseLog.exercise.name,
                    exerciseLog.exercise.muscleGroups,
                    exerciseLog.exercise.equipment,
                    exerciseLog.exercise.customTags,
                    exerciseLog.exercise.formCuesRef
                );

                var newWeight;
                var newReps;

                if (lastSet.reps >= _maxReps) {
                    // Increment weight, reset reps
                    newWeight = lastSet.weight + _increment;
                    newReps = _minReps;
                } else {
                    // Increment reps, same weight
                    newWeight = lastSet.weight;
                    newReps = lastSet.reps + 1;
                }

                var newSets = new Lang.Array<DataModels.SetLog>[0];
                for (var j = 0; j < exerciseLog.sets.size(); j++) {
                    newSets.add(new DataModels.SetLog(newReps, newWeight, null));
                }

                newExercises.add(new DataModels.ExerciseLog(newExercise, newSets));
            }
            nextTemplate.exercises = newExercises;
            return nextTemplate;
        }
    }
}
