import QtQuick
import QtQuick.Window
import QtQuick.Shapes 1.5
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
//import Qt5Compat.GraphicalEffects

Item {

    id: waveEffect
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
                let i = Math.sin(a) * 1.2 + 20;
                str.push(`${j} ${i.toFixed(2)} `);
            }
            return str.join(" ");
        }

        Image {

            height: waveEffect.wave_height
            width: waveEffect.wave_width + 4 * waveEffect.wave_height
            x: -waveEffect.wave_height * 2 + firstWave.slide
            source: `data:image/svg+xml;utf8,<svg width="32" height="32">
            <path d="M ${firstWave.wave()} 32 20 32 32 0 32" fill="white" fill-opacity="0.3"/>
            </svg>`
            sourceSize: Qt.size(height, height)
            fillMode: Image.Tile
        }

        NumberAnimation {
            target: firstWave
            property: "slide"
            from: waveEffect.wave_height
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
                let i = Math.sin(a) * 1.2 + 27;
                str.push(`${j} ${i.toFixed(2)} `);
            }
            return str.join(" ");
        }

        Image {

            height: waveEffect.wave_height
            width: waveEffect.wave_width + 4 * waveEffect.wave_height
            x: -waveEffect.wave_height * 2 + secondWave.slide
            source: `data:image/svg+xml;utf8,<svg width="32" height="32">
            <path d="M ${secondWave.wave()} 32 27 32 32 0 32" fill="white" fill-opacity="0.45"/>
            </svg>`
            sourceSize: Qt.size(height, height)
            fillMode: Image.Tile
        }


        NumberAnimation {
            target: secondWave
            property: "slide"
            from: waveEffect.wave_height
            to: 0
            loops: Animation.Infinite
            running: true
            duration: 10000
        }
    }
}
