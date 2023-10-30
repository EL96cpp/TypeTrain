import QtQuick
import QtQuick.Window
import QtQuick.Shapes 1.5
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Page {

    id: rus_choose_page
    visible: false

    property bool wave_effect_visible

    signal toTypingPage(letters : string)

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

        id: rus_grid_rect
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

            id: grid_rus
            interactive: false
            anchors.margins: 10
            anchors.centerIn: parent
            width: 1200
            height: 500

            cellWidth: 300
            cellHeight: 300

            model: ["ва ол", "фы дж", "ми ть", "еп нр", "ук гш", "чс бю", "йц щз", "я эхъ"]

            property int small_button_width: 200
            property int small_button_height: 200
            property int small_button_margin: 10
            property int font_size_value: 35


            delegate: RoundButton {

                id: rus_button
                width: grid_rus.small_button_width
                height: grid_rus.small_button_height
                Layout.minimumWidth: 200
                Layout.minimumHeight: 200
                Layout.maximumWidth: 200
                Layout.maximumHeight: 200

                text: modelData
                font.family: typing_font.name
                font.pointSize: grid_rus.font_size_value

                background: Rectangle {

                    color: rus_button.hovered ? button_hover_color : button_color
                    border.width: 2
                    border.color: rus_button.hovered ? button_border_hover_color : button_border_color
                    radius: 20

                }

                onClicked: {


                    TxtReader.readTxtFile("rus", rus_button.text);

                }


            }
        }
    }

    RoundButton {

        id: rus_return_button
        width: 300
        height: 50

        Layout.minimumWidth: 300
        Layout.minimumHeight: 50
        Layout.maximumWidth: 300
        Layout.maximumHeight: 50

        text: "Return"
        font.family: logo_font.name
        font.pointSize: 25

        anchors.right: rus_grid_rect.right
        anchors.top: rus_grid_rect.bottom
        anchors.topMargin: 20
        anchors.rightMargin: 20

        background: Rectangle {

            color: rus_return_button.hovered ? button_hover_color : button_color
            border.width: 2
            border.color: rus_return_button.hovered ? button_border_hover_color : button_border_color
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
