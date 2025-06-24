import Toybox.Lang;
import Toybox.Communications;
import Toybox.System;

module SyncService {

    function syncWorkoutLog(log as DataModels.WorkoutLog) as Void {
        var url = "https://your-backend-url.com/api/workout";
        var params = {
            "timestamp" => log.timestamp,
            "templateUsed" => log.templateUsed.name,
            "exercises" => []
        };

        for (var i = 0; i < log.exerciseDetails.size(); i++) {
            var exerciseLog = log.exerciseDetails[i];
            var exercise = {
                "name" => exerciseLog.exercise.name,
                "sets" => []
            };
            for (var j = 0; j < log.setsData.size(); j++) {
                var setLog = log.setsData[j];
                exercise["sets"].add({
                    "reps" => setLog.reps,
                    "weight" => setLog.weight,
                    "rpe" => setLog.rpe
                });
            }
            params["exercises"].add(exercise);
        }

        var options = {
            :method => Communications.HTTP_REQUEST_METHOD_POST,
            :headers => {
                "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON
            },
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };

        Communications.makeWebRequest(url, params, options, new Lang.Method(SyncService, :onSyncComplete));
    }

    function onSyncComplete(responseCode as Lang.Number, data as Lang.Dictionary or Null) as Void {
        if (responseCode == 200) {
            System.println("Sync complete");
        } else {
            System.println("Sync failed with code: " + responseCode);
        }
    }
}
