import QtQuick
import QtQuick.Window
import QtQuick.Shapes 1.5
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

Page {

    id: language_choose_page

    width: win.width
    height: win.height

    Image {

        sourceSize.width: win_width
        anchors.centerIn: parent
        source: "qrc:/Images/background.jpg"

    }

    WaveEffect {
        id: waveEffect

    }

    Rectangle {

    id: main_label_rect
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 100
    width: main_label_metrics.width * 1.2
    height: win_height - main_label_rect.anchors.topMargin * 2
    radius: 20

    gradient: Gradient {

        GradientStop { position: 0.0; color: "#e00b2400" }
        GradientStop { position: 0.4; color: "#901c5c00" }
        GradientStop { position: 1.0; color: "#e00b2400" }

    }

        Label {

            id: main_label
            text: "Type Train"
            font.family: custom_font.name
            font.pointSize: 150
            color: "white"
            style: Text.Outline
            styleColor: "lightgreen"


            anchors.horizontalCenter: parent.horizontalCenter

            TextMetrics {

                id: main_label_metrics
                text: main_label.text
                font: main_label.font

            }


        }


        RoundButton {

            id: eng_lang_button
            width: button_width
            height: button_height

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: main_label.bottom
            anchors.topMargin: height/2

            text: "English"
            font.family: custom_font.name
            font.pixelSize: 35

            background: Rectangle {

                color: eng_lang_button.hovered ? button_hover_color : button_color
                border.width: 2
                border.color: eng_lang_button.hovered ? button_border_hover_color : button_border_color
                radius: 20

            }

            onClicked: {
                toEnglishPage();
            }

        }

        RoundButton {

            id: rus_lang_button
            width: button_width
            height: button_height

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: eng_lang_button.bottom
            anchors.topMargin: height/2

            text: "Russian"
            font.pixelSize: 35
            font.family: custom_font.name


            background: Rectangle {

                color: rus_lang_button.hovered ? button_hover_color : button_color
                border.width: 2
                border.color: rus_lang_button.hovered ? button_border_hover_color : button_border_color
                radius: 20

            }

            onClicked: {
                toRussianPage();
            }

        }
    }

}
