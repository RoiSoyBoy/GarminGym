import Toybox.Lang;
import Toybox.ActivityMonitor;
import Toybox.System;

module BiometricService {

    function getBiometricData() as DataModels.BiometricCache {
        var info = ActivityMonitor.getInfo();
        var bodyBattery = 0;

        if (info has :bodyBattery && info.bodyBattery != null) {
            bodyBattery = info.bodyBattery;
        }

        return new DataModels.BiometricCache(0, bodyBattery);
    }
}
