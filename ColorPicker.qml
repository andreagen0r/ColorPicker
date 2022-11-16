import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import ColorTools

Item {
  id: root

  property alias color: internal.color
  property alias picking: eyedrop.checked

  property var pickingWindow: Window {
    visible: false
    color: "transparent"

    function stopPicking() {
      pickingWindow.close()
      pickingAction.trigger()
    }

    ColorPickerPreview {
      id: pickerPreview
      anchors.fill: parent
    }

    Item {
      anchors.fill: parent
      focus: true
      Keys.onEscapePressed: {
        internal.revertPicking()
        pickingWindow.stopPicking()
      }
    }

    MouseArea {
      id: mousePicker
      anchors.fill: parent
      hoverEnabled: true
      cursorShape: Qt.CrossCursor

      onPositionChanged: {
        const mousePosition = Qt.point(mouseX, mouseY)
        pickerPreview.setMousePosition(mousePosition)
        internal.eyedrop(mousePosition)
        pickerPreview.update()
      }

      onClicked: {
        pickingWindow.stopPicking()
        history.addToHistory(internal.color)
      }
    }
  }

  clip: true
  implicitWidth: col.implicitWidth
  implicitHeight: col.implicitHeight

  Component.onCompleted: pickingWindow.close()

  Action {
    id: pickingAction
    checkable: true
    shortcut: "P"
    onToggled: {
      if (checked && root.visible) {
        internal.startPicking()
        root.pickingWindow.showFullScreen()
      }
    }
  }

  ColorPicker_p {
    id: internal
  }

  ColumnLayout {
    id: col
    spacing: 12
    anchors.fill: parent

    RowLayout {
      Layout.fillWidth: true
      spacing: 12

      ColorSampler {
        id: sampler
        Layout.preferredWidth: 50
        Layout.preferredHeight: 50
        radius: 3
        color: internal.color
        onColorChanged: internal.setColor(color)
      }

      GroupBox {
        title: qsTr("History")
        Layout.fillWidth: true
        padding: 0
        topPadding: 24
        bottomPadding: 0

        ColorHistory {
          id: history
          anchors.fill: parent
          swatchSize: 30
          onColorChanged: internal.setColor(color)
        }
      }
    }

    Item {
      Layout.fillWidth: true
      Layout.minimumHeight: 250

      ColorWheel {
        id: colorWheel
        anchors.fill: parent
        color: internal.color
        onColorChanged: internal.setColor(color)
        onEditFinished: history.addToHistory(internal.color)
      }

      ToolButton {
        id: eyedrop
        width: 48
        height: width
        padding: 0
        horizontalPadding: 0
        verticalPadding: 0
        checkable: true
        display: AbstractButton.IconOnly
        icon.source: "assets/eyedropper.svg"
        action: pickingAction

        ToolTip.delay: 1500
        ToolTip.timeout: 3000
        ToolTip.text: "Shortcut \"P\""
        ToolTip.visible: hovered
      }

      Label {
        id: label
        anchors.right: txField.left
        anchors.verticalCenter: txField.verticalCenter
        anchors.rightMargin: 6
        text: "#"
      }

      TextField {
        id: txField
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        horizontalAlignment: Text.AlignHCenter
        inputMask: "HHHHHHhh"
        width: 90
        topPadding: 0
        bottomPadding: 0
        leftPadding: 6
        rightPadding: 6
        text: internal.color.toString().toUpperCase()
        font.pointSize: 10
        onEditingFinished: internal.setColor(`#${text}`)
      }
    }

    TabBar {
      id: bar
      Layout.fillWidth: true
      TabButton {
        text: qsTr("RGB")
      }
      TabButton {
        text: qsTr("HSV")
      }
    }

    StackLayout {
      Layout.fillWidth: true
      Layout.fillHeight: true
      currentIndex: bar.currentIndex

      RGBSlider {
        color: internal.color
        onColorChanged: internal.setColor(color)
        onEditFinished: {
          history.addToHistory(color)
        }
      }

      HSVSlider {
        color: internal.color
        onColorChanged: internal.setColor(color)
        onEditFinished: {
          history.addToHistory(color)
        }
      }
    }
  }
}
