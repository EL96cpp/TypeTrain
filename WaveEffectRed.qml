import QtQuick
import QtQuick.Window
import QtQuick.Shapes 1.5
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

Item {

    id: waveEffectRed
    property int wave_width: parent.width
    property int wave_height: parent.height

    Item {

        id: firstWave
        anchors.fill: parent

        property real slide: 0.0

        function wave() {
            let str = [ ];
            for (let j = 0; j<32; j++) {
                let a = j * 2 * Math.PI / 32;
                let i = Math.sin(a) * 1.2 + 16;
                str.push(`${j} ${i.toFixed(2)} `);
            }
            return str.join(" ");
        }

        Image {

            height: waveEffectRed.wave_height
            width: waveEffectRed.wave_width + 4 * waveEffectRed.wave_height
            x: -waveEffectRed.wave_height * 2 + firstWave.slide
            y: 200
            source: `data:image/svg+xml;utf8,<svg width="32" height="32">
            <rect width="32" height="32" fill="transparent"/>
            <path d="M ${firstWave.wave()} 32 16 32 32 0 32" fill="red" fill-opacity="0.3"/>
            </svg>`
            sourceSize: Qt.size(height, height)
            fillMode: Image.Tile
        }

        NumberAnimation {
            target: firstWave
            property: "slide"
            from: waveEffectRed.wave_height
            to: 0
            loops: Animation.Infinite
            running: true
            duration: 7000
        }
    }

    Item {

        id: secondWave
        anchors.fill: parent

        property real slide: 0.0

        function wave() {
            let str = [ ];
            for (let j = 0; j<32; j++) {
                let a = j * 2 * Math.PI / 32;
                let i = Math.sin(a) * 1.2 + 16;
                str.push(`${j} ${i.toFixed(2)} `);
            }
            return str.join(" ");
        }

        Image {

            height: waveEffectRed.wave_height
            width: waveEffectRed.wave_width + 4 * waveEffectRed.wave_height
            x: -waveEffectRed.wave_height * 2 + secondWave.slide
            y: 370
            source: `data:image/svg+xml;utf8,<svg width="32" height="32">
            <rect width="32" height="32" fill="transparent"/>
            <path d="M ${secondWave.wave()} 32 16 32 32 0 32" fill="red" fill-opacity="0.45"/>
            </svg>`
            sourceSize: Qt.size(height, height)
            fillMode: Image.Tile
        }

        NumberAnimation {
            target: secondWave
            property: "slide"
            from: waveEffectRed.wave_height
            to: 0
            loops: Animation.Infinite
            running: true
            duration: 10000
        }
    }
}
