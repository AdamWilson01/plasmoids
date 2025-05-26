import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Item {
    width: 250
    height: 50

    PlasmaCore.DataSource {
        id: pulseSource
        engine: "pulseaudio"
        connectedSources: ["default_sink"]

        onNewData: {
            updateVolume()
        }
    }

    function updateVolume() {
        let volumeRaw = pulseSource.data["default_sink"]["volume"];
        let volumePercent = Math.round(volumeRaw * 100);
        let bars = Math.floor(volumePercent / 10); // 10 blocks max
        let ascii = "[" + "!".repeat(bars) + " ".repeat(10 - bars) + "]";
        volumeText.text = volumePercent + "% == " + ascii;
    }

    Text {
        id: volumeText
        anchors.centerIn: parent
        text: ""
        font.pixelSize: 20
    }

    Timer {
        interval: 2000 // refresh every 2 seconds
        running: true
        repeat: true
        onTriggered: updateVolume()
    }

    Component.onCompleted: updateVolume()
}
