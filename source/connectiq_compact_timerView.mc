using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Time as Time;

class connectiq_compact_timerView extends Ui.DataField {
    hidden var elapsedTime;
    hidden var currentTime;

    function initialize() {
        DataField.initialize();
        elapsedTime = 0;
        currentTime = Sys.getClockTime();
    }

    function onLayout(dc) {
        View.setLayout(Rez.Layouts.MainLayout(dc));
        var elapsedTimeLabel = View.findDrawableById("elapsedTimeLabel");
        var currentTimeLabel = View.findDrawableById("currentTimeLabel");
        var currentTimeHeaderLabel = View.findDrawableById("currentTimeHeaderLabel");
        var elapsedTimeHeaderLabel = View.findDrawableById("elapsedTimeHeaderLabel");

        currentTimeHeaderLabel.setText(Rez.Strings.currentTimeHeaderLabel);
        elapsedTimeHeaderLabel.setText(Rez.Strings.elapsedTimeHeaderLabel);

        elapsedTimeHeaderLabel.locY = elapsedTimeHeaderLabel.locY - 25;
        elapsedTimeLabel.locY = elapsedTimeLabel.locY - 9;

        currentTimeHeaderLabel.locY = currentTimeHeaderLabel.locY + 8;
        currentTimeLabel.locY = currentTimeLabel.locY + 25;

        return true;
    }

    function compute(info) {
        elapsedTime = info.elapsedTime;
        currentTime = Sys.getClockTime();
    }

    function onUpdate(dc) {
        View.findDrawableById("Background").setColor(getBackgroundColor());
        var elapsedTimeLabel = View.findDrawableById("elapsedTimeLabel");
        var currentTimeLabel = View.findDrawableById("currentTimeLabel");
        var elapsedTimeHeaderLabel = View.findDrawableById("elapsedTimeHeaderLabel");
        var currentTimeHeaderLabel = View.findDrawableById("currentTimeHeaderLabel");

        if (getBackgroundColor() == Gfx.COLOR_BLACK) {
            elapsedTimeLabel.setColor(Gfx.COLOR_WHITE);
            currentTimeLabel.setColor(Gfx.COLOR_WHITE);
            elapsedTimeHeaderLabel.setColor(Gfx.COLOR_WHITE);
            currentTimeHeaderLabel.setColor(Gfx.COLOR_WHITE);
        } else {
            elapsedTimeLabel.setColor(Gfx.COLOR_BLACK);
            currentTimeLabel.setColor(Gfx.COLOR_BLACK);
            elapsedTimeHeaderLabel.setColor(Gfx.COLOR_BLACK);
            currentTimeHeaderLabel.setColor(Gfx.COLOR_BLACK);
        }

        var seconds = (elapsedTime / 1000) % 60 ;
        var minutes = ((elapsedTime / (1000 * 60)) % 60);
        var hours   = ((elapsedTime / (1000 * 60 * 60)) % 24);

        elapsedTimeLabel.setText(format("$1$:$2$:$3$", [hours.format("%02d"),
                                                       minutes.format("%02d"),
                                                       seconds.format("%02d")]));
        currentTimeLabel.setText(format("$1$:$2$:$3$", [currentTime.hour.format("%02d"),
                                                       currentTime.min.format("%02d"),
                                                       currentTime.sec.format("%02d")] ));
        View.onUpdate(dc);
    }
}