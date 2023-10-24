import QtQuick
import QtQuick.Window
import QtQuick.Shapes 1.5
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQml 2.3

Rectangle {

    id: left_shift_delegate
    width: model.button_width
    height: main_rect.button_height
    radius: 10
    color: typing_page.left_shift_active ? main_rect.selection_color : main_rect.default_color
    border.width: 2
    border.color: typing_page.left_shift_active ? "white" : "black"


    Text {

        id: left_shift_text
        anchors.centerIn: parent
        text: "Shift"
        color: typing_page.left_shift_active ? "white" : "black"
        font.pointSize: 20

    }

}
