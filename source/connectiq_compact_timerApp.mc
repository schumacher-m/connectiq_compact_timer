using Toybox.Application as App;

class connectiq_compact_timerApp extends App.AppBase {
    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        return [ new connectiq_compact_timerView() ];
    }
}