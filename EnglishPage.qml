import QtQuick
import QtQuick.Window
import QtQuick.Shapes 1.5
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Page {

    id: eng_choose_page
    visible: false
    width: win.width
    height: win.height

    property real slide: 0.0
    property bool wave_effect_visible

    Image {

        sourceSize.width: win_width
        anchors.centerIn: parent
        source: "qrc:/Images/background.jpg"

    }

    WaveEffect {
        id: waveEffect
        visible: wave_effect_visible
    }

    Rectangle {

        id: eng_grid_rect
        anchors.centerIn: parent
        width: win_width - 200
        height: win_height - 200
        radius: 20

        gradient: Gradient {

            GradientStop { position: 0.0; color: "#e00b2400" }
            GradientStop { position: 0.5; color: "#901c5c00" }
            GradientStop { position: 1.0; color: "#e00b2400" }

        }

        //Buttons
        GridView {

            id: grid_eng
            interactive: false
            anchors.margins: 10
            anchors.centerIn: parent
            width: 1200
            height: 500



            cellWidth: 300
            cellHeight: 300

            model: ["df jk", "as l;", "vb nm", "tg yh", "er ui", "qw op", "xc ,.", "z! ?/"]

            property int small_button_width: 200
            property int small_button_height: 200
            property int small_button_margin: 10
            property int font_size: 35

            delegate: RoundButton {

                id: eng_button
                width: grid_eng.small_button_width
                height: grid_eng.small_button_height
                Layout.minimumWidth: 200
                Layout.minimumHeight: 200
                Layout.maximumWidth: 200
                Layout.maximumHeight: 200

                text: modelData
                font.pixelSize: grid_eng.font_size

                background: Rectangle {

                    color: eng_button.hovered ? button_hover_color : button_color
                    border.width: 2
                    border.color: eng_button.hovered ? button_border_hover_color : button_border_color
                    radius: 20

                }

                onClicked: {

                    TxtReader.readTxtFile("eng", eng_button.text);

                }

            }
        }
    }

    RoundButton {

        id: eng_return_button
        width: 300
        height: 50

        Layout.minimumWidth: 300
        Layout.minimumHeight: 50
        Layout.maximumWidth: 300
        Layout.maximumHeight: 50

        text: "Return"
        font.pixelSize: grid_eng.font_size

        anchors.right: eng_grid_rect.right
        anchors.top: eng_grid_rect.bottom
        anchors.topMargin: 20
        anchors.rightMargin: 20

        background: Rectangle {

            color: eng_return_button.hovered ? button_hover_color : button_color
            border.width: 2
            border.color: eng_return_button.hovered ? button_border_hover_color : button_border_color
            radius: 20

        }

        onClicked: {
            wave_effect_visible = false;
            win.toMainPage();
        }

    }

    Keys.onPressed: (event)=>
    {

        if (event.key == Qt.Key_Space) {
            return;
        }

    }

}
