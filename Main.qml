import QtQuick
import QtQuick.Controls

import ColorPicker
import Origin

ApplicationWindow {
  width: 1920
  height: 1080
  visible: true
  title: qsTr("Color Wheel")

  palette: theme.dark

  Themes {
    id: theme
  }

  Rectangle {
    id: rect
    anchors.centerIn: parent
    width: 200
    height: width
    color: "transparent"
    border.color: "black"

    MouseArea {
      anchors.fill: parent

      onDoubleClicked: {
        colorDialog.color = rect.color
        colorDialog.open()
      }
    }
  }

  Component.onCompleted: colorDialog.open()

  ColorPickerDialog {
    id: colorDialog
    anchors.centerIn: Overlay.overlay
    title: qsTr("Color Picker")

    color: "red"
    onAccepted: rect.color = colorDialog.color
  }
}
