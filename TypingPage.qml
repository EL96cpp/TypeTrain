import QtQuick
import QtQuick.Window
import QtQuick.Shapes 1.5
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQml 2.3

Page {

    id: typing_page
    visible: false

    property bool wave_effect_visible

    property string typing_text
    property string language
    property string edit_color_dark:  "#2E5E0B"
    property string edit_color_light: "#4D9E13"
    property double start_time

    property int mistakes_counter
    property bool game_started
    property bool game_finished
    property int position
    property bool left_shift_active
    property bool right_shift_active

    property int minutes
    property int seconds

    property Item current_key

    signal backToChoosePage()

    function updateShiftsActiveValue() {

        left_shift_active = false;
        right_shift_active = false;

        for (var i = 0; i < first_row_model.count; ++i) {

            var first_row_element = first_row_model.get(i);

            if (first_row_element.shift_active_text == block2.text) {

                left_shift_active = (first_row_element.hand == "right");
                right_shift_active = (first_row_element.hand == "left");

            }

        }

        for (var i = 0; i < second_row_model.count; ++i) {

            var second_row_element = second_row_model.get(i);

            if (second_row_element.shift_active_text == block2.text) {

                left_shift_active = (second_row_element.hand == "right");
                right_shift_active = (second_row_element.hand == "left");

            }

        }

        for (var i = 0; i < third_row_model.count; ++i) {

            var third_row_element = third_row_model.get(i);

            if (third_row_element.shift_active_text == block2.text) {

                left_shift_active = (third_row_element.hand == "right");
                right_shift_active = (third_row_element.hand == "left");

            }

        }

        for (var i = 0; i < fourth_row_model.count; ++i) {

            var fourth_row_element = fourth_row_model.get(i);

            if (fourth_row_element.shift_active_text == block2.text) {

                left_shift_active = (fourth_row_element.hand == "right");
                right_shift_active = (fourth_row_element.hand == "left");

            }

        }

    }

    function setStartValues() {

        typing_page.game_started = false;
        typing_page.game_finished = false;
        typing_page.mistakes_counter = 0;
        typing_page.minutes = 0;
        typing_page.seconds = 0;

        first_row_model.setModelData();
        second_row_model.setModelData();
        third_row_model.setModelData();
        fourth_row_model.setModelData();

    }

    Image {

        id: background_image
        sourceSize.width: win_width
        anchors.centerIn: parent
        source: "qrc:/Images/background.jpg"

    }

    WaveEffect {
        id: waveEffect
        visible: wave_effect_visible
    }

    Rectangle {

        id: exit_image_rect
        width: 100
        height: 100
        radius: 10
        gradient: Gradient {

            GradientStop { position: 0.0; color: mouse_area.containsMouse ? "#90c2e978" : "#901c5c00"}
            GradientStop { position: 0.5; color: "#5F9300" }
            GradientStop { position: 1.0; color: mouse_area.containsMouse ? "#90c2e978" : "#901c5c00" }

        }

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 40


        Image {

            id: exit_image
            source: "qrc:/Images/exit_image.png"
            width: parent.width
            height: parent.height
            anchors.centerIn: parent


        }

        MouseArea {

            id: mouse_area
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {

               wave_effect_visible = false;
               timer.stop();
               backToChoosePage();

            }
        }
    }

    Rectangle {

        id: outer
        width: 1200
        height: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 200
        border.width: 3
        border.color: "black"
        color: typing_page.edit_color_light
        clip: true
        focus: true

        Keys.onPressed: (event)=>
                        {
                            if (typing_page.game_finished || ((left_shift_active || right_shift_active) && event.key == Qt.Key_Shift)) {

                                return;

                            }

                            if (!typing_page.game_started) {

                                typing_page.game_started = true;
                                timer.start();

                            }

                            var ch = event.text;

                            if(ch === container.getChar()) {

                                typing_page.position++;
                                typing_page.updateShiftsActiveValue();
                                block2.color = "#DFE210";

                            } else {

                                typing_page.mistakes_counter++;
                                block2.color = "red";

                            }

                            if (block2.text == "") {

                                typing_page.game_finished = true;
                                timer.stop();

                            }

                        }

        Row
        {

            id: container
            x: (outer.width / 2 - block1.contentWidth)
            y: 5
            focus: !typing_page.game_finished


            property string text: typing_page.typing_text

            function getChar()
            {
                return container.text[typing_page.position];
            }

            TextMetrics {

                id: metrics1
                text: block1.text
                font: block1.font

            }

            TextMetrics {

                id: metrics2
                text: block2.text
                font: block2.font

            }

            Text {

                id: block1
                text: container.text.substring(0, typing_page.position)
                font.pointSize: 50
                font.wordSpacing: 10
                color: "black"

            }

            Rectangle {

                id: text_background
                y: -5
                width: block2.text == " " ? 30 : metrics2.width + 10
                height: outer.height
                color: "#004740"

                Text {

                    id: block2
                    text: container.text.substring(typing_page.position, typing_page.position+1)
                    font.pointSize: 50
                    font.underline: true
                    font.wordSpacing: 10
                    color: "#DFE210"

                }
            }

            Text {

                id: block3
                text: container.text.substring(typing_page.position+1)
                font.pointSize: 50
                font.wordSpacing: 10
                color: "black"

            }


        }

        Rectangle {

            id: inner
            width: outer.width/2
            height: outer.height - outer.border.width*2
            anchors.verticalCenter: outer.verticalCenter
            anchors.right: outer.horizontalCenter
            color: "#EE004740"

        }




    }

    Timer {

        id: timer
        interval: 1000
        running: false
        repeat: true

        onTriggered: {

            if (typing_page.seconds == 59) {

                typing_page.minutes += 1;
                typing_page.seconds = 0;

            } else {

                typing_page.seconds += 1;

            }

        }

    }

    Rectangle {

        id: timer_rect
        width: 150
        height: 50
        radius: 10
        color: "#EE004740"
        border.width: 2
        border.color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 100

        Row {

            id: time_text_row
            anchors.centerIn: parent

            Text {

                id: minutes_text
                text: (typing_page.minutes >= 10) ? typing_page.minutes : "0" + typing_page.minutes
                color: "#e1e400"
                font.pointSize: 20
            }

            Text {

                id: seconds_text
                text: ":" + ((seconds >= 10) ? seconds : "0" + seconds)
                color: "#e1e400"
                font.pointSize: 20
            }


        }

    }

    //keyboard
    Item {

        id: keyboard
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: outer.bottom
        anchors.topMargin: 250

        property string language: typing_page.language


        Rectangle {

            id: main_rect
            radius: 30
            width: first_row.width + 2*keyboard_spacing
            height: button_height*5 + button_spacing*4 + keyboard_spacing*2
            anchors.centerIn: keyboard
            color: "#2b3a45"
            border.width: 2
            border.color: "black"

            property string color1: "#e1afae"
            property string color2: "#e2e2ae"
            property string color3: "#b0e2af"
            property string color4: "#b1e1e1"
            property string color5: "#dfb1de"
            property string color6: "#e1afae"
            property string color7: "#e2e2ae"
            property string color8: "#b0e2af"
            property string color9: "#6F87CB"
            property string default_color: "#395c59"
            property string selection_color: "#00C7B9"

            property int button_width: 70
            property int button_height: 50
            property int button_spacing: 10
            property int keyboard_spacing: 30


            //first row
            ListView {

                id: first_row
                width: main_rect.button_width * 13 + 130 + main_rect.button_spacing*14
                height: main_rect.button_height
                spacing: main_rect.button_spacing
                orientation: ListView.Horizontal
                interactive: false
                anchors.left: parent.left
                anchors.leftMargin: main_rect.keyboard_spacing
                anchors.top: main_rect.top
                anchors.topMargin: main_rect.keyboard_spacing

                ListModel {

                    id: first_row_model
                    property string shift_disabled_text
                    property string shift_active_text
                    property string color
                    property int button_width

                    function setModelData() {

                        first_row_model.clear();

                        if (typing_page.language == "eng") {

                            append( {shift_disabled_text : "`", shift_active_text : "~",
                                     color : main_rect.color1, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "1", shift_active_text : "!",
                                     color : main_rect.color1, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "2", shift_active_text : "@",
                                     color : main_rect.color1, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "3", shift_active_text : "#",
                                     color : main_rect.color2, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "4", shift_active_text : "$",
                                     color : main_rect.color3, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "5", shift_active_text : "%",
                                     color : main_rect.color4, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "6", shift_active_text : "^",
                                     color : main_rect.color4, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "7", shift_active_text : "&",
                                     color : main_rect.color5, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "8", shift_active_text : "*",
                                     color : main_rect.color6, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "9", shift_active_text : "(",
                                     color : main_rect.color7, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "0", shift_active_text : ")",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "-", shift_active_text : "_",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "=", shift_active_text : "+",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "Backspace", shift_active_text : "Backspace",
                                     color : main_rect.default_color, button_width : 130, hand: "right"});


                        } else {

                            append( {shift_disabled_text : "ё", shift_active_text : "Ё",
                                     color : main_rect.color1, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "1", shift_active_text : "!",
                                     color : main_rect.color1, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "2", shift_active_text : "\"",
                                     color : main_rect.color1, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "3", shift_active_text : "№",
                                     color : main_rect.color2, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "4", shift_active_text : ";",
                                     color : main_rect.color3, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "5", shift_active_text : "%",
                                     color : main_rect.color4, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "6", shift_active_text : "^",
                                     color : main_rect.color4, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "7", shift_active_text : "?",
                                     color : main_rect.color5, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "8", shift_active_text : "*",
                                     color : main_rect.color6, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "9", shift_active_text : "(",
                                     color : main_rect.color7, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "0", shift_active_text : ")",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "-", shift_active_text : "_",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "=", shift_active_text : "+",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "Backspace", shift_active_text : "Backspace",
                                     color : main_rect.default_color, button_width : 130, hand: "right"});


                        }


                    }

                }

                model: first_row_model

                delegate: Rectangle {

                    id: deleg_rect_first
                    width: model.button_width
                    height: main_rect.button_height
                    radius: 10
                    color: first_row_text.text == block2.text ? main_rect.selection_color : model.color
                    border.width: 2
                    border.color: first_row_text.text == block2.text ? "white" : "black"

                    Text {

                        id: first_row_text
                        anchors.centerIn: parent
                        text: (left_shift_active || right_shift_active) ? model.shift_active_text : model.shift_disabled_text
                        color: text == block2.text ? "white" : "black"
                        font.pointSize: 20

                    }

                }

            }


            ListView {

                id: second_row
                width: first_row.width
                height: main_rect.button_height
                spacing: main_rect.button_spacing
                orientation: ListView.Horizontal
                interactive: false
                anchors.left: main_rect.left
                anchors.leftMargin: main_rect.keyboard_spacing
                anchors.top: first_row.bottom
                anchors.topMargin: main_rect.button_spacing
                
                ListModel {

                    id: second_row_model
                    property string shift_disabled_text
                    property string shift_active_text
                    property string color
                    property int button_width

                    function setModelData() {

                        second_row_model.clear();

                        if (typing_page.language == "eng") {

                            append( {shift_disabled_text : "Tab", shift_active_text : "Tab",
                                     color : main_rect.default_color, button_width : 120, hand: "left"});
                            append( {shift_disabled_text : "q", shift_active_text : "Q",
                                     color : main_rect.color1, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "w", shift_active_text : "W",
                                     color : main_rect.color2, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "e", shift_active_text : "E",
                                     color : main_rect.color3, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "r", shift_active_text : "R",
                                     color : main_rect.color4, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "t", shift_active_text : "T",
                                     color : main_rect.color4, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "y", shift_active_text : "Y",
                                     color : main_rect.color5, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "u", shift_active_text : "U",
                                     color : main_rect.color5, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "i", shift_active_text : "I",
                                     color : main_rect.color6, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "o", shift_active_text : "O",
                                     color : main_rect.color7, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "p", shift_active_text : "P",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "[", shift_active_text : "{",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "]", shift_active_text : "}",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "\\", shift_active_text : "|",
                                     color : main_rect.color8, button_width : main_rect.button_width + 10, hand: "right"});

                        } else {

                            append( {shift_disabled_text : "Tab", shift_active_text : "Tab",
                                     color : main_rect.default_color, button_width : 120, hand: "left"});
                            append( {shift_disabled_text : "й", shift_active_text : "Й",
                                     color : main_rect.color1, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "ц", shift_active_text : "Ц",
                                     color : main_rect.color2, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "у", shift_active_text : "У",
                                     color : main_rect.color3, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "к", shift_active_text : "К",
                                     color : main_rect.color4, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "е", shift_active_text : "Е",
                                     color : main_rect.color4, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "н", shift_active_text : "Н",
                                     color : main_rect.color5, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "г", shift_active_text : "Г",
                                     color : main_rect.color5, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "ш", shift_active_text : "Ш",
                                     color : main_rect.color6, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "щ", shift_active_text : "Щ",
                                     color : main_rect.color7, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "з", shift_active_text : "З",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "х", shift_active_text : "Х",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "ъ", shift_active_text : "Ъ",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "\\", shift_active_text : "/",
                                     color : main_rect.color8, button_width : main_rect.button_width + 10, hand: "right"});


                        }


                    }

                }
                
                
                model: second_row_model

                delegate: Rectangle {

                    id: deleg_rect_second
                    width: model.button_width
                    height: main_rect.button_height
                    radius: 10
                    color: second_row_text.text == block2.text ? main_rect.selection_color : model.color
                    border.width: 2
                    border.color: second_row_text.text == block2.text ? "white" : "black"

                    Text {

                        id: second_row_text
                        anchors.centerIn: parent
                        text: (left_shift_active || right_shift_active) ? model.shift_active_text : model.shift_disabled_text
                        color: text == block2.text ? "white" : "black"
                        font.pointSize: 20

                    }

                }

            }



            //Third row
            ListView {

                id: third_row
                width: first_row.width
                height: main_rect.button_height
                spacing: main_rect.button_spacing
                orientation: ListView.Horizontal
                interactive: false
                anchors.left: main_rect.left
                anchors.leftMargin: main_rect.keyboard_spacing
                anchors.top: second_row.bottom
                anchors.topMargin: main_rect.button_spacing

                ListModel {

                    id: third_row_model
                    property string shift_disabled_text
                    property string shift_active_text
                    property string color
                    property int button_width

                    function setModelData() {

                        third_row_model.clear();

                        if (typing_page.language == "eng") {

                            append( {shift_disabled_text : "CapsLock", shift_active_text : "CapsLock",
                                     color : main_rect.default_color, button_width : 140, hand: "left"});
                            append( {shift_disabled_text : "a", shift_active_text : "A",
                                     color : main_rect.color1, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "s", shift_active_text : "S",
                                     color : main_rect.color2, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "d", shift_active_text : "D",
                                     color : main_rect.color3, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "f", shift_active_text : "F",
                                     color : main_rect.color4, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "g", shift_active_text : "G",
                                     color : main_rect.color4, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "h", shift_active_text : "H",
                                     color : main_rect.color5, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "j", shift_active_text : "J",
                                     color : main_rect.color5, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "k", shift_active_text : "K",
                                     color : main_rect.color6, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "l", shift_active_text : "L",
                                     color : main_rect.color7, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : ";", shift_active_text : ":",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "'", shift_active_text : "\"",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "Enter", shift_active_text : "Enter",
                                     color : main_rect.default_color, button_width : 140, hand: "right"});

                        } else {

                            append( {shift_disabled_text : "CapsLock", shift_active_text : "CapsLock",
                                     color : main_rect.default_color, button_width : 140, hand: "left"});
                            append( {shift_disabled_text : "ф", shift_active_text : "Ф",
                                     color : main_rect.color1, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "ы", shift_active_text : "Ы",
                                     color : main_rect.color2, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "в", shift_active_text : "В",
                                     color : main_rect.color3, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "а", shift_active_text : "А",
                                     color : main_rect.color4, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "п", shift_active_text : "П",
                                     color : main_rect.color4, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "р", shift_active_text : "Р",
                                     color : main_rect.color5, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "о", shift_active_text : "О",
                                     color : main_rect.color5, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "л", shift_active_text : "Л",
                                     color : main_rect.color6, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "д", shift_active_text : "Д",
                                     color : main_rect.color7, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "ж", shift_active_text : "Ж",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "э", shift_active_text : "Э",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "Enter", shift_active_text : "Enter",
                                     color : main_rect.default_color, button_width : 140, hand: "right"});


                        }


                    }

                }


                model: third_row_model

                delegate: Rectangle {

                    id: deleg_rect_third
                    width: model.button_width
                    height: main_rect.button_height
                    radius: 10
                    color: third_row_text.text == block2.text ? main_rect.selection_color : model.color
                    border.width: 2
                    border.color: third_row_text.text == block2.text ? "white" : "black"

                    Text {

                        id: third_row_text
                        anchors.centerIn: parent
                        text: (left_shift_active || right_shift_active) ? model.shift_active_text : model.shift_disabled_text
                        color: text == block2.text ? "white" : "black"
                        font.pointSize: 20

                    }

                }

            }

            //Fourth row
            ListView {

                id: fourth_row
                width: first_row.width
                height: main_rect.button_height
                spacing: main_rect.button_spacing
                orientation: ListView.Horizontal
                interactive: false
                anchors.left: main_rect.left
                anchors.leftMargin: main_rect.keyboard_spacing
                anchors.top: third_row.bottom
                anchors.topMargin: main_rect.button_spacing

                ListModel {

                    id: fourth_row_model
                    property string shift_disabled_text
                    property string shift_active_text
                    property string color
                    property int button_width

                    function setModelData() {

                        fourth_row_model.clear();

                        if (typing_page.language == "eng") {

                            append( {shift_disabled_text : "Shift", shift_active_text : "Shift",
                                     color : left_shift_active ? main_rect.selection_color : main_rect.default_color, button_width : 180, hand: "left"});
                            append( {shift_disabled_text : "z", shift_active_text : "Z",
                                     color : main_rect.color1, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "x", shift_active_text : "X",
                                     color : main_rect.color2, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "c", shift_active_text : "C",
                                     color : main_rect.color3, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "v", shift_active_text : "V",
                                     color : main_rect.color4, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "b", shift_active_text : "B",
                                     color : main_rect.color4, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "n", shift_active_text : "N",
                                     color : main_rect.color5, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "m", shift_active_text : "M",
                                     color : main_rect.color5, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : ",", shift_active_text : "<",
                                     color : main_rect.color6, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : ".", shift_active_text : ">",
                                     color : main_rect.color7, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "/", shift_active_text : "?",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "Shift", shift_active_text : "Shift",
                                     color : right_shift_active ? main_rect.selection_color : main_rect.default_color, button_width : 180, hand: "right"});

                        } else {

                            append( {shift_disabled_text : "Shift", shift_active_text : "Shift",
                                     color : left_shift_active ? main_rect.selection_color : main_rect.default_color, button_width : 180, hand: "left"});
                            append( {shift_disabled_text : "я", shift_active_text : "Я",
                                     color : main_rect.color1, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "ч", shift_active_text : "Ч",
                                     color : main_rect.color2, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "с", shift_active_text : "С",
                                     color : main_rect.color3, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "м", shift_active_text : "М",
                                     color : main_rect.color4, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "и", shift_active_text : "И",
                                     color : main_rect.color4, button_width : main_rect.button_width, hand: "left"});
                            append( {shift_disabled_text : "т", shift_active_text : "Т",
                                     color : main_rect.color5, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "ь", shift_active_text : "Ь",
                                     color : main_rect.color5, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "б", shift_active_text : "Б",
                                     color : main_rect.color6, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "ю", shift_active_text : "Ю",
                                     color : main_rect.color7, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : ".", shift_active_text : ",",
                                     color : main_rect.color8, button_width : main_rect.button_width, hand: "right"});
                            append( {shift_disabled_text : "Shift", shift_active_text : "Shift",
                                     color : right_shift_active ? main_rect.selection_color : main_rect.default_color, button_width : 180, hand: "right"});

                        }


                    }
                }


                model: fourth_row_model

                delegate: Component {

                    Loader {

                        source: switch(model.shift_active_text == "Shift") {

                                case true: return (model.hand == "left") ? "LeftShiftDelegate.qml" : "RightShiftDelegate.qml"
                                case false: return "ButtonDelegate.qml"

                        }

                    }

                }




            }


            //fifth row
            ListView {

                id: fifth_row
                width: first_row.width
                height: main_rect.button_height
                spacing: main_rect.button_spacing
                orientation: ListView.Horizontal
                interactive: false
                anchors.left: main_rect.left
                anchors.leftMargin: main_rect.keyboard_spacing
                anchors.top: fourth_row.bottom
                anchors.topMargin: main_rect.button_spacing

                model: [ { text: "Ctrl", color: main_rect.default_color, width: 90 },
                         { text: "Win", color: main_rect.default_color, width: 90 },
                         { text: "Alt", color: main_rect.default_color, width: 90 },
                         { text: " ", color: main_rect.color9, width: 470 },
                         { text: "Alt", color: main_rect.default_color, width: 90 },
                         { text: "Win", color: main_rect.default_color, width: 90 },
                         { text: "Menu", color: main_rect.default_color, width: 90 },
                         { text: "Ctrl", color: main_rect.default_color, width: 90 } ]

                delegate: Rectangle {

                    id: deleg_rect5
                    width: modelData.width
                    height: main_rect.button_height
                    radius: 10
                    color: modelData.text == block2.text ? main_rect.selection_color : modelData.color
                    border.width: 2
                    border.color: modelData.text == block2.text ? "white" : "black"

                    Text {

                        anchors.centerIn: parent
                        text: modelData.text
                        color: modelData.text == block2.text ? "white" : "black"
                        font.pointSize: 20

                    }

                }

            }

        }



    }

    Rectangle {

        id: dialog
        width: 700
        height: 300
        radius: 20
        border.width: 2
        border.color: "#185b17"
        visible: typing_page.game_finished

        gradient: Gradient {

            GradientStop { position: 0.0; color: "#e00b2400" }
            GradientStop { position: 0.5; color: "#e01c5c00" }
            GradientStop { position: 1.0; color: "#e00b2400" }

        }

        anchors.top: outer.bottom
        anchors.topMargin: -50
        anchors.horizontalCenter: parent.horizontalCenter

        Text {

            id: result_title
            text: "Results"
            color: "white"
            anchors.top: dialog.top
            anchors.topMargin: 10
            anchors.horizontalCenter: dialog.horizontalCenter
            font.pointSize: 30
            font.bold: true

        }

        Column {

            id: left_column
            anchors.top: result_title.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 100
            spacing: 20

            Text {

                id: result_mistakes_text
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Mistakes:"
                font.pointSize: 25
                color: "white"

            }

            Text {

                id: result_time_text
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Total time:"
                font.pointSize: 25
                color: "white"

            }

            Button {

                id: restart_button
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Restart"
                font.pointSize: 20
                width: 200
                height: 50

                background: Rectangle {

                    color: restart_button.hovered ? button_hover_color : button_color
                    border.width: 2
                    border.color: restart_button.hovered ? button_border_hover_color : button_border_color
                    radius: 10

                }

                onClicked: {

                    typing_page.game_started = false;
                    typing_page.game_finished = false;
                    typing_page.position = 0;
                    typing_page.mistakes_counter = 0;
                    typing_page.start_time = 0;
                    typing_page.minutes = 0;
                    typing_page.seconds = 0;

                }

            }

        }

        Column {

            id: right_column
            anchors.top: result_title.bottom
            anchors.topMargin: 30
            anchors.right: parent.right
            anchors.rightMargin: 100
            spacing: 20

            Text {

                id: result_mistakes_data
                anchors.horizontalCenter: parent.horizontalCenter
                text: typing_page.mistakes_counter
                font.pointSize: 25
                color: "white"

            }

            Text {

                id: result_time_data
                anchors.horizontalCenter: parent.horizontalCenter
                text: minutes_text.text + seconds_text.text
                font.pointSize: 25
                color: "white"

            }

            Button {

                id: exit_button
                anchors.horizontalCenter: parent.horizontalCenter
                text:"Exit"
                font.pointSize: 20
                width: 200
                height: 50

                background: Rectangle {

                    color: exit_button.hovered ? button_hover_color : button_color
                    border.width: 2
                    border.color: exit_button.hovered ? button_border_hover_color : button_border_color
                    radius: 10

                }

                onClicked: {

                    wave_effect_visible = false;
                    backToChoosePage();

                }

            }

        }

    }

}

