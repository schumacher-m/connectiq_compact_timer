using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as System;
using Toybox.Time as Time;

class connectiq_compact_timerView extends Ui.DataField {
    hidden var elapsedTime;
    hidden var currentTime;
    hidden var is24Hour;

    function initialize() {
        DataField.initialize();
        elapsedTime = 0;
        currentTime = System.getClockTime();
        is24Hour = System.getDeviceSettings().is24Hour;
    }

    function onLayout(dc) {
        if(is24Hour == false) {
            View.setLayout(Rez.Layouts.MainLayoutAmPm(dc));
            var amPmLabel = View.findDrawableById("amPmLabel");
            var amPmStaticLabel = View.findDrawableById("amPmStaticLabel");
            amPmLabel.locY = amPmLabel.locY + 21;
            amPmLabel.locX = amPmLabel.locX + 37;
            amPmStaticLabel.locY = amPmStaticLabel.locY + 28;
            amPmStaticLabel.locX = amPmStaticLabel.locX + 37;
        } else {
            View.setLayout(Rez.Layouts.MainLayout(dc));
        }

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
        currentTime = System.getClockTime();
    }

    function onUpdate(dc) {
        View.findDrawableById("Background").setColor(getBackgroundColor());
        var elapsedTimeLabel = View.findDrawableById("elapsedTimeLabel");
        var currentTimeLabel = View.findDrawableById("currentTimeLabel");
        var elapsedTimeHeaderLabel = View.findDrawableById("elapsedTimeHeaderLabel");
        var currentTimeHeaderLabel = View.findDrawableById("currentTimeHeaderLabel");

        var amPmLabel = View.findDrawableById("amPmLabel");
        var amPmStaticLabel = View.findDrawableById("amPmStaticLabel");

        if (getBackgroundColor() == Gfx.COLOR_BLACK) {
            elapsedTimeLabel.setColor(Gfx.COLOR_WHITE);
            currentTimeLabel.setColor(Gfx.COLOR_WHITE);
            elapsedTimeHeaderLabel.setColor(Gfx.COLOR_WHITE);
            currentTimeHeaderLabel.setColor(Gfx.COLOR_WHITE);
            if(is24Hour == false) {
                amPmLabel.setColor(Gfx.COLOR_WHITE);
                amPmStaticLabel.setColor(Gfx.COLOR_WHITE);
            }
        } else {
            elapsedTimeLabel.setColor(Gfx.COLOR_BLACK);
            currentTimeLabel.setColor(Gfx.COLOR_BLACK);
            elapsedTimeHeaderLabel.setColor(Gfx.COLOR_BLACK);
            currentTimeHeaderLabel.setColor(Gfx.COLOR_BLACK);
            if(is24Hour == false) {
                amPmLabel.setColor(Gfx.COLOR_BLACK);
                amPmStaticLabel.setColor(Gfx.COLOR_BLACK);
            }
        }

        var seconds = (elapsedTime / 1000) % 60 ;
        var minutes = ((elapsedTime / (1000 * 60)) % 60);
        var hours   = ((elapsedTime / (1000 * 60 * 60)) % 24);

        var currentHours = currentTime.hour;
        var currentMinutes = currentTime.min;

        if(is24Hour == false) {
             var meridian = "";
             var meridianStatic = "";
             if(currentHours == 0 && currentMinutes <= 59){
                currentHours += 12;
                meridian = "A";
                meridianStatic = "M";
            }else if(currentHours >= 1 && currentHours <= 11){
                meridian = "A";
                meridianStatic = "M";
            }else if(currentHours == 12 && currentMinutes <= 59){
                meridian = "P";
                meridianStatic = "M";
            }else if(currentHours >= 13 && currentHours <= 23){
                currentHours -= 12;
                meridian = "P";
                meridianStatic = "M";
            }
            amPmLabel.setText(meridian);
            amPmStaticLabel.setText(meridianStatic);
        }

        elapsedTimeLabel.setText(format("$1$:$2$:$3$", [hours.format("%02d"),
                                                       minutes.format("%02d"),
                                                       seconds.format("%02d")]));
        currentTimeLabel.setText(format("$1$:$2$:$3$", [currentHours.format("%02d"),
                                                       currentMinutes.format("%02d"),
                                                       currentTime.sec.format("%02d")]));
        View.onUpdate(dc);
    }
}