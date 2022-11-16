import QtQuick
import QtQuick.Controls

ApplicationWindow {
  width: 1920
  height: 1080
  visible: true
  title: qsTr("Color Wheel")

  //  Material.theme: Material.Dark
  //  Material.accent: Material.Orange
  Pane {
    height: parent.height
    width: 100

    Column {
      width: parent.width
      spacing: 24

      ColorTool {
        id: colorTool
        width: 80
        height: 80

        primary: "purple"
        secondary: "orange"

        //        onPrimaryClicked: console.log("ColorTool Primary Clicked", primary)
        //        onSecondaryClicked: console.log("ColorTool Secondary Clicked", secondary)
        onCurrentColorChanged: colorDialog.color = currentColor
        onPrimaryDoubleClicked: colorDialog.open()
        onSecondaryDoubleClicked: colorDialog.open()
      }
    }
  }

  ColorPickerDialog {
    id: colorDialog
    width: 450
    height: 700
    title: qsTr("Color Picker")
    onAccepted: colorTool.primaryFirstPlane ? (colorTool.primary = color) : (colorTool.secondary = color)
  }
}
