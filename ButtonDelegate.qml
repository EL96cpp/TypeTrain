import QtQuick
import QtQuick.Window
import QtQuick.Shapes 1.5
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQml 2.3

Rectangle {

    id: button_delegate
    width: model.button_width
    height: main_rect.button_height
    radius: 10
    color: fourth_row_text.text == block2.text ? main_rect.selection_color : model.color
    border.width: 2
    border.color: fourth_row_text.text == block2.text ? "white" : "black"


    Text {

        id: fourth_row_text
        anchors.centerIn: parent
        text: (left_shift_active || right_shift_active) ? model.shift_active_text : model.shift_disabled_text
        color: text == block2.text ? "white" : "black"
        font.pointSize: 20

    }

}
