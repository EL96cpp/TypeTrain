import QtQuick
import QtQuick.Window
import QtQuick.Shapes 1.5
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Window {

    id: win
    property int win_width: 1700
    property int win_height: 980
    property int button_width: 400
    property int button_height: 100

    property string button_color: "#5fc317"
    property string button_hover_color: "#7fe733"
    property string button_border_color: "#234808"
    property string button_border_hover_color: "#c9f291"

    function toEnglishPage() {
        stack_view.push(eng_choose_page, {wave_effect_visible: true});
    }

    function toRussianPage() {
        stack_view.push(rus_choose_page, {wave_effect_visible: true});
    }

    function toMainPage() {
        stack_view.pop(language_choose_page, {wave_effect_visible: true});
    }


    Connections {

        target: TxtReader
        onReturnTextToQML: {

            stack_view.push(typing_page, {language: language, typing_text: lesson_text, mistakes_counter: 0, position: 0,
                                          minutes: 0, seconds: 0, game_started: false, game_finished: false,
                                          wave_effect_visible: true});
            typing_page.setStartValues();
            typing_page.updateShiftsActiveValue();

        }

        onOpenTxtError: {

            txt_error_dialog.txt_file_path = file_path;
            txt_error_dialog.visible = true;

        }

    }


    Connections {

        target: typing_page
        onBackToChoosePage: {
            stack_view.pop();
        }

    }


    width: win_width
    height: win_height
    visible: true
    title: qsTr("TypeTrain")
    maximumWidth: width
    maximumHeight: height
    minimumWidth: width
    minimumHeight: height

    FontLoader {

        id: logo_font
        source: "qrc:/Fonts/Font.ttf"

    }


    FontLoader {

        id: typing_font
        source: "qrc:/Fonts/TypingFont.ttf"

    }

    StackView {

        id: stack_view
        anchors.fill: parent
        initialItem: language_choose_page

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 1
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 1
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 1
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 1
            }
        }

    }

    TypingPage {
        id: typing_page
    }

    EnglishPage {
        id: eng_choose_page
    }

    RussianPage {
        id: rus_choose_page
    }

    LangChoosePage {
        id: language_choose_page
    }

    Rectangle {

        id: txt_error_dialog
        width: 700
        height: 300
        radius: 20
        border.width: 2
        border.color: "#185b17"
        visible: false

        property string txt_file_path

        gradient: Gradient {

            GradientStop { position: 0.0; color: "#e00b2400" }
            GradientStop { position: 0.5; color: "#e01c5c00" }
            GradientStop { position: 1.0; color: "#e00b2400" }

        }

        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Text {

            id: txt_error_title
            text: "Txt file error!"
            color: "white"
            anchors.top: txt_error_dialog.top
            anchors.topMargin: 20
            anchors.horizontalCenter: txt_error_dialog.horizontalCenter
            font.pointSize: 30
            font.bold: true

        }

        Text {

            id: txt_error_text
            text: "Can't open file " + txt_error_dialog.txt_file_path
            color: "white"
            anchors.top: txt_error_title.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: txt_error_dialog.horizontalCenter
            font.pointSize: 20
            font.bold: false

        }

        Button {

            id: ok_button
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: txt_error_text.bottom
            anchors.topMargin: 30
            text:"Ok"
            font.pointSize: 20
            width: 200
            height: 50

            background: Rectangle {

                color: ok_button.hovered ? button_hover_color : button_color
                border.width: 2
                border.color: ok_button.hovered ? button_border_hover_color : button_border_color
                radius: 10

            }

            onClicked: {

                txt_error_dialog.visible = false;
                txt_error_dialog.txt_file_path = "";

            }

        }

    }
}
