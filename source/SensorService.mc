import Toybox.System;
import Toybox.Lang;
import Toybox.Sensor;
import Toybox.SensorHistory; // Optional

module SensorService {
    
    // Track which sensors are available on this device
    var availableSensors = [] as Array<Symbol>;
    var sensorDelegate = null;

    function initializeSensors() as Void {
        // Check device capabilities first
        checkDeviceCapabilities();
        
        // Enable available sensors
        enableAvailableSensors();
    }

    function checkDeviceCapabilities() as Void {
        availableSensors = [];
        
        try {
            var info = Sensor.getInfo();
            
            // Check for accelerometer
            if (info has :accel) {
                availableSensors.add(:accel);
                System.println("Accelerometer available");
            }

            // Check for gyroscope
            if (info has :gyroscope) {
                availableSensors.add(:gyroscope);
                System.println("Gyroscope available");
            }

            // Check for heart rate monitor
            if (info has :heartRate) {
                availableSensors.add(:heartRate);
                System.println("Heart Rate Monitor available");
            }

            // Check for pulse oximeter (newer devices)
            if (info has :oxygenSaturation) {
                availableSensors.add(:oxygenSaturation);
                System.println("Pulse Oximetry available");
            }

            // Check for temperature (some devices)
            if (info has :temperature) {
                availableSensors.add(:temperature);
                System.println("Temperature sensor available");
            }
            
        } catch (e) {
            System.println("Sensor capability check failed: " + e.getErrorMessage());
        }
    }

    function enableAvailableSensors() as Void {
        if (availableSensors.size() == 0) {
            System.println("No sensors available on this device");
            return;
        }

        try {
            // For Connect IQ, we typically don't need to explicitly enable sensors
            // They are enabled when you register a listener or call getInfo()
            System.println("Sensors ready for use");
            
        } catch (e) {
            System.println("Failed to prepare sensors: " + e.getErrorMessage());
        }
    }

    function registerDataListener(delegate) as Void {
        sensorDelegate = delegate;
        
        try {
            // Simple approach - most Connect IQ apps don't need complex listener registration
            // The sensor data will be available through Sensor.getInfo() when polled
            System.println("Sensor delegate registered for polling");
            
        } catch (e) {
            System.println("Failed to register sensor listener: " + e.getErrorMessage());
        }
    }

    function unregisterDataListener() as Void {
        try {
            sensorDelegate = null;
            System.println("Sensor data listener unregistered");
        } catch (e) {
            System.println("Failed to unregister sensor listener: " + e.getErrorMessage());
        }
    }

    // Polling method for devices that don't support listeners
    function pollSensorData() as Dictionary {
        var data = {};
        
        try {
            var sensorInfo = Sensor.getInfo();
            
            if (hasAccelerometer() && sensorInfo has :accel && sensorInfo.accel != null) {
                data[:accel] = sensorInfo.accel;
            }
            
            if (hasGyroscope() && sensorInfo has :gyroscope && sensorInfo.gyroscope != null) {
                data[:gyroscope] = sensorInfo.gyroscope;
            }
            
            if (hasHeartRate() && sensorInfo has :heartRate && sensorInfo.heartRate != null) {
                data[:heartRate] = sensorInfo.heartRate;
            }
            
            if (hasPulseOx() && sensorInfo has :oxygenSaturation && sensorInfo.oxygenSaturation != null) {
                data[:oxygenSaturation] = sensorInfo.oxygenSaturation;
            }
            
            if (hasTemperature() && sensorInfo has :temperature && sensorInfo.temperature != null) {
                data[:temperature] = sensorInfo.temperature;
            }
            
        } catch (e) {
            System.println("Error polling sensor data: " + e.getErrorMessage());
        }
        
        return data;
    }

    // Helper function to find index of sensor in array
    function findSensorIndex(sensorType as Symbol) as Number {
        return availableSensors.indexOf(sensorType);
    }

    // Helper functions to check sensor availability
    function hasAccelerometer() as Boolean {
        return findSensorIndex(:accel) != -1;
    }

    function hasGyroscope() as Boolean {
        return findSensorIndex(:gyroscope) != -1;
    }

    function hasHeartRate() as Boolean {
        return findSensorIndex(:heartRate) != -1;
    }

    function hasPulseOx() as Boolean {
        return findSensorIndex(:oxygenSaturation) != -1;
    }

    function hasTemperature() as Boolean {
        return findSensorIndex(:temperature) != -1;
    }

    function getAvailableSensors() as Array<Symbol> {
        return availableSensors;
    }

    // Generic sensor data handler
    function handleSensorData(sensorData as Dictionary) as Void {
        if (sensorData.hasKey(:accel) && sensorData[:accel] != null) {
            var accel = sensorData[:accel];
            if (accel instanceof Lang.Array && accel.size() >= 3) {
                System.println("Accel: X=" + accel[0] + " Y=" + accel[1] + " Z=" + accel[2]);
            }
        }
        
        if (sensorData.hasKey(:gyroscope) && sensorData[:gyroscope] != null) {
            var gyro = sensorData[:gyroscope];
            if (gyro instanceof Lang.Array && gyro.size() >= 3) {
                System.println("Gyro: X=" + gyro[0] + " Y=" + gyro[1] + " Z=" + gyro[2]);
            }
        }
        
        if (sensorData.hasKey(:heartRate) && sensorData[:heartRate] != null) {
            System.println("Heart Rate: " + sensorData[:heartRate] + " bpm");
        }
        
        if (sensorData.hasKey(:oxygenSaturation) && sensorData[:oxygenSaturation] != null) {
            System.println("SpO2: " + sensorData[:oxygenSaturation] + "%");
        }
        
        if (sensorData.hasKey(:temperature) && sensorData[:temperature] != null) {
            System.println("Temperature: " + sensorData[:temperature] + "°C");
        }
    }
}

/* Example usage in your main app:

class MyApp extends Application.AppBase {
    function onStart(state) {
        SensorService.initializeSensors();
        SensorService.registerDataListener(method(:onSensorData));
    }

    function onStop(state) {
        SensorService.unregisterDataListener();
    }

    function onSensorData(sensorData) {
        SensorService.handleSensorData(sensorData);
        
        // Or handle it yourself:
        // if (sensorData has :accel) {
        //     // Do something with accelerometer data
        // }
    }
}

// For devices without listener support, you can poll in your view:
class MyView extends Ui.View {
    function onUpdate(dc) {
        var sensorData = SensorService.pollSensorData();
        // Use the sensor data for your display
    }
}
*/
