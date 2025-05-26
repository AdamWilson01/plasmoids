import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Item {
    width: 200
    height: 50

    PlasmaCore.Battery {
        id: battery
    }

    Timer {
        interval: 60000 // refresh every 60 seconds
        running: true
        repeat: true
        onTriggered: displayBattery()
    }

    function displayBattery() {
        let percent = Math.round(battery.percent);
        let bars = Math.floor(percent / 20); // 5 blocks
        let ascii = "[" + "#".repeat(bars) + " ".repeat(5 - bars) + "]";
        batteryText.text = percent + "% == " + ascii;
    }

    Text {
        id: batteryText
        anchors.centerIn: parent
        text: ""
        font.pixelSize: 20
    }

    Component.onCompleted: displayBattery()
}