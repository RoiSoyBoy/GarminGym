import Toybox.Lang;
import Toybox.Attention;

module FormFeedback {

    class FormFeedbackManager {
        private var _targetTempo as Lang.Number;

        function initialize(options as {
            :targetTempo as Lang.Number
        }) {
            _targetTempo = options[:targetTempo];
        }

        function checkForm(currentRepDuration as Lang.Number) as Void {
            if (currentRepDuration < _targetTempo * 0.8) {
                if (Attention has :vibrate) {
                    Attention.vibrate([new Attention.VibeProfile(50, 100)]);
                }
            }
        }
    }
}
